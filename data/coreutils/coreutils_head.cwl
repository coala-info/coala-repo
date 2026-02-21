cwlVersion: v1.2
class: CommandLineTool
baseCommand: head
label: coreutils_head
doc: "Print the first 10 lines of each FILE to standard output. With more than one
  FILE, precede each with a header giving the file name. With no FILE, or when FILE
  is -, read standard input.\n\nTool homepage: https://github.com/uutils/coreutils"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to read. If no FILE is provided, or if FILE is -, read standard input.
    inputBinding:
      position: 1
  - id: bytes
    type:
      - 'null'
      - string
    doc: print the first NUM bytes of each file; with the leading '-', print all but
      the last NUM bytes of each file
    inputBinding:
      position: 102
      prefix: --bytes
  - id: lines
    type:
      - 'null'
      - string
    doc: print the first NUM lines instead of the first 10; with the leading '-',
      print all but the last NUM lines of each file
    inputBinding:
      position: 102
      prefix: --lines
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: never print headers giving file names
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: always print headers giving file names
    inputBinding:
      position: 102
      prefix: --verbose
  - id: zero_terminated
    type:
      - 'null'
      - boolean
    doc: line delimiter is NUL, not newline
    inputBinding:
      position: 102
      prefix: --zero-terminated
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_head.out
