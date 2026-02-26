cwlVersion: v1.2
class: CommandLineTool
baseCommand: sylph-tax download
label: sylph-tax_download
doc: "Download taxonomy metadata\n\nTool homepage: https://github.com/bluenote-1577/sylph-tax"
inputs:
  - id: download_to
    type:
      - 'null'
      - Directory
    doc: Download taxonomy metadata to this directory (must exist, e.g. 
      my/folder/). A config file is written to $HOME or $SYLPH_TAXONOMY_CONFIG.
    inputBinding:
      position: 101
      prefix: --download-to
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sylph-tax:1.8.0--pyhdfd78af_0
stdout: sylph-tax_download.out
