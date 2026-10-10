cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - muat
  - download
label: muat_download
doc: "Download datasets.\n\nTool homepage: https://github.com/primasanjaya/muat"
inputs:
  - id: download_dir
    type: string
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
  - id: download_directory
    type: Directory
    doc: Directory with the downloaded dataset
    outputBinding:
      glob: $(inputs.download_dir)
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.download_dir)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
