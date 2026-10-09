cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - rmdup
label: maq_rmdup
doc: "Remove duplicate reads from a maq map file.\n\nTool homepage: http://maq.sourceforge.net/"
inputs:
  - id: out_map
    type: string
    doc: Output map file name.
    inputBinding:
      position: 1
  - id: input_map
    type: File
    doc: Input map file.
    inputBinding:
      position: 2
outputs:
  - id: output_map
    type: File
    doc: Output map file with duplicates removed.
    outputBinding:
      glob: $(inputs.out_map)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
