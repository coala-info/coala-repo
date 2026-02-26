cwlVersion: v1.2
class: CommandLineTool
baseCommand: download_plasmid_database.py
label: plasmidid_download_plasmid_database.py
doc: "Download up to date plasmid database from ncbi ftp\n\nTool homepage: https://github.com/BU-ISCIII/plasmidID"
inputs:
  - id: output
    type: Directory
    doc: Output directory to extract plasmid database
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidid:1.6.5--hdfd78af_0
stdout: plasmidid_download_plasmid_database.py.out
