cwlVersion: v1.2
class: CommandLineTool
baseCommand: yasm
label: yasm
doc: "Assemble source files into object files.\n\nTool homepage: https://github.com/yasm/yasm"
inputs:
  - id: input_file
    type:
      type: array
      items: File
    doc: Assembly source files to be assembled.
    inputBinding:
      position: 1
  - id: add_include_path
    type:
      - 'null'
      - Directory
    doc: add include path
    inputBinding:
      position: 102
      prefix: -i
  - id: add_include_path_upper
    type:
      - 'null'
      - Directory
    doc: add include path
    inputBinding:
      position: 102
      prefix: -I
  - id: arch_short
    type:
      - 'null'
      - string
    doc: select architecture (list with -a help)
    inputBinding:
      position: 102
      prefix: -a
  - id: architecture
    type:
      - 'null'
      - string
    doc: select architecture (list with -a help)
    inputBinding:
      position: 102
      prefix: --arch
  - id: debug_format
    type:
      - 'null'
      - string
    doc: select debugging format (list with -g help)
    inputBinding:
      position: 102
      prefix: --dformat
  - id: debug_format_short
    type:
      - 'null'
      - string
    doc: select debugging format (list with -g help)
    inputBinding:
      position: 102
      prefix: -g
  - id: enable_disable_warnings
    type:
      - 'null'
      - boolean
    doc: enables/disables warning
    inputBinding:
      position: 102
      prefix: -W
  - id: error_warning_style
    type:
      - 'null'
      - string
    doc: select error/warning message style (`gnu' or `vc')
    inputBinding:
      position: 102
      prefix: -X
  - id: force_strict
    type:
      - 'null'
      - boolean
    doc: treat all sized operands as if `strict' was used
    inputBinding:
      position: 102
      prefix: --force-strict
  - id: list_file
    type:
      - 'null'
      - File
    doc: name of list-file output
    inputBinding:
      position: 102
      prefix: --list
  - id: list_file_short
    type:
      - 'null'
      - File
    doc: name of list-file output
    inputBinding:
      position: 102
      prefix: -l
  - id: list_format
    type:
      - 'null'
      - string
    doc: select list format (list with -L help)
    inputBinding:
      position: 102
      prefix: --lformat
  - id: list_format_short
    type:
      - 'null'
      - string
    doc: select list format (list with -L help)
    inputBinding:
      position: 102
      prefix: -L
  - id: machine
    type:
      - 'null'
      - string
    doc: select machine (list with -m help)
    inputBinding:
      position: 102
      prefix: --machine
  - id: machine_short
    type:
      - 'null'
      - string
    doc: select machine (list with -m help)
    inputBinding:
      position: 102
      prefix: -m
  - id: makefile_dependencies
    type:
      - 'null'
      - boolean
    doc: generate Makefile dependencies on stdout
    inputBinding:
      position: 102
      prefix: -M
  - id: no_warnings
    type:
      - 'null'
      - boolean
    doc: inhibits warning messages
    inputBinding:
      position: 102
      prefix: -w
  - id: output_format
    type:
      - 'null'
      - string
    doc: select object format (list with -f help)
    inputBinding:
      position: 102
      prefix: --oformat
  - id: output_format_short
    type:
      - 'null'
      - string
    doc: select object format (list with -f help)
    inputBinding:
      position: 102
      prefix: -f
  - id: parser
    type:
      - 'null'
      - string
    doc: select parser (list with -p help)
    inputBinding:
      position: 102
      prefix: --parser
  - id: parser_short
    type:
      - 'null'
      - string
    doc: select parser (list with -p help)
    inputBinding:
      position: 102
      prefix: -p
  - id: predefine_macro
    type:
      - 'null'
      - string
    doc: pre-define a macro, optionally to value
    inputBinding:
      position: 102
      prefix: -d
  - id: predefine_macro_upper
    type:
      - 'null'
      - string
    doc: pre-define a macro, optionally to value
    inputBinding:
      position: 102
      prefix: -D
  - id: preinclude_file
    type:
      - 'null'
      - File
    doc: pre-include file
    inputBinding:
      position: 102
      prefix: -P
  - id: preprocess_only
    type:
      - 'null'
      - boolean
    doc: preprocess only (writes output to stdout by default)
    inputBinding:
      position: 102
      prefix: --preproc-only
  - id: preprocessor
    type:
      - 'null'
      - string
    doc: select preprocessor (list with -r help)
    inputBinding:
      position: 102
      prefix: --preproc
  - id: preprocessor_short
    type:
      - 'null'
      - string
    doc: select preprocessor (list with -r help)
    inputBinding:
      position: 102
      prefix: -r
  - id: redirect_error_stdout
    type:
      - 'null'
      - boolean
    doc: redirect error messages to stdout
    inputBinding:
      position: 102
      prefix: -s
  - id: symbol_postfix
    type:
      - 'null'
      - string
    doc: append argument to name of all external symbols
    inputBinding:
      position: 102
      prefix: --postfix
  - id: symbol_prefix
    type:
      - 'null'
      - string
    doc: prepend argument to name of all external symbols
    inputBinding:
      position: 102
      prefix: --prefix
  - id: symbol_suffix
    type:
      - 'null'
      - string
    doc: append argument to name of all external symbols
    inputBinding:
      position: 102
      prefix: --suffix
  - id: undefine_macro
    type:
      - 'null'
      - string
    doc: undefine a macro
    inputBinding:
      position: 102
      prefix: -u
  - id: undefine_macro_upper
    type:
      - 'null'
      - string
    doc: undefine a macro
    inputBinding:
      position: 102
      prefix: -U
outputs:
  - id: object_file
    type:
      - 'null'
      - File
    doc: name of object-file output
    outputBinding:
      glob: $(inputs.object_file)
  - id: object_file_short
    type:
      - 'null'
      - File
    doc: name of object-file output
    outputBinding:
      glob: $(inputs.object_file_short)
  - id: map_file
    type:
      - 'null'
      - File
    doc: name of map-file output
    outputBinding:
      glob: $(inputs.map_file)
  - id: redirect_error_file
    type:
      - 'null'
      - File
    doc: redirect error messages to file
    outputBinding:
      glob: $(inputs.redirect_error_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasm:1.3.0--0
