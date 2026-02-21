cwlVersion: v1.2
class: CommandLineTool
baseCommand: graph_embed
label: graph_embed
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a set of error logs from a container runtime (Apptainer/Singularity)
  indicating a failure to build a container due to insufficient disk space.\n\nTool
  homepage: https://github.com/fabriziocosta/GraphEmbed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphclust-wrappers:0.6.0--pl526_1
stdout: graph_embed.out
