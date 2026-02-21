cwlVersion: v1.2
class: CommandLineTool
baseCommand: minigraph
label: minigraph
doc: "The provided text does not contain help information for minigraph; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/lh3/minigraph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minigraph:0.21--h577a1d6_3
stdout: minigraph.out
