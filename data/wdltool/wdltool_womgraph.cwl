cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wdltool
  - womgraph
label: wdltool_womgraph
doc: "Reads a WDL or CWL file and converts it to a WOM representation, then prints out a graph of the WOM produced. Imported files can be supplied as ancillary files.\n\nTool homepage: https://github.com/broadinstitute/wdltool"
inputs:
  - id: input_file
    type: File
    doc: WDL or CWL file
    inputBinding:
      position: 1
  - id: ancillary_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Imported files
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wdltool:0.14--1
stdout: wdltool_womgraph.out
