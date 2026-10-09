cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-fasta-to-fastq
label: illumina-utils_iu-fasta-to-fastq
doc: "Convert FASTA to FASTQ

Tool homepage: https://github.com/meren/illumina-utils"
inputs:
  - id: input_fasta
    type: File
    doc: "FASTA file to be converted"
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "FASTQ output file name"
    inputBinding:
      position: 2
      prefix: '-o'
  - id: number_of_sequences
    type:
      - 'null'
      - int
    doc: "Number of sequences to be converted (by default everything will be processed)"
    inputBinding:
      position: 3
      prefix: '-n'
  - id: rev_comp
    type:
      - 'null'
      - boolean
    doc: "When set, during the conversion reads will be reverse complemented."
    inputBinding:
      position: 4
      prefix: '-r'
outputs:
  - id: fastq_out
    type: File
    doc: "FASTQ output file"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
