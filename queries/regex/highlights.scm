[
  "("
  ")"
  "(?"
  "(?:"
  "(?<"
  "(?P<"
  "(?P="
  ">"
  "["
  "]"
  "{"
  "}"
  "[:"
  ":]"
] @operator.defaultLibrary.bracket

(group_name) @property

[
  (identity_escape)
  (control_letter_escape)
  (character_class_escape)
  (control_escape)
  (start_assertion)
  (end_assertion)
  (boundary_assertion)
  (non_boundary_assertion)
] @string

[
  "*"
  "+"
  "?"
  "|"
  "="
  "!"
] @operator

(count_quantifier
  [
    (decimal_digits) @number
    "," @operator.defaultLibrary.delimiter
  ])

(inline_flags_group
  "-"? @operator
  ":"? @operator.defaultLibrary.delimiter)

(flags) @string.special

(character_class
  [
    "^" @operator
    (class_range "-" @operator)
  ])

[
  (class_character)
  (posix_class_name)
] @enum.character

(pattern_character) @string
