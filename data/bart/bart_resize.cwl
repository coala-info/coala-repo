cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, resize]
requirements:
  - class: InlineJavascriptRequirement
label: bart_resize
doc: "Resizes an array along dimensions to sizes by truncating or zero-padding.\n\n\
  Tool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: dimensions_and_sizes
    type:
      type: array
      items: string
    doc: dimensions and their target sizes
    inputBinding:
      position: 10
  - id: input_file
    type: File
    doc: Input file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_file_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 12
  - id: center
    type:
      - 'null'
      - boolean
    doc: center
    inputBinding:
      position: 1
      prefix: -c
outputs:
  - id: output_file
    type: File
    doc: Output file
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_file_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
