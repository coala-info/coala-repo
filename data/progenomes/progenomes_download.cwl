cwlVersion: v1.2
class: CommandLineTool
baseCommand: progenomes_download
label: progenomes_download
doc: "Download datasets from Progenomes\n\nTool homepage: https://github.com/BigDataBiology/progenomes-cli"
inputs:
  - id: target
    type: string
    doc: The dataset to download
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/progenomes:0.3.0--pyhdfd78af_0
stdout: progenomes_download.out
