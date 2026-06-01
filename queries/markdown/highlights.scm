;From nvim-treesitter/nvim-treesitter
(atx_heading
  (inline) @string.title)

(setext_heading
  (paragraph) @string.title)

[
  (atx_h1_marker)
  (atx_h2_marker)
  (atx_h3_marker)
  (atx_h4_marker)
  (atx_h5_marker)
  (atx_h6_marker)
  (setext_h1_underline)
  (setext_h2_underline)
] @operator.defaultLibrary.special

[
  (link_title)
  (indented_code_block)
  (fenced_code_block)
] @string.literal

(fenced_code_block_delimiter) @operator.defaultLibrary.delimiter

(code_fence_content) @comment

(link_destination) @string.uri

(link_label) @string.reference

[
  (list_marker_plus)
  (list_marker_minus)
  (list_marker_star)
  (list_marker_dot)
  (list_marker_parenthesis)
  (thematic_break)
] @operator.defaultLibrary.special

[
  (block_continuation)
  (block_quote_marker)
] @operator.defaultLibrary.special

(backslash_escape) @string.escape
