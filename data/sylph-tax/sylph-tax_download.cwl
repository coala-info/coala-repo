cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sylph-tax
  - download
label: sylph-tax_download
doc: "Download taxonomy metadata\n\nTool homepage: https://github.com/bluenote-1577/sylph-tax"
inputs:
  - id: download_to
    type: string
    doc: Name of the directory that receives the taxonomy metadata files (the tool creates it). A config file is written to $HOME or $SYLPH_TAXONOMY_CONFIG.
    inputBinding:
      position: 101
      prefix: --download-to
outputs:
  - id: taxonomy_dir
    type: Directory
    doc: Directory with the downloaded taxonomy metadata files
    outputBinding:
      glob: $(inputs.download_to)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sylph-tax:1.8.0--pyhdfd78af_0
stdout: sylph-tax_download.out
