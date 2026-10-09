cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-fastq-to-fasta
label: illumina-utils_iu-fastq-to-fasta
doc: "Convert FASTQ to FASTA

Tool homepage: https://github.com/meren/illumina-utils"
inputs:
  - id: input_fastq
    type: File
    doc: "FASTQ file to be converted"
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "FASTA output file name"
    inputBinding:
      position: 2
      prefix: '-o'
  - id: number_of_sequences
    type:
      - 'null'
      - int
    doc: "Number of sequences to be converted"
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
  - id: uppercase
    type:
      - 'null'
      - boolean
    doc: "When set, all nucleotides are converted to uppercase, removing mismatch information from merged sequences."
    inputBinding:
      position: 5
      prefix: '-u'
outputs:
  - id: fasta_out
    type: File
    doc: "FASTA output file"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
