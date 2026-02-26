cwlVersion: v1.2
class: CommandLineTool
baseCommand: awk
label: ptgaul_awk
doc: "Pattern scanning and processing language\n\nTool homepage: https://github.com/Bean061/ptgaul"
inputs:
  - id: awk_program_pos
    type:
      - 'null'
      - string
    doc: AWK program to execute
    inputBinding:
      position: 1
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files to process
    inputBinding:
      position: 2
  - id: assign_variable
    type:
      - 'null'
      - type: array
        items: string
    doc: Set variable (VAR=VAL)
    inputBinding:
      position: 103
      prefix: -v
  - id: awk_program_option
    type:
      - 'null'
      - string
    doc: AWK program to execute
    inputBinding:
      position: 103
      prefix: -e
  - id: field_separator
    type:
      - 'null'
      - string
    doc: Use SEP as field separator
    inputBinding:
      position: 103
      prefix: -F
  - id: program_file
    type:
      - 'null'
      - File
    doc: Read program from FILE
    inputBinding:
      position: 103
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
stdout: ptgaul_awk.out
