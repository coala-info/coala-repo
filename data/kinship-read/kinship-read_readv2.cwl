cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kinship-read
  - readv2
label: kinship-read_readv2
doc: "A tool for kinship analysis (Note: The provided help text contains a system
  error message regarding disk space and does not list specific tool arguments).\n
  \nTool homepage: https://bitbucket.org/tguenther/read/src/master/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kinship-read:2.1.1--pyh7cba7a3_0
stdout: kinship-read_readv2.out
