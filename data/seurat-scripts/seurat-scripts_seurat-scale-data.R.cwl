cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-scale-data.R
label: seurat-scripts_seurat-scale-data.R
doc: "Scale and center data in a Seurat object. (Note: The provided help text contains
  system error messages regarding a failed container build and does not list specific
  arguments.)\n\nTool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
stdout: seurat-scripts_seurat-scale-data.R.out
