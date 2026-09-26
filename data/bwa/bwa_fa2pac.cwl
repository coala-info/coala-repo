cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - fa2pac
label: bwa_fa2pac
doc: "Convert FASTA format to PAC format for BWA indexing\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 201
  - id: f_flag
    type:
      - 'null'
      - boolean
    doc: pack the forward strand only
    inputBinding:
      position: 102
      prefix: -f
  - id: out_prefix
    type: string
    doc: Prefix of the output files, for example ref.fa; any directory part is dropped
    inputBinding:
      position: 202
      valueFrom: $(self.split('/').pop())
outputs:
  - id: output_files
    type: File[]
    doc: The files <out_prefix>.pac, .ann and .amb
    outputBinding:
      glob: $(inputs.out_prefix.split('/').pop()).*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
