cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomad download-database
label: genomad_download-database
doc: "Download the latest version of geNomad's database and save it in the DESTINATION
  directory.\n\nTool homepage: https://portal.nersc.gov/genomad/"
inputs:
  - id: destination
    type: Directory
    doc: The directory to save the database in.
    inputBinding:
      position: 1
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Do not delete the compressed database file.
    inputBinding:
      position: 102
      prefix: --keep
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Display the execution log.
    default: verbose
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display the execution log.
    default: verbose
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomad:1.11.2--pyhdfd78af_0
stdout: genomad_download-database.out
