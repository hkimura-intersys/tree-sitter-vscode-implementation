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

[
  (class_body
    [
      "{"
      "}"
    ] @operator.defaultLibrary.special)
  (method_definition
    [
      "{"
      "}"
    ] @operator.defaultLibrary.special)
]

; end @operator.defaultLibrary.bracket.json
; start @function.method (maroon fg, yellow bg)
(tag) @function.method

; end @function.method (maroon fg, yellow bg)
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
  (oref_property)
  (oref_parameter)
] @property

(oref_method
  (method_name) @property)

(class_method_call
  (method_name) @property)

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
  (keyword_errortrap)
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
  (keyword_for)
  (keyword_while)
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
  (keyword_for_infinite)
  (keyword_old_for_no_params)
  (keyword_old_for_params)
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

; end @string.regexp (olive fg, default bg)
[
  (command_quit
    (keyword_quit) @keyword)
  (command_else
    [
      (keyword_oldelse)
      (old_else_remove)
    ] @keyword)
  (command_continue
    (keyword_continue) @keyword)
  (command_if
    [
      (keyword_old_if)
      (keyword_old_if_refactor)
      (old_if_remove)
    ] @keyword)
  (command_do
    (keyword_do_old) @keyword)
  (command_for
    [
      (keyword_for_infinite)
      (keyword_old_for_params)
      (keyword_old_for_no_params)
      (keyword_for)
    ] @keyword)
  (command_lock
    (keyword_lock) @keyword)
  (command_return
    (keyword_return) @keyword)
  (command_halt_or_hang
    (keyword_halt_or_hang) @keyword)
  (command_break
    (keyword_break) @keyword)
  (command_tcommit
    (keyword_tcommit) @keyword)
  (command_trollback
    (keyword_trollback) @keyword)
  (command_tstart
    (keyword_tstart) @keyword)
  (command_zbreak
    (keyword_zbreak) @keyword)
] @comment

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
  ] @property)

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
; === END CORE ===
; === BEGIN LOCAL ===
(iris_username) @property

[
  (keyword_import)
  (keyword_include)
  (keyword_includegenerator)
  (keyword_class)
  (keyword_method)
  (keyword_classmethod)
  (class_extends)
  (keyword_xdata)
  (keyword_query)
  (keyword_foreignkey)
  (keyword_index)
  (keyword_property)
  (keyword_projection)
  (keyword_relationship)
  (keyword_parameter)
  (keyword_references)
  (keyword_trigger)
  (keyword_storage)
] @keyword.type

(class_definition
  (class_name) @keyword.type)

;start brackets representing keywords
;@operator.defaultLibrary.special -> black fg, default bg
(query_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(class_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(query_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(property_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(parameter_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(method_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(foreignkey_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(index_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(extent_index_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(call_method_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(projection_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(relationship_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(expression_method_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(external_method_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(xdata_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(storage_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

(trigger_keywords
  [
    "["
    "]"
  ] @operator.defaultLibrary.special)

; end brackets representing keywords
(class_keyword
  (_
    [
      "{"
      "}"
    ] @operator.defaultLibrary.special))

(class_keyword_owner
  [
    "{"
    "}"
  ] @operator.defaultLibrary.special)

(documatic_line) @comment.documentation 

; start keywords
; @keyword.operator -> navy fg, default bg
; 
[
  (xdata_keyword)
  (class_keyword)
  (method_keyword)
  (expression_method_keywords)
  (call_method_keywords)
  (external_method_keywords)
  (foreignkey_keyword)
  (index_keyword)
  (index_keyword_extent)
  (keyword_byref)
  (keyword_output)
  (parameter_keyword)
  (property_keyword)
  (projection_keyword)
  (relationship_keyword)
  (query_keyword)
  (trigger_keyword)
] @keyword.operator

(property_keyword
  (_
    (query_name) @property))

(query_keyword
  (_
    (query_name) @property))

(class_keyword
  (_
    (query_name) @property))

(index_keyword
  (_
    (query_name) @property))

(method_keyword
  (_
    (query_name) @property))

(trigger_keyword
  (_
    (query_name) @property))

(class_keyword
  (_
    [
      (property_name)
      (typename)
      (storage_name)
    ] @type.definition))

(query_keyword
  (_
    [
      (property_name)
      (typename)
    ] @type.definition))

(relationship_keyword
  (_
    [
      (variable_datatype)
      (typename)
    ] @type.definition))

(method_keyword
  (_
    [
      (property_name)
      (typename)
      (xml_identifier)
    ] @type.definition))

(method_keyword_external_proc_name
  (objectscript_identifier) @type.definition)

(parameter_keyword
  (_
    [
      (typename)
      (keyword_list)
    ] @type.definition))

(trigger_keyword
  (_
    [
      (typename)
      (trigger_event_value)
    ] @type.definition))

(property_keyword
  (_
    (typename) @type.definition))

(property_keyword_aliases
  (property_name) @property)

(foreignkey_keyword
  (_
    (typename) @type.definition))

(foreignkey_keyword
  (_
    (query_name) @property))

(expression_method_keywords
  (_
    (typename) @type.definition))

(call_method_keywords
  (_
    (typename) @type.definition))

(external_method_keywords
  (_
    (typename) @type.definition))

(method_keyword
  (_
    (method_name) @property))

; start class member names
; @property -> black fg, default bg
(method_definition
  (method_name) @property)

(xdata
  (xdata_name) @property)

(property
  (property_name) @property)

(parameter
  (parameter_name) @property)

(relationship
  (relationship_name) @property)

(query
  (query_name) @property)

(foreignkey
  [
    (foreignkey_name)
    (property_name)
    (index_name)
  ] @property)

(index
  (index_name) @property)

(projection
  (projection_name) @property)

(trigger
  (trigger_name) @property)

(storage
  (storage_name) @property)

; end class member names
(foreignkey
  (class_name) @keyword.type)

(xdata_keyword
  (_
    (typename) @type.definition))

(xdata_keyword_mimetype
  (typename) @type.definition) @keyword.operator

; start return_type @keyword.type
(return_type) @keyword.type

; end return_type
; start method_arg @parameter
(method_arg) @parameter

(method_arg
  (lvn
    (objectscript_identifier) @parameter))

(method_arg
  (expr_atom
    (lvn
      (objectscript_identifier) @parameter)))

; end method_arg @parameter
; END LOCAL
; start Include, Import, Includegenerator
(import_code
  (include_clause
    (class_name) @keyword.type))

(include_code
  (include_clause
    (class_name) @keyword.type))

(include_generator
  (include_clause
    (class_name) @keyword.type))

; end Include, Import, Includegenerator
; start index
(index
  (keyword_on) @keyword.operator
  (index_properties
    (index_item) @property))

(index
  ";" @operator.defaultLibrary.special)

(index_properties
  [
    "("
    ")"
  ] @operator.defaultLibrary.special)

; end index
; start parameter
(parameter
  ";" @operator.defaultLibrary.special)

(parameter_type
  (keyword_as) @keyword.operator) @property

; end parameter
; start property
(property
  ";" @operator.defaultLibrary.special)

; end property
; start projection
(projection
  ";" @operator.defaultLibrary.special)

; end projection
;start relationship
(relationship
  ";" @operator.defaultLibrary.special)

; end relationship
(default_argument_value) @type.definition

; start routine
(routine_type
  [
    "["
    "]"
  ] @operator.defaultLibrary.special) @keyword.operator

(routine) @keyword.type

; end routine
