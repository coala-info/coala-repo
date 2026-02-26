cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - rmdup
label: maq_rmdup
doc: "Remove duplicate reads from a maq map file.\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: input_map
    type: File
    doc: Input map file.
    inputBinding:
      position: 1
outputs:
  - id: output_map
    type: File
    doc: Output map file with duplicates removed.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
