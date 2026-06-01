; From nvim-treesitter/nvim-treesitter
[
  (code_span)
  (link_title)
] @string.literal

[
  (emphasis_delimiter)
  (code_span_delimiter)
] @operator.defaultLibrary.delimiter

(emphasis) @string.emphasis

(strong_emphasis) @string.strong

[
  (link_destination)
  (uri_autolink)
] @string.uri

[
  (link_label)
  (link_text)
  (image_description)
] @string.reference

[
  (backslash_escape)
  (hard_line_break)
] @string.escape

(image
  [
    "!"
    "["
    "]"
    "("
    ")"
  ] @operator.defaultLibrary.delimiter)

(inline_link
  [
    "["
    "]"
    "("
    ")"
  ] @operator.defaultLibrary.delimiter)

(shortcut_link
  [
    "["
    "]"
  ] @operator.defaultLibrary.delimiter)

; NOTE: extension not enabled by default
; (wiki_link ["[" "|" "]"] @operator.defaultLibrary.delimiter)
