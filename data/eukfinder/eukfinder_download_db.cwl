cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - eukfinder
  - download_db
label: eukfinder_download_db
doc: "Download EukFinder databases\n\nTool homepage: https://github.com/RogerLab/Eukfinder"
inputs:
  - id: name
    type:
      - 'null'
      - string
    doc: directory name for storing the databases
    inputBinding:
      position: 101
      prefix: --name
  - id: path
    type:
      - 'null'
      - Directory
    doc: filesystem path for storing the databases
    inputBinding:
      position: 101
      prefix: --path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eukfinder:1.2.4--py36h503566f_0
stdout: eukfinder_download_db.out
