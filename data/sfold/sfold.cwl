cwlVersion: v1.2
class: CommandLineTool
baseCommand: sfold
label: sfold
doc: "The provided text is an error log from a container build process and does not
  contain help information or usage instructions for the sfold tool. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/Ding-RNA-Lab/Sfold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sfold:2.2--pl5321r44h7b50bb2_4
stdout: sfold.out
