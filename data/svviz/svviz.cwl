cwlVersion: v1.2
class: CommandLineTool
baseCommand: svviz
label: svviz
doc: "A visualizer for structural variants\n\nTool homepage: https://github.com/svviz/svviz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svviz:1.6.2--py27h24bf2e0_0
stdout: svviz.out
