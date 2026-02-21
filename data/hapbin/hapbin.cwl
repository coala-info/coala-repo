cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapbin
label: hapbin
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/evotools/hapbin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapbin:1.3.0--h503566f_6
stdout: hapbin.out
