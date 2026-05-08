; start @operator.defaultLibrary.bracket.json (magenta fg, default bg)
[
  (json_array_literal
    [
      "["
      "]"
    ] @operator.defaultLibrary.bracket.json)
  (json_object_literal
    [
      "{"
      "}"
    ] @operator.defaultLibrary.bracket.json)
]

; end @operator.defaultLibrary.bracket.json
; start @function.method (maroon fg, yellow bg)
(tag) @function.method

; end @function.method (maroon fg, yellow bg)
; start method_arg @parameter
(method_arg) @parameter

(variadic_arg
  (lvn
    (objectscript_identifier) @parameter))

(method_arg
  (expression
    (expr_atom
      (lvn
        (objectscript_identifier) @parameter))))

; end method_arg @parameter
; start @variable.definition.defaultLibrary @keyword.directive @property.oref @enum.builtin (blue fg, default bg)
[
  (ssvn)
  (system_defined_variable)
  (system_defined_function)
  "$$"
] @variable.definition.defaultLibrary

[
  (keyword_pound_define)
  (keyword_pound_def1arg)
  (keyword_pound_if)
  (keyword_pound_elseif)
  (keyword_pound_else)
  (keyword_pound_endif)
  (keyword_pound_ifdef)
  (keyword_pound_ifndef)
  (keyword_dim)
  (keyword_pound_import)
  (keyword_pound_include)
  (keyword_pound_delay)
  (locktype)
  (tag_end_if)
] @keyword.directive

(macro_value) @enum.builtin

[
  (method_name)
  (property_name)
  (oref_parameter)
] @property.oref

; end @variable.definition.defaultLibrary @keyword.directive @property.oref @enum.builtin (blue fg, default bg)
; start @type.definition (purple fg)
[
  (keyword_embedded_html)
  (keyword_embedded_xml)
  (keyword_embedded_sql_amp)
  (keyword_embedded_sql_hash)
  (keyword_js)
  (sql_field_reference)
] @type.definition

; end  @type.definition (purple fg)
; local variable "maroon fg, light_cyan bg"
(lvn) @variable.definition

; end local variable
; start black fg, default bg @operator.defaultLibrary.special, @property, @number, @keyword.debug
[
  (embedded_js_special_case_complete)
  (embedded_sql_marker)
  (embedded_sql_reverse_marker)
  (html_marker)
  (html_marker_reversed)
  "@"
  ":"
  ","
  "="
  "'="
  ".."
  "..."
  "^"
  "+"
  "-"
  "|"
  (bracket)
  (binary_operator)
  "'?"
  "?"
  "<"
  ">"
  "/"
] @operator.defaultLibrary.special

[
  (json_number_literal)
  (numeric_literal)
] @number

[
  (keyword_trace)
  (keyword_on)
  (keyword_errortrap)
  (keyword_off)
  (keyword_interrupt)
  (zbreak_command_option)
  (keyword_clear)
  (keyword_all)
  (keyword_debug)
  (keyword_step)
  (keyword_nostep)
  (keyword_stepmethod)
  (keyword_ext)
  (keyword_destruct)
] @keyword.debug

[
  (instance_variable)
  (gvn)
  (macro_arg)
  (macro_def)
] @property

; end black fg, default bg @operator.defaultLibrary.special, @property, @number, @keyword.debug
; "Navy FG, Default BG" (Object (Class, super))
[
  (keyword_pound_pound_super)
  (keyword_pound_pound_class)
] @keyword.operator

; end "Navy FG, Default BG" (Object (Class, super))
; keyword names (red fg, default bg)
[
  (keyword_continue)
  (keyword_quit)
  (keyword_if)
  (keyword_elseif)
  (keyword_else)
  (keyword_oldelse)
  (old_else_remove)
  (keyword_throw)
  (keyword_try)
  (keyword_catch)
  (keyword_return)
  (keyword_break)
  (keyword_zbreak)
  (keyword_zkill)
  (keyword_ztrap)
  (keyword_zz)
  (keyword_as)
  (keyword_of)
  (keyword_public)
  (keyword_private)
  (keyword_methodimpl)
  (device_keywords)
  (close_parameter_option_value)
  (keyword_print)
  (keyword_zprint)
  (keyword_zn)
  (keyword_set)
  (keyword_write)
  (keyword_zwrite)
  (keyword_do)
  (keyword_for)
  (keyword_for_infinite)
  (keyword_old_for_no_params)
  (keyword_old_for_params)
  (keyword_while)
  (keyword_kill)
  (keyword_lock)
  (keyword_read)
  (keyword_open)
  (keyword_close)
  (keyword_use)
  (keyword_new)
  (keyword_job)
  (keyword_merge)
  (keyword_goto)
  (keyword_halt_or_hang)
  (keyword_halt)
  (keyword_hang)
  (keyword_tcommit)
  (keyword_trollback)
  (keyword_tstart)
  (keyword_xecute)
  (keyword_view)
  (keyword_zremove)
  (command_keyword)
  (keyword_zload)
  (keyword_do_old)
  (keyword_old_if)
  (old_if_remove)
  (keyword_old_if_refactor)
] @keyword

; end (red fg, default bg)
; macro (silver bg, blue fg)
(macro) @function.macro

; end macro (silver bg, blue fg)
; start (teal fg, default bg) @type.defaultLibrary
(class_ref
  (class_name) @type.defaultLibrary)

; end (teal fg, default bg) @type.defaultLibrary
; start comment (green fg, default bg)
[
  (line_comment_1)
  (line_comment_2)
  (line_comment_3)
  (line_comment_4)
  (block_comment)
] @comment 

; end (green fg, default bg)
; start string ("black fg, pink bg")
[
  (json_string_literal)
  (string_literal)
] @string

; end string ("black fg, pink bg")
; start brackets (purple fg, default bg)
[
  "{"
  "}"
  (bracket)
] @operator.defaultLibrary.bracket

; end brackets (purple fg, default bg)
; start @function.method (maroon fg, yellow bg)
(routine_name) @function.method

; end @function.method (maroon fg, yellow bg)
; start @string.regexp (olive fg, default bg)
(pattern_expression) @string.regexp

(keyword_zsu) @keyword.modifier

; start Dots in dotted statements, (black fg,silver bg)
(dotted_statement
  (dot) @operator.defaultLibrary.special.dots)

; end Dots in dotted statements (black fg,silver bg)
; start #dim command
; @type.defaultLibrary -> teal fg, default bg
; @property -> black fg, default bg
; @variable.definition -> maroon fg, light_cyan bg
(pound_dim
  (keyword_as)
  .
  (variable_datatype
    [
      (instance_variable)
      (macro)
      (objectscript_identifier)
      (objectscript_identifier_special)
    ] @type.defaultLibrary) @type.defaultLibrary)

(pound_dim
  (keyword_as)
  .
  (variable_datatype
    [
      (instance_variable)
      (macro)
      (objectscript_identifier)
      (objectscript_identifier_special)
    ] @property) @property
  .
  (keyword_of) @operator.defaultLibrary.special
  .
  (variable_datatype
    [
      (instance_variable)
      (macro)
      (objectscript_identifier)
      (objectscript_identifier_special)
    ] @type.defaultLibrary) @type.defaultLibrary)

(pound_dim
  (keyword_dim)
  [
    (objectscript_identifier)
    (objectscript_identifier_special)
  ] @variable.definition)

; end #dim command
; start write command/read command
; @operator.defaultLibrary.special -> black fg, default bg
[
  "!"
  "*"
  "?"
  (mnemonic_name)
  (read_fchar)
] @operator.defaultLibrary.special

; end write command/read command
; start lock command
; @operator.defaultLibrary.special -> black fg, default background
(command_lock_arguments_variant_1
  [
    "+"
    "-"
  ] @operator.defaultLibrary.special)

(command_lock_arguments_variant_2
  [
    "+"
    "-"
  ] @operator.defaultLibrary.special)

(locktype
  [
    "#"
    "_"
  ] @operator.defaultLibrary.special)

; end lock command
; read command # start (black fg, default bg)
(read_variable
  "#" @operator.defaultLibrary.special)

; read command # end
; start line_ref
; @function.method -> maroon fg, yellow bg
; @variable.definition ->  "maroon fg, light_cyan bg"
(line_ref
  [
    (objectscript_identifier)
    (objectscript_identifier_special)
  ] @function.method)

(line_ref
  [
    "+"
    "-"
  ] @operator.defaultLibrary.special
  .
  [
    (objectscript_identifier)
    (objectscript_identifier_special)
  ] @variable.definition)

; end line_ref
; start dollarsf
; @variable.definition -> maroon fg, light_cyan bg
; @property.oref ->  blue fg, default bg
(dollarsf
  [
    (objectscript_identifier)
    (objectscript_identifier_special)
  ] @type.defaultLibrary
  "."
  .
  [
    (objectscript_identifier)
    (objectscript_identifier_special)
  ] @property.oref)

; end dollarsf
; start extrinsic_function
(extrinsic_function
  [
    (objectscript_identifier)
    (objectscript_identifier_special)
  ] @function.method)

; end extrinsic_function
; start highlighting for code never touched
[
  (pound_if_special_case)
  (pound_if_special_case_else)
  (pound_if_special_case_else_if)
] @comment.inactive

; end highlighting for code never touched
; start zload command
; @function.method -> (maroon fg, yellow bg)
(command_zload
  (expression
    (expr_atom
      [
        (lvn
          (objectscript_identifier) @function.method)
        (lvn
          (objectscript_identifier_special) @function.method)
        (instance_variable) @function.method
        (oref_chain_expr
          [
            (lvn)
            (instance_variable)
          ] @function.method
          (oref_chain_segment
            (oref_property
              (property_name
                (identifier_segment_immediate) @function.method) @function.method)) @function.method)
      ] @function.method)))

; end zload command
; start #ifdef command
; @property -> black fg, default bg
(pound_ifdef
  (keyword_pound_ifdef)
  .
  (expression
    (expr_atom
      (lvn
        [
          (objectscript_identifier)
          (objectscript_identifier_special)
        ] @property))))

; end #ifdef command
; start #ifndef command
; @property -> black fg, default bg
(pound_ifndef
  (keyword_pound_ifndef)
  .
  (expression
    (expr_atom
      (lvn
        [
          (objectscript_identifier)
          (objectscript_identifier_special)
        ] @property))))

; end #ifdef command
; start #import command
; @property -> black fg, default bg
(pound_import
  (class_name) @property)

; end #import command
; start #include command
; @function.method -> (maroon fg, yellow bg)
(pound_include
  (class_name) @function.method)

; end #include command
(routine_type
  [
    "["
    "]"
  ] @operator.defaultLibrary.special) @keyword.operator

(routine) @keyword.type

(documatic_line) @comment 

(compiled_header) @comment.heading
