cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dbgraph
  - DBGraph2Pro
label: dbgraph_DBGraph2Pro
doc: "The provided text contains error logs related to a container runtime (Apptainer/Singularity)
  and does not include help text or usage instructions for the tool.\n\nTool homepage:
  https://github.com/COL-IU/graph2pro-var/tree/master/Graph2Pro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbgraph:v1.0.0--h6bb024c_1
stdout: dbgraph_DBGraph2Pro.out
