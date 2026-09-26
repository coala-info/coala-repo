cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - pac2bwtgen
label: bwa_pac2bwtgen
doc: "Generate a BWT from a PAC file\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: input_pac
    type: File
    doc: Input PAC file
    inputBinding:
      position: 201
  - id: out_bwt
    type: string
    doc: Name of the .bwt file to write, for example ref.fa.bwt; any directory part is dropped
    inputBinding:
      position: 202
      valueFrom: $(self.split('/').pop())
outputs:
  - id: output_bwt
    type: File
    doc: The file written
    outputBinding:
      glob: $(inputs.out_bwt.split('/').pop())
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
