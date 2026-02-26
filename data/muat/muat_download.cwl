cwlVersion: v1.2
class: CommandLineTool
baseCommand: muat download
label: muat_download
doc: "Download datasets.\n\nTool homepage: https://github.com/primasanjaya/muat"
inputs:
  - id: download_dir
    type: Directory
    doc: Directory for storing the downloaded dataset.
    inputBinding:
      position: 101
      prefix: --download-dir
  - id: pcawg
    type:
      - 'null'
      - boolean
    doc: Download the PCAWG dataset.
    inputBinding:
      position: 101
      prefix: --pcawg
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
stdout: muat_download.out
