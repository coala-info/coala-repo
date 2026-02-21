cwlVersion: v1.2
class: CommandLineTool
baseCommand: ms-entropy
label: ms-entropy
doc: "A tool for calculating MS entropy (Note: The provided text is a system error
  log and does not contain help documentation or argument details).\n\nTool homepage:
  https://github.com/YuanyueLi/MSEntropy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ms-entropy:1.3.4--py311h93dcfea_0
stdout: ms-entropy.out
