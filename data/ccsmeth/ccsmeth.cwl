cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccsmeth
label: ccsmeth
doc: "The provided text does not contain help information for the tool 'ccsmeth'.
  It contains error logs related to a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/PengNi/ccsmeth"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
stdout: ccsmeth.out
