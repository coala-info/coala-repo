cwlVersion: v1.2
class: CommandLineTool
baseCommand: figtree
label: figtree
doc: "Tree Figure Drawing Tool\n\nTool homepage: https://github.com/rambaut/figtree"
inputs:
  - id: tree_file_name
    type: File
    doc: Input tree file name
    inputBinding:
      position: 103
  - id: graphic_format
    type:
      - 'null'
      - string
    doc: produce a graphic with the given format
    inputBinding:
      position: 102
      prefix: -graphic
  - id: height
    type:
      - 'null'
      - int
    doc: the height of the graphic in pixels
    inputBinding:
      position: 102
      prefix: -height
  - id: url
    type:
      - 'null'
      - boolean
    doc: the input file is a URL
    inputBinding:
      position: 102
      prefix: -url
  - id: width
    type:
      - 'null'
      - int
    doc: the width of the graphic in pixels
    inputBinding:
      position: 102
      prefix: -width
  - id: graphic_file_name
    type: string
    doc: Output graphic file name
    inputBinding:
      position: 104
outputs:
  - id: graphic_file
    type:
      - 'null'
      - File
    doc: Output graphic file
    outputBinding:
      glob: $(inputs.graphic_file_name)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/figtree:v1.4.4-3-deb_cv1
