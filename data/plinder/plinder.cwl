cwlVersion: v1.2
class: CommandLineTool
baseCommand: plinder
label: plinder
doc: "The provided text does not contain help information or usage instructions for
  the tool 'plinder'. It consists of system error messages related to container image
  retrieval and disk space issues.\n\nTool homepage: https://www.plinder.sh"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plinder:0.2.25--pyhdfd78af_3
stdout: plinder.out
