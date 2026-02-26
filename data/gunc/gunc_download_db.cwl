cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gunc
  - download_db
label: gunc_download_db
doc: "Download the GUNC database.\n\nTool homepage: https://github.com/grp-bork/gunc"
inputs:
  - id: dest_path
    type: Directory
    doc: Path to the directory where the database will be downloaded.
    inputBinding:
      position: 1
  - id: database
    type:
      - 'null'
      - string
    doc: Specify which database to download. If not specified, all databases 
      will be downloaded.
    inputBinding:
      position: 102
      prefix: -db
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
    dockerPull: quay.io/biocontainers/gunc:1.0.6--pyhdfd78af_1
stdout: gunc_download_db.out
