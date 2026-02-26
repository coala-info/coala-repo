cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkv_download_database
label: checkv_download_database
doc: "Download the latest version of CheckV's database\n\nTool homepage: https://bitbucket.org/berkeleylab/checkv"
inputs:
  - id: destination
    type: Directory
    doc: Directory where the database will be downloaded to.
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress logging messages
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
stdout: checkv_download_database.out
