cwlVersion: v1.2
class: CommandLineTool
baseCommand: tidk_plot
label: tidk_plot
doc: "SVG plot of TSV generated from tidk search.\n\nTool homepage: https://github.com/tolkit/telomeric-identifier"
inputs:
  - id: fontsize
    type:
      - 'null'
      - int
    doc: The font size of the axis labels in the plot
    inputBinding:
      position: 101
      prefix: --fontsize
  - id: height
    type:
      - 'null'
      - int
    doc: The height of subplots (px).
    inputBinding:
      position: 101
      prefix: --height
  - id: strokewidth
    type:
      - 'null'
      - int
    doc: The stroke width of the line graph in the plot
    inputBinding:
      position: 101
      prefix: --strokewidth
  - id: tsv
    type: File
    doc: The input TSV file
    inputBinding:
      position: 101
      prefix: --tsv
  - id: width
    type:
      - 'null'
      - int
    doc: The width of plot (px)
    inputBinding:
      position: 101
      prefix: --width
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filename for the SVG (without extension)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tidk:0.2.65--h3dc2dae_0
