cwlVersion: v1.2
class: CommandLineTool
baseCommand: cut
label: coreutils_cut
doc: "Print selected parts of lines from each FILE to standard output.\n\nTool homepage:
  https://github.com/uutils/coreutils"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to process. With no FILE, or when FILE is -, read standard input.
    inputBinding:
      position: 1
  - id: bytes
    type:
      - 'null'
      - string
    doc: select only these bytes
    inputBinding:
      position: 102
      prefix: --bytes
  - id: characters
    type:
      - 'null'
      - string
    doc: select only these characters
    inputBinding:
      position: 102
      prefix: --characters
  - id: complement
    type:
      - 'null'
      - boolean
    doc: complement the set of selected bytes, characters or fields
    inputBinding:
      position: 102
      prefix: --complement
  - id: delimiter
    type:
      - 'null'
      - string
    doc: use DELIM instead of TAB for field delimiter
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: fields
    type:
      - 'null'
      - string
    doc: select only these fields; also print any line that contains no delimiter
      character, unless the -s option is specified
    inputBinding:
      position: 102
      prefix: --fields
  - id: ignored
    type:
      - 'null'
      - boolean
    doc: (ignored)
    inputBinding:
      position: 102
      prefix: -n
  - id: only_delimited
    type:
      - 'null'
      - boolean
    doc: do not print lines not containing delimiters
    inputBinding:
      position: 102
      prefix: --only-delimited
  - id: output_delimiter
    type:
      - 'null'
      - string
    doc: use STRING as the output delimiter; the default is to use the input delimiter
    inputBinding:
      position: 102
      prefix: --output-delimiter
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
stdout: coreutils_cut.out
