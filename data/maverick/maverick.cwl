cwlVersion: v1.2
class: CommandLineTool
baseCommand: maverick
label: maverick
doc: "The provided text does not contain help information for the tool 'maverick'.
  It contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://github.com/bobverity/MavericK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maverick:1.0.5--h9948957_0
stdout: maverick.out
