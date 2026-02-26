cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamhash_checksum_fasta
label: bamhash_bamhash_checksum_fasta
doc: "Checksum of a set of fasta files\n\nTool homepage: https://github.com/DecodeGenetics/BamHash"
inputs:
  - id: input_fastas
    type:
      type: array
      items: File
    doc: Input FASTA files
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode. Prints full hex for each read to stdout
    inputBinding:
      position: 102
      prefix: --debug
  - id: no_readnames
    type:
      - 'null'
      - boolean
    doc: Do not use read names as part of checksum
    inputBinding:
      position: 102
      prefix: --no-readnames
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamhash:2.0--h35c04b2_0
stdout: bamhash_bamhash_checksum_fasta.out
