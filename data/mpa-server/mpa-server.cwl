cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpa-server
label: mpa-server
doc: "Download preprocessed FASTA Database (size: ~1 GB)\n\nTool homepage: https://github.com/compomics/meta-proteome-analyzer"
inputs:
  - id: download_database
    type:
      - 'null'
      - boolean
    doc: 'Download preprocessed FASTA Database (size: ~1 GB)? [Y/n]'
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mpa-server:3.4--0
stdout: mpa-server.out
