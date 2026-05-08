import * as fs from "fs";
import path from "path";
import * as vscode from "vscode";
import * as ts from "web-tree-sitter";
import { Parser } from "web-tree-sitter";

const OUTPUT_CHANNEL = vscode.window.createOutputChannel("tree-sitter-vscode-implementation");

// VSCode default token types and modifiers from:
// https://code.visualstudio.com/api/language-extensions/semantic-highlight-guide#standard-token-types-and-modifiers
const TOKEN_TYPES = [
  "namespace",
  "class",
  "enum",
  "interface",
  "struct",
  "typeParameter",
  "type",
  "parameter",
  "variable",
  "property",
  "enumMember",
  "decorator",
  "event",
  "function",
  "method",
  "macro",
  "label",
  "comment",
  "string",
  "keyword",
  "number",
  "regexp",
  "operator",
];
const TOKEN_MODIFIERS = [
  "declaration",
  "definition",
  "readonly",
  "static",
  "deprecated",
  "abstract",
  "async",
  "modification",
  "documentation",
  "defaultLibrary",
];
const LEGEND = new vscode.SemanticTokensLegend(TOKEN_TYPES, TOKEN_MODIFIERS);

const LANGUAGE_CONFIGS = [
  {
    lang: "xml",
    parser: "parsers/tree-sitter-xml.wasm",
    highlights: "queries/xml/highlights.scm",
    injections: "queries/xml/injections.scm",
    injectionOnly: false,
  },
  {
    lang: "toml",
    parser: "parsers/tree-sitter-toml.wasm",
    highlights: "queries/toml/highlights.scm",
    injectionOnly: false,
  },
  {
    lang: "markdown_inline",
    parser: "parsers/tree-sitter-markdown_inline.wasm",
    highlights: "queries/markdown_inline/highlights.scm",
    injections: "queries/markdown_inline/injections.scm",
    injectionOnly: true,
  },
  {
    lang: "jsdoc",
    parser: "parsers/tree-sitter-jsdoc.wasm",
    highlights: "queries/jsdoc/highlights.scm",
    injectionOnly: true,
  },
  {
    lang: "css",
    parser: "parsers/tree-sitter-css.wasm",
    highlights: "queries/css/highlights.scm",
    injectionOnly: true,
  },
  {
    lang: "sql",
    parser: "parsers/tree-sitter-sql.wasm",
    highlights: "queries/sql/highlights.scm",
    injectionOnly: false,
  },
  {
    lang: "regex",
    parser: "parsers/tree-sitter-regex.wasm",
    highlights: "queries/regex/highlights.scm",
    injectionOnly: true,
  },
  {
    lang: "javascript",
    parser: "parsers/tree-sitter-javascript.wasm",
    highlights: "queries/javascript/highlights.scm",
    injections: "queries/javascript/injections.scm",
    injectionOnly: false,
  },
  {
    lang: "html",
    parser: "parsers/tree-sitter-html.wasm",
    highlights: "queries/html/highlights.scm",
    injections: "queries/html/injections.scm",
    injectionOnly: false,
  },
  {
    lang: "yaml",
    parser: "parsers/tree-sitter-yaml.wasm",
    highlights: "queries/yaml/highlights.scm",
    injectionOnly: false,
  },
  {
    lang: "json",
    parser: "parsers/tree-sitter-json.wasm",
    highlights: "queries/json/highlights.scm",
    injectionOnly: false,
  },
  {
    lang: "python",
    parser: "parsers/tree-sitter-python.wasm",
    highlights: "queries/python/highlights.scm",
    injectionOnly: false,
  },
  {
    lang: "markdown",
    parser: "parsers/tree-sitter-markdown.wasm",
    highlights: "queries/markdown/highlights.scm",
    injections: "queries/markdown/injections.scm",
    injectionOnly: false,
  },
  {
    lang: "objectscript_routine",
    parser: "parsers/tree-sitter-objectscript_routine.wasm",
    highlights: "queries/objectscript_routine/highlights.scm",
    injections: "queries/objectscript_routine/injections.scm",
    injectionOnly: false,
  },
  {
    lang: "objectscript",
    parser: "parsers/tree-sitter-objectscript.wasm",
    highlights: "queries/objectscript/highlights.scm",
    injections: "queries/objectscript/injections.scm",
    injectionOnly: true,
  },
  {
    lang: "objectscript_udl",
    parser: "parsers/tree-sitter-objectscript_udl.wasm",
    highlights: "queries/objectscript_udl/highlights.scm",
    injections: "queries/objectscript_udl/injections.scm",
    injectionOnly: false,
  },
  
] satisfies Config[];

function resolveBundledConfigs(context: vscode.ExtensionContext): Config[] {
  
  return LANGUAGE_CONFIGS.map((config) => ({
    ...config,
    parser: context.asAbsolutePath(config.parser),
    highlights: context.asAbsolutePath(config.highlights),
    injections: config.injections
      ? context.asAbsolutePath(config.injections)
      : undefined,
  }));
}

type SemanticTokenTypeMapping = {
  targetTokenType: string;
  targetTokenModifiers?: string[];
};
type Config = {
  lang: string;
  parser: string;
  highlights: string;
  injections?: string;
  injectionOnly: boolean;
  semanticTokenTypeMappings?: Record<string, SemanticTokenTypeMapping>;
};
type Language = {
  parser: Parser;
  highlightQuery: ts.Query;
  injectionQuery?: ts.Query;
  semanticTokenTypeMappings?: Record<string, SemanticTokenTypeMapping>;
};
type Token = {
  range: vscode.Range;
  type: string;
  modifiers: string[];
};
type Injection = {
  range: vscode.Range;
  tokens: Token[];
};

function log(messageOrCallback: string | (() => string), data?: unknown) {
  // Only log in debug mode
  const config = vscode.workspace.getConfiguration("tree-sitter-vscode-implementation");
  const isDebugMode = config.get("debug", false);

  if (isDebugMode) {
    const timestamp = new Date().toISOString();
    const message =
      typeof messageOrCallback === "function"
        ? messageOrCallback()
        : messageOrCallback;
    OUTPUT_CHANNEL.appendLine(`[${timestamp}] ${message}`);
    if (data) {
      OUTPUT_CHANNEL.appendLine(JSON.stringify(data, null, 2));
    }
  }
}

/**
 * Called once on extension initialization and again if the reload command is triggered.
 * It reads the configuration and registers the semantic tokens provider.
 */
export function activate(context: vscode.ExtensionContext) {
  log("Extension activated");

  const configs = resolveBundledConfigs(context);
  log(() => `Configured languages: ${configs.map((c) => c.lang).join(", ")}`);
  const cache = new LanguageCache(configs);
  const languageMap = configs
    .filter((config) => !config.injectionOnly)
    .map((config) => {
      return { language: config.lang };
    });
  const provider = vscode.languages.registerDocumentSemanticTokensProvider(
    languageMap,
    new SemanticTokensProvider(cache),
    LEGEND,
  );
  context.subscriptions.push(provider);

  // setup the selection range provider
  const selectionProvider = vscode.languages.registerSelectionRangeProvider(
    languageMap,
    new SelectionRangeProvider(cache),
  );
  context.subscriptions.push(selectionProvider);

  // setup incremental parsing listeners
  const onDidChange = vscode.workspace.onDidChangeTextDocument((event) => {
    cache.applyEdits(event);
  });
  context.subscriptions.push(onDidChange);
  const onDidClose = vscode.workspace.onDidCloseTextDocument((document) => {
    cache.removeDocument(document.uri);
  });
  context.subscriptions.push(onDidClose);

  // setup the reload command
  const reload = vscode.commands.registerCommand(
    "tree-sitter-vscode-implementation.reload",
    () => {
      // dispose of the old providers and clear the list of subscriptions
      reload.dispose();
      provider.dispose();
      selectionProvider.dispose();
      onDidChange.dispose();
      onDidClose.dispose();
      context.subscriptions.length = 0;
      // reinitialize the extension
      activate(context);
    },
  );
  context.subscriptions.push(reload);
}

/**
 * Called when the extension is deactivated.
 */
export function deactivate() {
  /* empty */
}

class LanguageCache {
  readonly configs: Config[];
  private tsLangs: Record<string, Language> = {};
  private trees = new Map<string, ts.Tree>();

  constructor(configs: Config[]) {
    this.configs = configs;
  }

  async getLanguage(lang: string): Promise<Language | undefined> {
    if (!(lang in this.tsLangs)) {
      const config = this.configs.find((config) => config.lang === lang);
      if (config === undefined) {
        return undefined;
      }
      this.tsLangs[lang] = await initLanguage(config);
    }
    return this.tsLangs[lang];
  }

  /**
   * Returns a syntax tree for the document, using incremental parsing when possible.
   * The returned tree is a copy safe for the caller to use without interference
   * from subsequent edits.
   */
  getTree(document: vscode.TextDocument): ts.Tree | null {
    const lang = this.tsLangs[document.languageId];
    if (!lang) return null;

    const uri = document.uri.toString();
    const cached = this.trees.get(uri);
    if (cached) {
      return cached.copy();
    }

    const tree = lang.parser.parse(document.getText());
    if (tree) {
      this.trees.set(uri, tree);
    }
    return tree;
  }

  /**
   * Applies document edits to the cached tree and re-parses incrementally.
   * Changes are applied in reverse document order so positions remain valid.
   */
  applyEdits(event: vscode.TextDocumentChangeEvent): void {
    const uri = event.document.uri.toString();
    const tree = this.trees.get(uri);
    if (!tree) return;

    const lang = this.tsLangs[event.document.languageId];
    if (!lang) return;

    const changes = [...event.contentChanges].sort(
      (a, b) => b.rangeOffset - a.rangeOffset,
    );

    for (const change of changes) {
      const startPosition: ts.Point = {
        row: change.range.start.line,
        column: change.range.start.character,
      };
      const oldEndPosition: ts.Point = {
        row: change.range.end.line,
        column: change.range.end.character,
      };
      const newLines = change.text.split("\n");
      const newEndPosition: ts.Point = {
        row: startPosition.row + newLines.length - 1,
        column:
          newLines.length === 1
            ? startPosition.column + newLines[0].length
            : newLines[newLines.length - 1].length,
      };

      tree.edit(
        new ts.Edit({
          startIndex: change.rangeOffset,
          oldEndIndex: change.rangeOffset + change.rangeLength,
          newEndIndex: change.rangeOffset + change.text.length,
          startPosition,
          oldEndPosition,
          newEndPosition,
        }),
      );
    }

    const newTree = lang.parser.parse(event.document.getText(), tree);
    if (newTree) {
      this.trees.set(uri, newTree);
    }
  }

  removeDocument(uri: vscode.Uri): void {
    this.trees.delete(uri.toString());
  }
}

async function initLanguage(config: Config): Promise<Language> {
  log(() => {
    return `Initializing language: ${config.lang}`;
  });
  await Parser.init().catch();
  const parser = new Parser();
  const lang = await ts.Language.load(config.parser);
  log(`Tree-Sitter ABI version for ${config.lang} is ${lang.abiVersion}.`);
  parser.setLanguage(lang);
  const queryText = fs.readFileSync(config.highlights, "utf-8");
  const highlightQuery = new ts.Query(lang, queryText);
  let injectionQuery = undefined;
  if (config.injections !== undefined) {
    const injectionText = fs.readFileSync(config.injections, "utf-8");
    log(() => `Loaded injections for ${config.lang} from ${config.injections}`);
    log(() => `Injection query length for ${config.lang}: ${injectionText.length}`);
    injectionQuery = new ts.Query(lang, injectionText);
  }
  return {
    parser,
    highlightQuery,
    injectionQuery,
    semanticTokenTypeMappings: config.semanticTokenTypeMappings,
  };
}

function convertPosition(pos: ts.Point): vscode.Position {
  return new vscode.Position(pos.row, pos.column);
}

function addPosition(range: vscode.Range, pos: vscode.Position): vscode.Range {
  const start =
    range.start.line == 0
      ? new vscode.Position(
          range.start.line + pos.line,
          range.start.character + pos.character,
        )
      : new vscode.Position(range.start.line + pos.line, range.start.character);
  const end =
    range.end.line == 0
      ? new vscode.Position(
          range.end.line + pos.line,
          range.end.character + pos.character,
        )
      : new vscode.Position(range.end.line + pos.line, range.end.character);
  return new vscode.Range(start, end);
}

function parseCaptureName(name: string): { type: string; modifiers: string[] } {
  const parts = name.split(".");
  if (parts.length === 0) {
    throw new Error("Capture name is empty.");
  } else if (parts.length === 1) {
    return { type: parts[0], modifiers: [] };
  } else {
    return { type: parts[0], modifiers: parts.slice(1) };
  }
}

/**
 * Semantic tokens cannot span multiple lines,
 * so if the range doesn't end in the same line,
 * one token for each line is created.
 */
function splitToken(token: Token): Token[] {
  const start = token.range.start;
  const end = token.range.end;
  if (start.line != end.line) {
    // 100_0000 is chosen as the arbitrary length, since the actual line length is unknown.
    // Choosing a big number works, while `Number.MAX_VALUE` seems to confuse VSCode.
    const maxLineLength = 100_000;
    const lineDiff = end.line - start.line;
    if (lineDiff < 0) {
      throw new RangeError("Invalid token range");
    }
    const tokens: Token[] = [];
    // token for the first line, beginning at the start char
    tokens.push({
      range: new vscode.Range(
        start,
        new vscode.Position(start.line, maxLineLength),
      ),
      type: token.type,
      modifiers: token.modifiers,
    });
    // tokens for intermediate lines, spanning from 0 to maxLineLength
    for (let i = 1; i < lineDiff; i++) {
      const middleToken: Token = {
        range: new vscode.Range(
          new vscode.Position(start.line + i, 0),
          new vscode.Position(start.line + i, maxLineLength),
        ),
        type: token.type,
        modifiers: token.modifiers,
      };
      tokens.push(middleToken);
    }
    // token for the last line, ending at the end char
    tokens.push({
      range: new vscode.Range(new vscode.Position(end.line, 0), end),
      type: token.type,
      modifiers: token.modifiers,
    });
    return tokens;
  } else {
    return [token];
  }
}

class SemanticTokensProvider implements vscode.DocumentSemanticTokensProvider {
  private readonly cache: LanguageCache;

  constructor(cache: LanguageCache) {
    this.cache = cache;
  }

  /**
   * Called regularly by VSCode to provide semantic tokens for the given document.
   * It parses the document with the corresponding language parser and returns the tokens.
   */
  async provideDocumentSemanticTokens(
    document: vscode.TextDocument,
    token: vscode.CancellationToken,
  ) {
    const tsLang = await this.cache.getLanguage(document.languageId);
    if (tsLang === undefined) {
      throw new Error("No config for lang provided.");
    }
    const tree = this.cache.getTree(document);
    if (tree === null) {
      throw new Error("Failed to parse document.");
    }
    const tokens = await this.parseToTokens(tsLang, tree, {
      row: 0,
      column: 0,
    });
    const builder = new vscode.SemanticTokensBuilder(LEGEND);
    tokens.forEach((token) =>
      builder.push(token.range, token.type, token.modifiers),
    );
    return builder.build();
  }

  /**
   * Returns the highlighting tokens for the given syntax tree.
   * Calls `getInjections` for nested injections.
   */
  async parseToTokens(
    lang: Language,
    tree: ts.Tree,
    startPosition: ts.Point,
  ): Promise<Token[]> {
    const { highlightQuery, injectionQuery } = lang;
    const matches = highlightQuery.matches(tree.rootNode);
    log(() => `Highlight matches: ${matches.length}, has injection query: ${injectionQuery !== undefined}`);
    let tokens = this.matchesToTokens(lang, matches);
    if (injectionQuery !== undefined) {
      const injections = await this.getInjections(
        injectionQuery,
        tree.rootNode,
      );
      // merge the injection tokens with the main tokens
      for (const injection of injections) {
        if (injection.tokens.length > 0) {
          const range = injection.range;
          tokens = tokens
            // remove all tokens that are contained in an injection
            .filter((token) => !range.contains(token.range))
            // split tokens that are partially contained in an injection
            .flatMap((token) => {
              if (token.range.intersection(range) !== undefined) {
                const newTokens: Token[] = [];
                if (token.range.start.isBefore(range.start)) {
                  const before = new vscode.Range(
                    token.range.start,
                    range.start,
                  );
                  newTokens.push({ ...token, range: before });
                }
                if (token.range.end.isAfter(range.end)) {
                  const after = new vscode.Range(range.end, token.range.end);
                  newTokens.push({ ...token, range: after });
                }
                return newTokens;
              } else {
                return [token];
              }
            });
        }
      }
      tokens = tokens.concat(
        injections.map((injection) => injection.tokens).flat(),
      );
    }
    tokens = tokens.map((token) => {
      return {
        ...token,
        range: addPosition(token.range, convertPosition(startPosition)),
      };
    });
    return tokens;
  }

  matchesToTokens(lang: Language, matches: ts.QueryMatch[]): Token[] {
    const unsplitTokens: Token[] = matches
      .flatMap((match) => match.captures)
      .flatMap((capture) => {
        // Store the original capture name before splitting
        const originalCaptureName = capture.name;
        let { type, modifiers: modifiers } = parseCaptureName(capture.name);
        const start = convertPosition(capture.node.startPosition);
        const end = convertPosition(capture.node.endPosition);

        // First check if we have a mapping for the original unsplit name
        if (
          lang.semanticTokenTypeMappings &&
          Object.prototype.hasOwnProperty.call(
            lang.semanticTokenTypeMappings,
            originalCaptureName,
          )
        ) {
          const mapping = lang.semanticTokenTypeMappings[originalCaptureName];

          type = mapping.targetTokenType;
          modifiers = mapping.targetTokenModifiers ?? [];

          log(() => {
            return `Applied type mapping for original name: ${originalCaptureName} → ${mapping.targetTokenType}${
              mapping.targetTokenModifiers &&
              mapping.targetTokenModifiers.length > 0
                ? ` with modifiers: ${mapping.targetTokenModifiers.join(", ")}`
                : ""
            }`;
          });
        }
        // If no mapping for the full name, check for just the type
        else if (
          lang.semanticTokenTypeMappings &&
          Object.prototype.hasOwnProperty.call(
            lang.semanticTokenTypeMappings,
            type,
          )
        ) {
          const mapping = lang.semanticTokenTypeMappings[type];

          type = mapping.targetTokenType;
          modifiers = mapping.targetTokenModifiers ?? [];

          log(() => {
            return `Applied type mapping for base type: ${type} → ${mapping.targetTokenType}${
              mapping.targetTokenModifiers &&
              mapping.targetTokenModifiers.length > 0
                ? ` with modifiers: ${mapping.targetTokenModifiers.join(", ")}`
                : ""
            }`;
          });
        }

        if (TOKEN_TYPES.includes(type)) {
          const validModifiers = modifiers.filter((modifier) =>
            TOKEN_MODIFIERS.includes(modifier),
          );
          const token: Token = {
            range: new vscode.Range(start, end),
            type: type,
            modifiers: validModifiers,
          };
          return token;
        } else {
          return [];
        }
      });

    return unsplitTokens
      .flatMap((token) => {
        // Get all tokens contained within this token
        const contained = unsplitTokens.filter(
          (t) => !token.range.isEqual(t.range) && token.range.contains(t.range),
        );

        if (contained.length > 0) {
          // Sort contained tokens by their start position
          const sortedContained = contained.sort((a, b) =>
            a.range.start.compareTo(b.range.start),
          );

          const resultTokens = [];
          let currentPos = token.range.start;

          // Create tokens for the gaps between contained tokens
          for (const containedToken of sortedContained) {
            // If there's a gap before this contained token, create a token for it
            if (currentPos.compareTo(containedToken.range.start) < 0) {
              resultTokens.push({
                ...token,
                range: new vscode.Range(currentPos, containedToken.range.start),
              });
            }
            currentPos = containedToken.range.end;
          }

          // Add token for the gap after the last contained token if needed
          if (currentPos.compareTo(token.range.end) < 0) {
            resultTokens.push({
              ...token,
              range: new vscode.Range(currentPos, token.range.end),
            });
          }

          return resultTokens;
        } else {
          return token;
        }
      })
      .flatMap(splitToken);
  }
  
  /**
   * Get the injection range and tokens for a specific match.
   */
  async getInjection(match: ts.QueryMatch): Promise<Injection | null> {
    // determine language
    const {
      "injection.language": injectionLanguage,
      // TODO: add support for self and parent injections
      // "injection.self": injectionSelf,
      // "injection.parent": injectionParent
    } = match.setProperties || {};
    // the language is hard coded by "set!"
    const hardCoded =
      typeof injectionLanguage == "string" ? injectionLanguage : undefined;
    // dynamically determined language
    const dynamic = match.captures.find(
      (capture) => capture.name === "injection.language",
    )?.node.text;
    // custom language determination by capture name
    const name = match.captures.find((capture) =>
      this.cache.configs.map((config) => config.lang).includes(capture.name),
    )?.name;

    const lang = hardCoded || dynamic || name;
    if (lang === undefined) return null;

    // determine capture
    const injectionContent = match.captures.find(
      (capture) => capture.name === "injection.content",
    );
    let capture = undefined;
    if (hardCoded !== undefined) {
      capture = injectionContent;
    } else if (dynamic !== undefined) {
      capture = injectionContent;
    } else if (name !== undefined) {
      capture = match.captures.find((capture) => capture.name === name);
    }
    if (capture === undefined) return null;

    // get language config
    const langConfig = await this.cache.getLanguage(lang);
    if (langConfig === undefined) return null;

    const injectionTree = langConfig.parser.parse(capture.node.text);
    if (injectionTree === null) return null;
    const tokens = await this.parseToTokens(
      langConfig,
      injectionTree,
      capture.node.startPosition,
    );
    const range = new vscode.Range(
      convertPosition(capture.node.startPosition),
      convertPosition(capture.node.endPosition),
    );
    return { range, tokens };
  }

  /**
   * Matches the given injection query against the given node and returns the highlighting tokens.
   * This also works for nested injections.
   */
  async getInjections(
    injectionQuery: ts.Query,
    node: ts.Node,
  ): Promise<Injection[]> {
    const matches = injectionQuery.matches(node);
    log(() => `Injection query produced ${matches.length} match(es)`);
    const injections = matches.map(
      async (match) => await this.getInjection(match),
    );
    return (await Promise.all(injections)).filter(
      (injection): injection is Injection => injection !== null,
    );
  }
}

class SelectionRangeProvider implements vscode.SelectionRangeProvider {
  private readonly cache: LanguageCache;

  constructor(cache: LanguageCache) {
    this.cache = cache;
  }

  async provideSelectionRanges(
    document: vscode.TextDocument,
    positions: vscode.Position[],
    token: vscode.CancellationToken,
  ): Promise<vscode.SelectionRange[]> {
    await this.cache.getLanguage(document.languageId);
    const tree = this.cache.getTree(document);
    if (tree === null) {
      return [];
    }

    return positions
      .map((position) => {
        const tsPoint: ts.Point = {
          row: position.line,
          column: position.character,
        };
        let node: ts.Node | null = tree.rootNode.descendantForPosition(tsPoint);

        // Collect ranges from innermost to outermost, skipping duplicates
        const ranges: vscode.Range[] = [];
        while (node !== null) {
          const range = new vscode.Range(
            convertPosition(node.startPosition),
            convertPosition(node.endPosition),
          );
          if (
            ranges.length === 0 ||
            !range.isEqual(ranges[ranges.length - 1])
          ) {
            ranges.push(range);
          }
          node = node.parent;
        }

        // Build the chain from outermost to innermost so that
        // each SelectionRange's parent is the next larger range
        let selectionRange: vscode.SelectionRange | undefined;
        for (let i = ranges.length - 1; i >= 0; i--) {
          selectionRange = new vscode.SelectionRange(ranges[i], selectionRange);
        }

        return selectionRange;
      })
      .filter((selectionRange) => selectionRange !== undefined);
  }
}
