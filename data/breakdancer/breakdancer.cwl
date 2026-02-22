cwlVersion: v1.2
class: CommandLineTool
baseCommand: breakdancer
label: breakdancer
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/genome/breakdancer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/breakdancer:1.4.5--pl5321h264e753_11
stdout: breakdancer.out
