cwlVersion: v1.2
class: CommandLineTool
baseCommand: magic-impute
label: magic-impute
doc: "A tool for Markov Affinity-based Graph Imputation of Cells (MAGIC) to denoise
  and impute single-cell RNA-seq data.\n\nTool homepage: https://github.com/KrishnaswamyLab/MAGIC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magic-impute:3.0.0--pyh7cba7a3_0
stdout: magic-impute.out
