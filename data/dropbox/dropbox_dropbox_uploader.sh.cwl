cwlVersion: v1.2
class: CommandLineTool
baseCommand: dropbox_uploader.sh
label: dropbox_dropbox_uploader.sh
doc: "A BASH script which can be used to upload, download, list or delete files from
  Dropbox.\n\nTool homepage: https://github.com/andreafabrizi/Dropbox-Uploader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropbox:5.2.1--py36_0
stdout: dropbox_dropbox_uploader.sh.out
