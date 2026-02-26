cwlVersion: v1.2
class: CommandLineTool
baseCommand: epicore
label: epicore_plot-landscape
doc: "Epicore is a tool for analyzing and visualizing genomic data.\n\nTool homepage:
  https://github.com/AG-Walz/epicore"
inputs:
  - id: reference_proteome
    type: File
    doc: Reference proteome file
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epicore:0.1.7--pyhdfd78af_0
stdout: epicore_plot-landscape.out
