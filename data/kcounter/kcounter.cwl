cwlVersion: v1.2
class: CommandLineTool
baseCommand: kcounter
label: kcounter
doc: "A tool for k-mer counting (Note: The provided text contains system error messages
  and does not include usage instructions or argument definitions).\n\nTool homepage:
  http://apcamargo.github.io/kcounter/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcounter:0.1.1--py312h6c9e832_8
stdout: kcounter.out
