# tree-sitter-vscode-implementation

This extension builds off of [tree-sitter-vscode](https://github.com/AlecGhost/tree-sitter-vscode) to add tree-sitter based syntax highlighting to vscode for many common languages. 

## Languages Supported 
### Languages fully supported (with file detection, and as injections)
1. Xml (`.xml`)
2. Python (`.py`)
3. Json (`.json`)
4. Markdown(`.md`)
5. Yaml (`.yml`, `.yaml`)
6. ObjectScript UDL (`.cls`)
7. Sql (`.sql`)
8. Toml (`.toml`)
9. ObjectScript Routines (`.mac`, `.rtn`, `.inc`, `.int`)
10. JavaScript (`.js`)
11. Html (`.html`)

### Languages supported as Injections only 
1. Jsdoc
2. Css
3. Markdown_inline
4. ObjectScript Playground mode
5. TSql (partial support)
6. ISpl (partial support)
7. Regex

## Changes from Tree-Sitter to VSCode 

I had to change some captures to different names that are allowed with [VSCode Semantic Tokens](https://code.visualstudio.com/api/language-extensions/semantic-highlight-guide#semantic-token-classification)

These are the changes from the tree-sitter capture -> vscode name: 

```
@attribute -> @typeParameter
@constant -> @enum
@boolean -> @string
@character -> @string
@conditional -> @keyword
@constructor -> @struct
@embedded -> @enumMember
@error -> @keyword
@escape -> @string
@field -> @property
@float -> @number
@glimmer -> @number
@markup -> @comment 
@import -> @keyword
@markup -> @comment
@punctuation -> @operator.defaultLibrary 
@storageclass -> @keyword 
@spell -> removed 
@none -> @comment
@tag -> @function.method
@type.builtin -> @type.defaultLibrary
```

