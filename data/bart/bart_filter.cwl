cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, filter]
requirements:
  - class: InlineJavascriptRequirement
label: bart_filter
doc: "Apply filter.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: input
    type: File
    doc: input
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 11
  - id: filter_length
    type:
      - 'null'
      - int
    doc: length of filter
    inputBinding:
      position: 1
      prefix: -l
  - id: median_filter_dim
    type:
      - 'null'
      - int
    doc: median filter along dimension dim
    inputBinding:
      position: 1
      prefix: -m
outputs:
  - id: output
    type: File
    doc: output
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
