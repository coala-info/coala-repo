cwlVersion: v1.2
class: CommandLineTool
baseCommand: fq2fa
label: idba_fq2fa
doc: "Convert Fastq sequences to Fasta sequences. Single-end: one FASTQ and one FASTA\n\
  output. With --paired the FASTQ holds interleaved pairs. With --merge two FASTQ\n\
  files (mates) are merged into one FASTA.\n\nTool homepage: https://github.com/loneknightpy/idba"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file (the first mate file with --merge)
    inputBinding:
      position: 10
  - id: input_fastq_2
    type: ['null', File]
    doc: Second mate FASTQ file (use with --merge)
    inputBinding:
      position: 11
  - id: output_fasta_name
    type: string
    doc: Output FASTA file name
    inputBinding:
      position: 12
  - id: filter
    type: ['null', boolean]
    doc: Filter out reads containing 'N'
    inputBinding:
      position: 1
      prefix: --filter
  - id: merge
    type: ['null', boolean]
    doc: If the reads are paired-end in two files, merge them
    inputBinding:
      position: 1
      prefix: --merge
  - id: paired
    type: ['null', boolean]
    doc: If the reads are paired-end in one file
    inputBinding:
      position: 1
      prefix: --paired
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.output_fasta_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/idba:1.1.3--1
