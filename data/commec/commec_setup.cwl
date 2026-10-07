cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - commec
  - setup
label: commec_setup
doc: "This script will help download the mandatory databases required for using Commec
  Screen, and requires a stable internet connection, wget, and update_blastdb.pl.
  This setup is split over 3 steps: 1. Specify download location. 2. Choose which
  databases to download. 3. Confirm and start downloads.\n\nTool homepage: https://github.com/ibbis-screening/common-mechanism"
inputs:
  - id: auto
    type:
      - 'null'
      - boolean
    doc: Don't ask for user input, and use default options for everything.
    inputBinding:
      position: 1
      prefix: --auto
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: downloaded databases (default location commec-dbs/)
    outputBinding:
      glob: commec-dbs
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/commec:1.0.3--pyhdfd78af_0
stdout: commec_setup.out
