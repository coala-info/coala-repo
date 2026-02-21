cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - olga-generate_sequences
label: olga_olga-generate_sequences
doc: "Generate sequences using OLGA (Optimized Likelihood estimate of immunoglobulin
  Gene Assembly). Note: The provided help text contains only system error messages
  regarding container execution and does not list specific arguments.\n\nTool homepage:
  https://github.com/zsethna/OLGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/olga:1.3.0--pyh7e72e81_0
stdout: olga_olga-generate_sequences.out
