cwlVersion: v1.2
class: CommandLineTool
baseCommand: tac
label: coreutils_tac
doc: "Write each FILE to standard output, last line first. With no FILE, or when FILE
  is -, read standard input.\n\nTool homepage: https://github.com/uutils/coreutils"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files to be processed
    inputBinding:
      position: 1
  - id: before
    type:
      - 'null'
      - boolean
    doc: attach the separator before instead of after
    inputBinding:
      position: 102
      prefix: --before
  - id: regex
    type:
      - 'null'
      - boolean
    doc: interpret the separator as a regular expression
    inputBinding:
      position: 102
      prefix: --regex
  - id: separator
    type:
      - 'null'
      - string
    doc: use STRING as the separator instead of newline
    inputBinding:
      position: 102
      prefix: --separator
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_tac.out
