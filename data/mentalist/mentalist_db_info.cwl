cwlVersion: v1.2
class: CommandLineTool
baseCommand: mentalist db_info
label: mentalist_db_info
doc: "MentaLiST kmer database information\n\nTool homepage: https://github.com/WGS-TB/MentaLiST"
inputs:
  - id: db
    type: string
    doc: MentaLiST kmer database
    inputBinding:
      position: 101
      prefix: --db
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
stdout: mentalist_db_info.out
