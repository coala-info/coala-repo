cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-find-variable-genes.R
label: seurat-scripts_seurat-find-variable-genes.R
doc: "Find variable genes using Seurat scripts.\n\nTool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
stdout: seurat-scripts_seurat-find-variable-genes.R.out
