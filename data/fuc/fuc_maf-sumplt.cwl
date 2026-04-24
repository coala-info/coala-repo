cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - maf-sumplt
label: fuc_maf-sumplt
doc: "Create a summary plot with a MAF file.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: maf
    type: File
    doc: Input MAF file.
    inputBinding:
      position: 1
  - id: figsize
    type:
      - 'null'
      - type: array
        items: float
    doc: Width, height in inches
      - 15.0
      - 10.0
    inputBinding:
      position: 102
      prefix: --figsize
  - id: legend_fontsize
    type:
      - 'null'
      - float
    doc: Font size of legend texts
    inputBinding:
      position: 102
      prefix: --legend_fontsize
  - id: ticklabels_fontsize
    type:
      - 'null'
      - float
    doc: Font size of tick labels
    inputBinding:
      position: 102
      prefix: --ticklabels_fontsize
  - id: title_fontsize
    type:
      - 'null'
      - float
    doc: Font size of subplot titles
    inputBinding:
      position: 102
      prefix: --title_fontsize
outputs:
  - id: out
    type: File
    doc: Output image file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
