cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqToFa
label: ucsc-fastqtofa
doc: "Convert FASTQ to FASTA format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fastqtofa:482--h0b57e2e_0
