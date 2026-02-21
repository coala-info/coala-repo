cwlVersion: v1.2
class: CommandLineTool
baseCommand: dastk_barcode_plot
label: dastk_barcode_plot
doc: "The provided text does not contain help information for the tool; it is a log
  of a container build failure due to insufficient disk space.\n\nTool homepage: https://github.com/Dowell-Lab/DAStk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
stdout: dastk_barcode_plot.out
