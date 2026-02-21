cwlVersion: v1.2
class: CommandLineTool
baseCommand: iso2flux_integrate_gene_expression.py
label: iso2flux_integrate_gene_expression.py
doc: "Integrate gene expression data into iso2flux models (Note: The provided help
  text contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/cfoguet/iso2flux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/iso2flux:phenomenal-v0.7.1_cv2.1.60
stdout: iso2flux_integrate_gene_expression.py.out
