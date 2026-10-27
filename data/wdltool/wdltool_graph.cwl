cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wdltool
  - graph
label: wdltool_graph
doc: "Reads a WDL file against the grammar and prints out a .dot of the DAG if it is valid, and a syntax error otherwise.\n\nTool homepage: https://github.com/broadinstitute/wdltool"
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
stdout: wdltool_graph.out
