cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-dim-plot.r
label: seurat-scripts_seurat-dim-plot.r
doc: "A script from the seurat-scripts package to generate dimensional reduction plots.
  Note: The provided help text contains only system error messages regarding container
  extraction failure ('no space left on device') and does not list specific arguments.\n
  \nTool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
stdout: seurat-scripts_seurat-dim-plot.r.out
