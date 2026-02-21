cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-scripts
label: seurat-scripts
doc: "A collection of R scripts for single-cell RNA-seq analysis using the Seurat
  package. Note: The provided text contains container build errors and does not list
  specific command-line arguments.\n\nTool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
stdout: seurat-scripts.out
