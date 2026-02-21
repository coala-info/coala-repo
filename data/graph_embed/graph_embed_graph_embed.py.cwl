cwlVersion: v1.2
class: CommandLineTool
baseCommand: graph_embed_graph_embed.py
label: graph_embed_graph_embed.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a container runtime (Singularity/Apptainer)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/fabriziocosta/GraphEmbed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphclust-wrappers:0.6.0--pl526_1
stdout: graph_embed_graph_embed.py.out
