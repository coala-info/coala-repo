cwlVersion: v1.2
class: CommandLineTool
baseCommand: commec_setup
label: commec_setup
doc: "This script will help download the mandatory databases required for using Commec
  Screen, and requires a stable internet connection, wget, and update_blastdb.pl.
  This setup is split over 3 steps: 1. Specify download location. 2. Choose which
  databases to download. 3. Confirm and start downloads.\n\nTool homepage: https://github.com/ibbis-screening/common-mechanism"
inputs:
  - id: download_location
    type:
      - 'null'
      - Directory
    doc: The absolute or relative filepath to where you would like the Commec 
      databases to be located.
    default: commec-dbs/
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/commec:1.0.3--pyhdfd78af_0
stdout: commec_setup.out
