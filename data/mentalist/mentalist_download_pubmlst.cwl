cwlVersion: v1.2
class: CommandLineTool
baseCommand: mentalist download_pubmlst
label: mentalist_download_pubmlst
doc: "Download a scheme from PubMLST and create a kmer database.\n\nTool homepage:
  https://github.com/WGS-TB/MentaLiST"
inputs:
  - id: db
    type: File
    doc: Output file (kmer database)
    inputBinding:
      position: 101
      prefix: --db
  - id: k
    type: int
    doc: Kmer size
    inputBinding:
      position: 101
      prefix: -k
  - id: output
    type: Directory
    doc: Output folder for the scheme Fasta files.
    inputBinding:
      position: 101
      prefix: --output
  - id: scheme
    type: string
    doc: Species name or scheme ID.
    inputBinding:
      position: 101
      prefix: --scheme
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used in parallel.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
stdout: mentalist_download_pubmlst.out
