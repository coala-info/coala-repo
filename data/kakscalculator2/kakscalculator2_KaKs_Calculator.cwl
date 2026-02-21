cwlVersion: v1.2
class: CommandLineTool
baseCommand: KaKs_Calculator
label: kakscalculator2_KaKs_Calculator
doc: "KaKs_Calculator is a tool for calculating nonsynonymous (Ka) and synonymous
  (Ks) substitution rates. Note: The provided help text contains system error messages
  and does not list specific command-line arguments.\n\nTool homepage: https://github.com/kullrich/kakscalculator2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kakscalculator2:2.0.1--h9948957_6
stdout: kakscalculator2_KaKs_Calculator.out
