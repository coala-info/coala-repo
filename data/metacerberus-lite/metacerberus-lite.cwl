cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacerberus-lite
label: metacerberus-lite
doc: "The provided text contains system error logs and does not include help documentation
  or usage instructions for the tool. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/raw-lab/metacerberus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacerberus-lite:1.4.0--pyhdfd78af_1
stdout: metacerberus-lite.out
