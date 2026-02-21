cwlVersion: v1.2
class: CommandLineTool
baseCommand: stress-ng
label: stress-ng
doc: "The provided text does not contain help information or usage instructions for
  stress-ng. It appears to be a log of a failed container build/fetch process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/ColinIanKing/stress-ng"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stress-ng:0.12.04
stdout: stress-ng.out
