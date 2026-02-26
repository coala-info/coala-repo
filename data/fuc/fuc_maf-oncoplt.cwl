cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - maf-oncoplt
label: fuc_maf-oncoplt
doc: "Create an oncoplot with a MAF file.\nThe format of output image (PDF/PNG/JPEG/SVG)
  will be automatically\ndetermined by the output file's extension.\n\nTool homepage:
  https://github.com/sbslee/fuc"
inputs:
  - id: maf
    type: File
    doc: Input MAF file.
    inputBinding:
      position: 1
  - id: count
    type:
      - 'null'
      - int
    doc: Number of top mutated genes to display
    default: 10
    inputBinding:
      position: 102
      prefix: --count
  - id: figsize
    type:
      - 'null'
      - type: array
        items: float
    doc: Width, height in inches
    default:
      - 15
      - 10
    inputBinding:
      position: 102
      prefix: --figsize
  - id: label_fontsize
    type:
      - 'null'
      - float
    doc: Font size of labels
    default: 15
    inputBinding:
      position: 102
      prefix: --label_fontsize
  - id: legend_fontsize
    type:
      - 'null'
      - float
    doc: Font size of legend texts
    default: 15
    inputBinding:
      position: 102
      prefix: --legend_fontsize
  - id: ticklabels_fontsize
    type:
      - 'null'
      - float
    doc: Font size of tick labels
    default: 15
    inputBinding:
      position: 102
      prefix: --ticklabels_fontsize
outputs:
  - id: out
    type: File
    doc: Output image file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
