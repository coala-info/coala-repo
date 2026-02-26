cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar wdltool.jar
label: wdltool_highlight
doc: "Performs various operations on WDL files.\n\nTool homepage: https://github.com/broadinstitute/wdltool"
inputs:
  - id: action
    type: string
    doc: The action to perform (validate, inputs, highlight, parse, graph, 
      womgraph)
    inputBinding:
      position: 1
  - id: parameters
    type:
      - 'null'
      - type: array
        items: string
    doc: Parameters specific to the chosen action
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wdltool:0.14--1
stdout: wdltool_highlight.out
