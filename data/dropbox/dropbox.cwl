cwlVersion: v1.2
class: CommandLineTool
baseCommand: dropbox
label: dropbox
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or run the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/andreafabrizi/Dropbox-Uploader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropbox:5.2.1--py36_0
stdout: dropbox.out
