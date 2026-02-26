cwlVersion: v1.2
class: CommandLineTool
baseCommand: awk
label: hmmratac_awk
doc: "Pattern scanning and processing language\n\nTool homepage: https://github.com/LiuLabUB/HMMRATAC"
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
  - id: set_variable
    type:
      - 'null'
      - type: array
        items: string
    doc: Set variable VAR=VAL
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmratac:1.2.10--hdfd78af_1
stdout: hmmratac_awk.out
