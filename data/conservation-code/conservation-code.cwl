cwlVersion: v1.2
class: CommandLineTool
baseCommand: conservation-code
label: conservation-code
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull and convert a Docker image due to insufficient disk space.\n\nTool
  homepage: https://github.com/hanjunlee21/conservation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/conservation-code:v20110309.0-7-deb_cv1
stdout: conservation-code.out
