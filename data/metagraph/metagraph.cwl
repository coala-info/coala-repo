cwlVersion: v1.2
class: CommandLineTool
baseCommand: metagraph
label: metagraph
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to build
  an image due to lack of disk space.\n\nTool homepage: https://github.com/ratschlab/metagraph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagraph:0.5.0--haea4672_0
stdout: metagraph.out
