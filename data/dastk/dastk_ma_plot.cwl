cwlVersion: v1.2
class: CommandLineTool
baseCommand: dastk_ma_plot
label: dastk_ma_plot
doc: "Differential ATAC-seq toolkit MA plot generation tool. (Note: The provided input
  text contains container runtime error logs rather than the tool's help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/Dowell-Lab/DAStk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
stdout: dastk_ma_plot.out
