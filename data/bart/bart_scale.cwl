cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, scale]
requirements:
  - class: InlineJavascriptRequirement
label: bart_scale
doc: "Scale array by {factor}. The scale factor can be a complex number.\n\nTool homepage:
  https://github.com/mrirecon/bart"
inputs:
  - id: factor
    type: string
    doc: Scale factor
    inputBinding:
      position: 10
  - id: input
    type: File
    doc: Input array
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 12
outputs:
  - id: output
    type: File
    doc: Output array
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
