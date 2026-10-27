cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wdltool
  - parse
label: wdltool_parse
doc: "Compares a WDL file against the grammar and prints out an abstract syntax tree if it is valid, and a syntax error otherwise.\n\nTool homepage: https://github.com/broadinstitute/wdltool"
inputs:
  - id: wdl_file
    type: File
    doc: WDL file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wdltool:0.14--1
stdout: wdltool_parse.out
