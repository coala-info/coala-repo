cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngs-chew
  - plot-var-het
label: ngs-chew_plot-var-het
doc: "Plot var(het) metric from .npz files.\n\nTool homepage: https://github.com/bihealth/ngs-chew"
inputs:
  - id: stats_out
    type: File
    doc: Input .npz files
    inputBinding:
      position: 1
  - id: title
    type:
      - 'null'
      - string
    doc: title to use for the output HTML file.
    inputBinding:
      position: 102
      prefix: --title
outputs:
  - id: out_html
    type: File
    doc: Output HTML file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-chew:0.9.4--pyhdfd78af_0
