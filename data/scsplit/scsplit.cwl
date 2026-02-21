cwlVersion: v1.2
class: CommandLineTool
baseCommand: scsplit
label: scsplit
doc: "The provided text does not contain help information or usage instructions for
  scsplit; it contains error logs related to a container build failure (no space left
  on device).\n\nTool homepage: https://github.com/jon-xu/scSplit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scsplit:1.0.8.2--pyh7cba7a3_0
stdout: scsplit.out
