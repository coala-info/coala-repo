cwlVersion: v1.2
class: CommandLineTool
baseCommand: show-snps
label: mummer4_show-snps
doc: "The provided text contains a system error message regarding container image
  building and does not contain the help text for the tool. No arguments could be
  extracted from the provided input.\n\nTool homepage: https://mummer4.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_show-snps.out
