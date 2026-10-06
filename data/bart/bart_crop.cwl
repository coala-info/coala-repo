cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, crop]
requirements:
  - class: InlineJavascriptRequirement
label: bart_crop
doc: "Extracts a sub-array corresponding to the central part of {size} along {dimension}\n\
  \nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: dimension
    type: string
    doc: The dimension along which to extract the sub-array
    inputBinding:
      position: 10
  - id: size
    type: int
    doc: The size of the sub-array to extract
    inputBinding:
      position: 11
  - id: input
    type: File
    doc: The input array file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 12
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 13
outputs:
  - id: output
    type: File
    doc: The output array file
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
