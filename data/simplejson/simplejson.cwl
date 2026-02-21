cwlVersion: v1.2
class: CommandLineTool
baseCommand: simplejson.tool
label: simplejson
doc: "A simple, fast, extensible JSON encoder/decoder for Python. The command-line
  tool provides a way to validate and pretty-print JSON.\n\nTool homepage: https://github.com/bitly/go-simplejson"
inputs:
  - id: infile
    type:
      - 'null'
      - File
    doc: The JSON file to be read. If not specified, read from stdin.
    inputBinding:
      position: 1
  - id: indent
    type:
      - 'null'
      - int
    doc: Separate items with newlines and use this number of spaces for indentation.
    inputBinding:
      position: 102
      prefix: --indent
  - id: sort_keys
    type:
      - 'null'
      - boolean
    doc: Sort the output of dictionaries alphabetically by key.
    inputBinding:
      position: 102
      prefix: --sort-keys
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: The file to write the output to. If not specified, write to stdout.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simplejson:3.8.1--py35_0
