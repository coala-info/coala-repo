cwlVersion: v1.2
class: CommandLineTool
baseCommand: [tab_to_shape.py]
label: shapemapper_tab_to_shape.py
doc: "Convert a ShapeMapper reactivity profile table to .map, .shape, VARNA and RiboSketch formats.\n\nTool homepage: https://github.com/Weeks-UNC/shapemapper2"
inputs:
  - id: infile
    type: File
    doc: "Tab-delimited input file containing reactivity profile and stderrs"
    inputBinding:
      position: 101
      prefix: --infile
  - id: map_path
    type: ['null', string]
    doc: "Output .map file"
    inputBinding:
      position: 101
      prefix: --map
  - id: shape_path
    type: ['null', string]
    doc: "Output .shape file"
    inputBinding:
      position: 101
      prefix: --shape
  - id: varna_path
    type: ['null', string]
    doc: "Output VARNA color file"
    inputBinding:
      position: 101
      prefix: --varna
  - id: ribosketch_path
    type: ['null', string]
    doc: "Output RiboSketch file"
    inputBinding:
      position: 101
      prefix: --ribosketch
outputs:
  - id: map
    type: ['null', File]
    doc: Output .map file
    outputBinding:
      glob: $(inputs.map_path)
  - id: shape
    type: ['null', File]
    doc: Output .shape file
    outputBinding:
      glob: $(inputs.shape_path)
  - id: varna
    type: ['null', File]
    doc: Output VARNA color file
    outputBinding:
      glob: $(inputs.varna_path)
  - id: ribosketch
    type: ['null', File]
    doc: Output RiboSketch file
    outputBinding:
      glob: $(inputs.ribosketch_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapemapper:2.3.2--h5814d7d_0
