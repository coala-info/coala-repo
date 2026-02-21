cwlVersion: v1.2
class: CommandLineTool
baseCommand: kinship-read
label: kinship-read
doc: "The provided text does not contain help information or usage instructions. It
  contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull the image due to insufficient disk space.\n\nTool homepage: https://bitbucket.org/tguenther/read/src/master/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kinship-read:2.1.1--pyh7cba7a3_0
stdout: kinship-read.out
