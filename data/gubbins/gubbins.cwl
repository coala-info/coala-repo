cwlVersion: v1.2
class: CommandLineTool
baseCommand: gubbins
label: gubbins
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build a container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/nickjcroucher/gubbins"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
stdout: gubbins.out
