; Properties
;-----------

(bare_key) @type

(quoted_key) @string

(pair
  (bare_key)) @property

(pair
  (dotted_key
    (bare_key) @property))

; Literals
;---------

(boolean) @variable.defaultLibrary

(comment) @comment

(string) @string

[
  (integer)
  (float)
] @number

[
  (offset_date_time)
  (local_date_time)
  (local_date)
  (local_time)
] @string.special

; Punctuation
;------------

[
  "."
  ","
] @operator.defaultLibrary.delimiter

"=" @operator

[
  "["
  "]"
  "[["
  "]]"
  "{"
  "}"
] @operator.defaultLibrary.bracket
