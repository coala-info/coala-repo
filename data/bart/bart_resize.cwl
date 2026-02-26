cwlVersion: v1.2
class: CommandLineTool
baseCommand: resize
label: bart_resize
doc: "Resizes an array along dimensions to sizes by truncating or zero-padding.\n\n\
  Tool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: dimensions_and_sizes
    type:
      type: array
      items: string
    doc: dimensions and their target sizes
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input file
    inputBinding:
      position: 2
  - id: center
    type:
      - 'null'
      - boolean
    doc: center
    inputBinding:
      position: 103
      prefix: -c
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
