cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, spow]
requirements:
  - class: InlineJavascriptRequirement
label: bart_spow
doc: "Raise array to the power of {exponent}. The exponent can be a complex number.\n\
  \nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: exponent
    type: string
    doc: The exponent
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
  - id: output
    type: string
    doc: Output array
    inputBinding:
      position: 12
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
