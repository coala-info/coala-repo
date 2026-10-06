cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, invert]
requirements:
  - class: InlineJavascriptRequirement
label: bart_invert
doc: "Invert array (1 / <input>). The output is set to zero in case of divide by zero.\n\
  \nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: input
    type: File
    doc: Input array
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output
    type: string
    doc: Output array
    inputBinding:
      position: 11
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
