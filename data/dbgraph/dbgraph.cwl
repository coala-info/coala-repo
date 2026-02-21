cwlVersion: v1.2
class: CommandLineTool
baseCommand: dbgraph
label: dbgraph
doc: "A tool for de Bruijn graph construction and analysis (Note: The provided text
  is an error log and does not contain usage information or argument definitions).\n
  \nTool homepage: https://github.com/COL-IU/graph2pro-var/tree/master/Graph2Pro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbgraph:v1.0.0--h6bb024c_1
stdout: dbgraph.out
