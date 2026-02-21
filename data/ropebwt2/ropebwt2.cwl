cwlVersion: v1.2
class: CommandLineTool
baseCommand: ropebwt2
label: ropebwt2
doc: "The provided text does not contain help information as the tool failed to execute
  due to a container image retrieval error.\n\nTool homepage: https://github.com/lh3/ropebwt2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt2:r187--h577a1d6_11
stdout: ropebwt2.out
