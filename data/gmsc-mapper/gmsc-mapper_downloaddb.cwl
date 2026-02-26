cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmsc-mapper
  - downloaddb
label: gmsc-mapper_downloaddb
doc: "Download the GMSCMapper database.\n\nTool homepage: https://github.com/BigDataBiology/GMSC-mapper"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Download all database
    inputBinding:
      position: 101
      prefix: --all
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: Path to the database files.
    inputBinding:
      position: 101
      prefix: --dbdir
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force download even if the files exist
    inputBinding:
      position: 101
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmsc-mapper:0.1.0--pyhdfd78af_0
stdout: gmsc-mapper_downloaddb.out
