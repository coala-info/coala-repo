cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - bwt2sa
label: bwa_bwt2sa
doc: "Generate suffix array from BWT\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: in_bwt
    type: File
    doc: Input BWT file
    inputBinding:
      position: 201
  - id: sampling_interval
    type:
      - 'null'
      - int
    doc: Sampling interval
    inputBinding:
      position: 102
      prefix: -i
  - id: out_sa
    type: string
    doc: Name of the .sa file to write, for example ref.fa.sa; any directory part is dropped
    inputBinding:
      position: 202
      valueFrom: $(self.split('/').pop())
outputs:
  - id: out_sa
    type: File
    doc: The file written
    outputBinding:
      glob: $(inputs.out_sa.split('/').pop())
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
