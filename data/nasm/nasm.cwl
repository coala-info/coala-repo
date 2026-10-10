cwlVersion: v1.2
class: CommandLineTool
baseCommand: nasm
label: nasm
doc: "NASM - the Netwide Assembler.\n\nTool homepage: https://github.com/netwide-assembler/nasm"
inputs:
  - id: filename
    type: File
    doc: "Source file to assemble."
    inputBinding:
      position: 200
  - id: response_file
    type:
      - 'null'
      - File
    doc: "Response file: command line parameters, one per line."
    inputBinding:
      position: 102
      prefix: "-@"
  - id: output_file
    type:
      - 'null'
      - string
    doc: "Write output to an outfile."
    inputBinding:
      position: 102
      prefix: -o
  - id: format
    type:
      - 'null'
      - string
    doc: "Select an output format (see -hf for the list)."
    inputBinding:
      position: 102
      prefix: -f
  - id: listfile
    type:
      - 'null'
      - string
    doc: "Write listing to a listfile."
    inputBinding:
      position: 102
      prefix: -l
  - id: debug_format
    type:
      - 'null'
      - string
    doc: "Select a debugging format."
    inputBinding:
      position: 102
      prefix: -F
  - id: tasm_mode
    type:
      - 'null'
      - boolean
    doc: "Assemble in SciTech TASM compatible mode."
    inputBinding:
      position: 102
      prefix: -t
  - id: debug_info
    type:
      - 'null'
      - boolean
    doc: "Generate debug information in selected format."
    inputBinding:
      position: 102
      prefix: -g
  - id: preprocess_only
    type:
      - 'null'
      - boolean
    doc: "Preprocess only (writes output to stdout by default)."
    inputBinding:
      position: 102
      prefix: -E
  - id: assemble_only
    type:
      - 'null'
      - boolean
    doc: "Do not preprocess (assemble only)."
    inputBinding:
      position: 102
      prefix: -a
  - id: makefile_dependencies
    type:
      - 'null'
      - boolean
    doc: "Generate Makefile dependencies on stdout."
    inputBinding:
      position: 102
      prefix: -M
  - id: missing_files_assumed_generated
    type:
      - 'null'
      - boolean
    doc: "Like -M, but missing files are assumed to be generated."
    inputBinding:
      position: 102
      prefix: -MG
  - id: makefile_dependency_file
    type:
      - 'null'
      - string
    doc: "Set Makefile dependency file."
    inputBinding:
      position: 102
      prefix: -MF
  - id: assemble_and_generate_dependencies
    type:
      - 'null'
      - string
    doc: "Assemble and generate dependencies into the given file."
    inputBinding:
      position: 102
      prefix: -MD
  - id: dependency_target_name
    type:
      - 'null'
      - string
    doc: "Dependency target name."
    inputBinding:
      position: 102
      prefix: -MT
  - id: dependency_target_name_quoted
    type:
      - 'null'
      - string
    doc: "Dependency target name (quoted)."
    inputBinding:
      position: 102
      prefix: -MQ
  - id: emit_phony_target
    type:
      - 'null'
      - boolean
    doc: "Emit phony target."
    inputBinding:
      position: 102
      prefix: -MP
  - id: error_file
    type:
      - 'null'
      - string
    doc: "Redirect error messages to file."
    inputBinding:
      position: 102
      prefix: -Z
      separate: false
  - id: errors_to_stdout
    type:
      - 'null'
      - boolean
    doc: "Redirect error messages to stdout."
    inputBinding:
      position: 102
      prefix: -s
  - id: include_path
    type:
      - 'null'
      - type: array
        items: Directory
        inputBinding:
          prefix: "-I"
          separate: false
          valueFrom: $(self.path + '/')
    doc: "Add a directory to the include file path."
  - id: optimize
    type:
      - 'null'
      - string
    doc: "Optimize branch offsets: 0 (none), 1 (minimal) or x (multipass, default)."
    inputBinding:
      position: 102
      prefix: -O
      separate: false
  - id: pre_include_file
    type:
      - 'null'
      - File
    doc: "Pre-include a file."
    inputBinding:
      position: 102
      prefix: -P
      separate: false
  - id: pre_define_macro
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: "-D"
          separate: false
    doc: "Pre-define a macro, as macro or macro=value."
  - id: undefine_macro
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: "-U"
          separate: false
    doc: "Undefine a macro."
  - id: error_reporting_format
    type:
      - 'null'
      - string
    doc: "Error reporting format (gnu or vc)."
    inputBinding:
      position: 102
      prefix: -X
      separate: false
  - id: enable_warning
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: "-w+"
          separate: false
    doc: "Enable warning foo (equiv. -Wfoo), e.g. error, macro-params, orphan-labels."
  - id: disable_warning
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: "-w-"
          separate: false
    doc: "Disable warning foo (equiv. -Wno-foo)."
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prepend the given argument to all extern and global variables."
    inputBinding:
      position: 102
      prefix: --prefix
  - id: postfix
    type:
      - 'null'
      - string
    doc: "Append the given argument to all extern and global variables."
    inputBinding:
      position: 102
      prefix: --postfix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (preprocessed source or Makefile dependencies when requested).
  - id: assembled_output
    type:
      - 'null'
      - File
    doc: Assembled output file.
    outputBinding:
      glob: $(inputs.output_file)
  - id: listing
    type:
      - 'null'
      - File
    doc: Listing file.
    outputBinding:
      glob: $(inputs.listfile)
  - id: dependency_file
    type:
      - 'null'
      - File
    doc: Makefile dependency file.
    outputBinding:
      glob: "$(inputs.makefile_dependency_file ? inputs.makefile_dependency_file : inputs.assemble_and_generate_dependencies)"
  - id: error_messages
    type:
      - 'null'
      - File
    doc: File with redirected error messages.
    outputBinding:
      glob: $(inputs.error_file)
stdout: nasm.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasm:2.11.08--0
