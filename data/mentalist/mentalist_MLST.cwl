cwlVersion: v1.2
class: CommandLineTool
baseCommand: mentalist
label: mentalist_MLST
doc: "A tool for MLST analysis.\n\nTool homepage: https://github.com/WGS-TB/MentaLiST"
inputs:
  - id: command
    type: string
    doc: 'The subcommand to execute. Available commands: call, build_db, db_info,
      list_pubmlst, download_pubmlst, list_cgmlst, download_cgmlst, download_enterobase.'
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
stdout: mentalist_MLST.out
