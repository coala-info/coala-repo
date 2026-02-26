cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - mapmerge
label: maq_mapmerge
doc: "Merge multiple map files.\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: input_maps
    type:
      type: array
      items: File
    doc: Input map files to merge
    inputBinding:
      position: 1
outputs:
  - id: output_map
    type: File
    doc: Output map file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
