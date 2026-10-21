cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ropebwt3
  - fa2kmer
label: ropebwt3_fa2kmer
doc: "Extract k-mers from FASTA/FASTQ files.\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs:
  - id: seq_fa
    type:
      type: array
      items: File
    doc: Input FASTA/FASTQ file(s)
    inputBinding:
      position: 1
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size
    inputBinding:
      position: 102
      prefix: '-k'
  - id: step_size
    type:
      - 'null'
      - int
    doc: step size
    inputBinding:
      position: 102
      prefix: '-w'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
stdout: ropebwt3_fa2kmer.out
