cwlVersion: v1.2
class: CommandLineTool
baseCommand: wdltool_parse
label: wdltool_parse
doc: "Parses a WDL file and prints its Abstract Syntax Tree (AST).\n\nTool homepage:
  https://github.com/broadinstitute/wdltool"
inputs:
  - id: wdl_file
    type: File
    doc: The WDL file to parse.
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
