cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kipoi
  - veff
  - score_variants
label: kipoi_veff_kipoi veff score_variants
doc: "Score variants using Kipoi models. Note: The provided help text contains system
  error messages regarding container execution and does not list specific command-line
  arguments.\n\nTool homepage: https://github.com/kipoi/kipoi-veff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
stdout: kipoi_veff_kipoi veff score_variants.out
