cwlVersion: v1.2
class: CommandLineTool
baseCommand: illuminate
label: illuminate
doc: "The provided text does not contain help information for the tool 'illuminate'.
  It contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build or pull the container image due to lack of disk space.\n\nTool
  homepage: https://github.com/RRethy/vim-illuminate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illuminate:0.6.3--py35_0
stdout: illuminate.out
