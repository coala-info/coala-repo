cwlVersion: v1.2
class: CommandLineTool
baseCommand: gimbleprep
label: gimbleprep
doc: "The provided text does not contain help information for gimbleprep; it contains
  error messages from a container runtime (Apptainer/Singularity) indicating a failure
  to build or pull the container image due to lack of disk space.\n\nTool homepage:
  https://github.com/LohseLab/gimbleprep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimbleprep:0.0.2--pyhdfd78af_0
stdout: gimbleprep.out
