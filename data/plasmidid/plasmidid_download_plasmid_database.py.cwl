cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidid_download_plasmid_database.py
label: plasmidid_download_plasmid_database.py
doc: "Download plasmid database for PlasmidID. Note: The provided help text contains
  only system execution logs and error messages regarding container extraction; no
  specific command-line arguments were listed in the input.\n\nTool homepage: https://github.com/BU-ISCIII/plasmidID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidid:1.6.5--hdfd78af_0
stdout: plasmidid_download_plasmid_database.py.out
