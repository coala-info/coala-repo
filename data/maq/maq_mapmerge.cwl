cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - mapmerge
label: maq_mapmerge
doc: "Merge multiple map files.\n\nTool homepage: http://maq.sourceforge.net/"
inputs:
  - id: out_map
    type: string
    doc: Output map file name
    inputBinding:
      position: 1
  - id: input_maps
    type:
      type: array
      items: File
    doc: Input map files to merge (at least two)
    inputBinding:
      position: 2
outputs:
  - id: output_map
    type: File
    doc: Output map file
    outputBinding:
      glob: $(inputs.out_map)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
