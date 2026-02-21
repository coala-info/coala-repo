cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-read-10x.R
label: seurat-scripts_seurat-read-10x.R
doc: "Read 10x Genomics data into Seurat (Note: The provided input text contains container
  runtime error messages rather than the tool's help documentation).\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/r-seurat-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
stdout: seurat-scripts_seurat-read-10x.R.out
