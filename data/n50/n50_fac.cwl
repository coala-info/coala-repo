cwlVersion: v1.2
class: CommandLineTool
baseCommand: fac
label: n50_fac
doc: "Count the sequences of a gzip compressed FASTA file.\n\nTool homepage: https://github.com/quadram-institute-bioscience/n50"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: "Chunk size"
    inputBinding:
      position: 1
      prefix: "--chunk-size"
  - id: fasta_gz
    type: File
    doc: "Input gzip compressed FASTA file"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
stdout: n50_fac.out
