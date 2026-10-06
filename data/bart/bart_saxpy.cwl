cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, saxpy]
requirements:
  - class: InlineJavascriptRequirement
label: bart_saxpy
doc: "Multiply input1 with scale factor and add input2.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: scale
    type: string
    doc: scale
    inputBinding:
      position: 10
  - id: input1
    type: File
    doc: input1
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: input2
    type: File
    doc: input2
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 12
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 13
outputs:
  - id: output_file
    type: File
    doc: Array written as output.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
