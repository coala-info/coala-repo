cwlVersion: v1.2
class: CommandLineTool
baseCommand: m6anet
label: m6anet
doc: "m6anet is a tool for m6A RNA modification detection from Nanopore data. (Note:
  The provided text is a system error log regarding a container build failure and
  does not contain usage instructions or argument definitions).\n\nTool homepage:
  https://github.com/GoekeLab/m6anet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/m6anet:2.1.0--pyhdfd78af_0
stdout: m6anet.out
