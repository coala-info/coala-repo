cwlVersion: v1.2
class: CommandLineTool
baseCommand: toimg
label: bart_toimg
doc: "Create magnitude images as png or proto-dicom.\nThe first two non-singleton
  dimensions will\nbe used for the image, and the other dimensions\nwill be looped
  over.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Output prefix
    inputBinding:
      position: 2
  - id: contrast
    type:
      - 'null'
      - float
    doc: contrast level
    inputBinding:
      position: 103
      prefix: -c
  - id: dynamic_windowing
    type:
      - 'null'
      - boolean
    doc: use dynamic windowing
    inputBinding:
      position: 103
      prefix: -W
  - id: gamma
    type:
      - 'null'
      - float
    doc: gamma level
    inputBinding:
      position: 103
      prefix: -g
  - id: rescale_each_image
    type:
      - 'null'
      - boolean
    doc: re-scale each image
    inputBinding:
      position: 103
      prefix: -m
  - id: window
    type:
      - 'null'
      - float
    doc: window level
    inputBinding:
      position: 103
      prefix: -w
  - id: write_dicom
    type:
      - 'null'
      - boolean
    doc: write to dicom format (deprecated, use extension .dcm)
    inputBinding:
      position: 103
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_toimg.out
