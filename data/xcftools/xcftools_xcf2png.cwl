cwlVersion: v1.2
class: CommandLineTool
baseCommand: xcf2png
label: xcftools_xcf2png
doc: "Convert GIMP XCF files to PNG format\n\nTool homepage: https://github.com/j-jorge/xcftools"
inputs:
  - id: xcf_file
    type: File
    doc: The input XCF file
    inputBinding:
      position: 1
  - id: layers
    type:
      - 'null'
      - type: array
        items: string
    doc: Specific layers to include
    inputBinding:
      position: 2
  - id: alpha
    type:
      - 'null'
      - boolean
    doc: Keep the alpha channel
    inputBinding:
      position: 103
      prefix: --alpha
  - id: background
    type:
      - 'null'
      - string
    doc: Use this color as the background
    inputBinding:
      position: 103
      prefix: --background
  - id: color
    type:
      - 'null'
      - boolean
    doc: Force color output
    inputBinding:
      position: 103
      prefix: --color
  - id: dissolve
    type:
      - 'null'
      - boolean
    doc: Handle 'dissolve' mode layers
    inputBinding:
      position: 103
      prefix: --dissolve
  - id: flatten
    type:
      - 'null'
      - boolean
    doc: Flatten the image before converting
    inputBinding:
      position: 103
      prefix: --flatten
  - id: gray
    type:
      - 'null'
      - boolean
    doc: Force grayscale output
    inputBinding:
      position: 103
      prefix: --gray
  - id: offset
    type:
      - 'null'
      - string
    doc: Crop image at offset (X,Y)
    inputBinding:
      position: 103
      prefix: --offset
  - id: size
    type:
      - 'null'
      - string
    doc: Crop image to size (WxH)
    inputBinding:
      position: 103
      prefix: --size
  - id: truecolor
    type:
      - 'null'
      - boolean
    doc: Force truecolor output
    inputBinding:
      position: 103
      prefix: --truecolor
  - id: zip
    type:
      - 'null'
      - boolean
    doc: Use deflate compression in PNG
    inputBinding:
      position: 103
      prefix: --zip
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to FILE
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xcftools:1.0.7--0
