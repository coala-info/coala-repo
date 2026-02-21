cwlVersion: v1.2
class: CommandLineTool
baseCommand: readfq
label: readfq_kseq_fastq_base
doc: "A tool for parsing and processing FASTQ/FASTA files, typically utilizing the
  kseq library for efficient sequence reading.\n\nTool homepage: https://github.com/billzt/readfq"
inputs:
  - id: input_file
    type: File
    doc: Input FASTQ or FASTA file to be processed
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/readfq:2015.08.30--h577a1d6_7
stdout: readfq_kseq_fastq_base.out
