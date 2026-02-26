cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepbgc_download
label: deepbgc_download
doc: "Download trained models and other file dependencies to the DeepBGC downloads
  directory.\n\nTool homepage: https://github.com/Merck/DeepBGC"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbgc:0.1.31--pyhca03a8a_0
stdout: deepbgc_download.out
