cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsea
label: gsea
doc: "Gene Set Enrichment Analysis (GSEA)\n\nTool homepage: https://www.gsea-msigdb.org/gsea"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsea:4.3.2--hdfd78af_0
stdout: gsea.out
