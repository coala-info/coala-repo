cwlVersion: v1.2
class: CommandLineTool
baseCommand: faToFastq
label: ucsc-fatofastq
doc: "Converts FASTA format to FASTQ format. Note: The provided help text was a Docker
  error; this definition is based on the standard usage of the ucsc-fatofastq (faToFastq)
  tool.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
outputs:
  - id: output_fastq
    type: File
    doc: Output FASTQ file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatofastq:482--h0b57e2e_0
