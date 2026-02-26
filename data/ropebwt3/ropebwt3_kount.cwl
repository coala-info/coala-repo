cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ropebwt3
  - kount
label: ropebwt3_kount
doc: "Count k-mers in FMD-index files.\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs:
  - id: input_fmd_files
    type:
      type: array
      items: File
    doc: Input FMD-index files
    inputBinding:
      position: 1
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length
    default: 51
    inputBinding:
      position: 102
      prefix: -k
  - id: min_kmer_occurrence
    type:
      - 'null'
      - int
    doc: min k-mer occurrence
    default: 100
    inputBinding:
      position: 102
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
stdout: ropebwt3_kount.out
