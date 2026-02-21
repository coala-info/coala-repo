cwlVersion: v1.2
class: CommandLineTool
baseCommand: duplicate_gene_classifier
label: mcscanx_Duplicate_gene_classifier
doc: "Classify duplicate genes into different categories (singleton, dispersed, proximal,
  tandem, and segmental/WGD). Note: The provided text is a system error log and does
  not contain usage information.\n\nTool homepage: https://github.com/wyp1125/MCScanX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcscanx:1.0.0--h9948957_0
stdout: mcscanx_Duplicate_gene_classifier.out
