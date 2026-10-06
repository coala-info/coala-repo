cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, toimg]
requirements:
  - class: InlineJavascriptRequirement
label: bart_toimg
doc: "Create magnitude images as png or proto-dicom.\nThe first two non-singleton
  dimensions will\nbe used for the image, and the other dimensions\nwill be looped
  over.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: input
    type: File
    doc: Input file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_prefix
    type: string
    doc: Output prefix
    inputBinding:
      position: 11
  - id: contrast
    type:
      - 'null'
      - float
    doc: contrast level
    inputBinding:
      position: 1
      prefix: -c
  - id: dynamic_windowing
    type:
      - 'null'
      - boolean
    doc: use dynamic windowing
    inputBinding:
      position: 1
      prefix: -W
  - id: gamma
    type:
      - 'null'
      - float
    doc: gamma level
    inputBinding:
      position: 1
      prefix: -g
  - id: rescale_each_image
    type:
      - 'null'
      - boolean
    doc: re-scale each image
    inputBinding:
      position: 1
      prefix: -m
  - id: window
    type:
      - 'null'
      - float
    doc: window level
    inputBinding:
      position: 1
      prefix: -w
  - id: write_dicom
    type:
      - 'null'
      - boolean
    doc: write to dicom format (deprecated, use extension .dcm)
    inputBinding:
      position: 1
      prefix: -d
outputs:
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
