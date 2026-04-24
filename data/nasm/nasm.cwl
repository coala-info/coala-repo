cwlVersion: v1.2
class: CommandLineTool
baseCommand: nasm
label: nasm
doc: "NASM assembler\n\nTool homepage: https://github.com/netwide-assembler/nasm"
inputs:
  - id: filename
    type: File
    doc: filename to assemble
    inputBinding:
      position: 1
  - id: assemble_and_generate_dependencies
    type:
      - 'null'
      - File
    doc: assemble and generate dependencies
    inputBinding:
      position: 102
      prefix: -MD
  - id: assemble_only
    type:
      - 'null'
      - boolean
    doc: don't preprocess (assemble only)
    inputBinding:
      position: 102
      prefix: -a
  - id: bnd_warning
    type:
      - 'null'
      - boolean
    doc: invalid bnd prefixes
    inputBinding:
      position: 102
  - id: debug_format
    type:
      - 'null'
      - string
    doc: select a debugging format
    inputBinding:
      position: 102
      prefix: -F
  - id: debug_info
    type:
      - 'null'
      - boolean
    doc: generate debug information in selected format
    inputBinding:
      position: 102
      prefix: -g
  - id: dependency_target_name
    type:
      - 'null'
      - string
    doc: dependency target name
    inputBinding:
      position: 102
      prefix: -MT
  - id: dependency_target_name_quoted
    type:
      - 'null'
      - string
    doc: dependency target name (quoted)
    inputBinding:
      position: 102
      prefix: -MQ
  - id: disable_warning
    type:
      - 'null'
      - type: array
        items: string
    doc: disable warning foo (equiv. -Wno-foo)
    inputBinding:
      position: 102
      prefix: -Wno-
  - id: emit_phony_target
    type:
      - 'null'
      - boolean
    doc: emit phony target
    inputBinding:
      position: 102
      prefix: -MP
  - id: enable_warning
    type:
      - 'null'
      - type: array
        items: string
    doc: enables warning foo (equiv. -Wfoo)
    inputBinding:
      position: 102
      prefix: -W
  - id: error_as_error
    type:
      - 'null'
      - boolean
    doc: treat warnings as errors
    inputBinding:
      position: 102
  - id: error_reporting_format
    type:
      - 'null'
      - string
    doc: specifies error reporting format (gnu or vc)
    inputBinding:
      position: 102
      prefix: -X
  - id: float_denorm_warning
    type:
      - 'null'
      - boolean
    doc: floating point denormal
    inputBinding:
      position: 102
  - id: float_overflow_warning
    type:
      - 'null'
      - boolean
    doc: floating point overflow
    inputBinding:
      position: 102
  - id: float_toolong_warning
    type:
      - 'null'
      - boolean
    doc: too many digits in floating-point number
    inputBinding:
      position: 102
  - id: float_underflow_warning
    type:
      - 'null'
      - boolean
    doc: floating point underflow
    inputBinding:
      position: 102
  - id: format
    type:
      - 'null'
      - string
    doc: select an output format
    inputBinding:
      position: 102
      prefix: -f
  - id: gnu_elf_extensions_warning
    type:
      - 'null'
      - boolean
    doc: using 8- or 16-bit relocation in ELF32, a GNU extension
    inputBinding:
      position: 102
  - id: hle_warning
    type:
      - 'null'
      - boolean
    doc: invalid hle prefixes
    inputBinding:
      position: 102
  - id: include_path
    type:
      - 'null'
      - type: array
        items: Directory
    doc: adds a pathname to the include file path
    inputBinding:
      position: 102
      prefix: -I
  - id: listfile
    type:
      - 'null'
      - File
    doc: write listing to a listfile
    inputBinding:
      position: 102
      prefix: -l
  - id: lock_warning
    type:
      - 'null'
      - boolean
    doc: lock prefix on unlockable instructions
    inputBinding:
      position: 102
  - id: macro_defaults_warning
    type:
      - 'null'
      - boolean
    doc: macros with more default than optional parameters
    inputBinding:
      position: 102
  - id: macro_params_warning
    type:
      - 'null'
      - boolean
    doc: macro calls with wrong parameter count
    inputBinding:
      position: 102
  - id: macro_selfref_warning
    type:
      - 'null'
      - boolean
    doc: cyclic macro references
    inputBinding:
      position: 102
  - id: makefile_dependencies
    type:
      - 'null'
      - boolean
    doc: generate Makefile dependencies on stdout
    inputBinding:
      position: 102
      prefix: -M
  - id: makefile_dependency_file
    type:
      - 'null'
      - File
    doc: set Makefile dependency file
    inputBinding:
      position: 102
      prefix: -MF
  - id: missing_files_assumed_generated
    type:
      - 'null'
      - boolean
    doc: missing files assumed generated
    inputBinding:
      position: 102
      prefix: -MG
  - id: number_overflow_warning
    type:
      - 'null'
      - boolean
    doc: numeric constant does not fit
    inputBinding:
      position: 102
  - id: optimize_branch_offsets
    type:
      - 'null'
      - int
    doc: optimize branch offsets
    inputBinding:
      position: 102
      prefix: -O
  - id: orphan_labels_warning
    type:
      - 'null'
      - boolean
    doc: labels alone on lines without trailing `:'
    inputBinding:
      position: 102
  - id: postfix
    type:
      - 'null'
      - string
    doc: append the given argument to all extern and global variables
    inputBinding:
      position: 102
      prefix: --postfix
  - id: pre_define_macro
    type:
      - 'null'
      - type: array
        items: string
    doc: pre-defines a macro
    inputBinding:
      position: 102
      prefix: -D
  - id: pre_include_file
    type:
      - 'null'
      - File
    doc: pre-includes a file
    inputBinding:
      position: 102
      prefix: -P
  - id: prefix
    type:
      - 'null'
      - string
    doc: prepend the given argument to all extern and global variables
    inputBinding:
      position: 102
      prefix: --prefix
  - id: preprocess_only
    type:
      - 'null'
      - boolean
    doc: preprocess only (writes output to stdout by default)
    inputBinding:
      position: 102
      prefix: -e
  - id: redirect_error_messages_to_file
    type:
      - 'null'
      - File
    doc: redirect error messages to file
    inputBinding:
      position: 102
      prefix: -Z
  - id: redirect_error_messages_to_stdout
    type:
      - 'null'
      - boolean
    doc: redirect error messages to stdout
    inputBinding:
      position: 102
      prefix: -s
  - id: response_file
    type:
      - 'null'
      - File
    doc: response file
    inputBinding:
      position: 102
      prefix: -@
  - id: tasm_mode
    type:
      - 'null'
      - boolean
    doc: assemble in SciTech TASM compatible mode
    inputBinding:
      position: 102
      prefix: -t
  - id: undefine_macro
    type:
      - 'null'
      - string
    doc: undefines a macro
    inputBinding:
      position: 102
      prefix: -U
  - id: user_warning
    type:
      - 'null'
      - boolean
    doc: '%warning directives'
    inputBinding:
      position: 102
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: write output to an outfile
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasm:2.11.08--0
