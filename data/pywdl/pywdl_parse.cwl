cwlVersion: v1.2
class: CommandLineTool
baseCommand: wdl
label: pywdl_parse
doc: "Parse a WDL file and print the parse tree.\n\nTool homepage: https://github.com/broadinstitute/pywdl"
arguments:
  - position: 10
    valueFrom: parse
inputs:
  - id: wdl_file
    type: File
    doc: Path to WDL File
    inputBinding:
      position: 11
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Open the floodgates
    inputBinding:
      position: 1
      prefix: --debug
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Don't colorize output
    inputBinding:
      position: 2
      prefix: --no-color
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the parse tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pywdl:1.0.22--py_1
stdout: pywdl_parse.out
