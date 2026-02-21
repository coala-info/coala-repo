cwlVersion: v1.2
class: CommandLineTool
baseCommand: dbgraph_graph2pro-var.sh
label: dbgraph_graph2pro-var.sh
doc: "A tool within the dbgraph package. Note: The provided help text contains only
  system environment information and execution errors, so no specific arguments or
  descriptions could be extracted.\n\nTool homepage: https://github.com/COL-IU/graph2pro-var/tree/master/Graph2Pro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbgraph:v1.0.0--h6bb024c_1
stdout: dbgraph_graph2pro-var.sh.out
