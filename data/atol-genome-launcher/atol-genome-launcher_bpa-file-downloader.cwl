cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpa-file-downloader
label: atol-genome-launcher_bpa-file-downloader
doc: "Downloads files from a given URL and saves them with a specified name.\n\nTool
  homepage: https://github.com/TomHarrop/atol-genome-launcher"
inputs:
  - id: bioplatforms_url
    type: string
    doc: URL of the file to download from Bioplatforms.
    inputBinding:
      position: 1
  - id: file_name
    type: string
    doc: The name to save the downloaded file as.
    inputBinding:
      position: 2
  - id: file_checksum
    type:
      - 'null'
      - File
    doc: Optional checksum file to verify the download.
    inputBinding:
      position: 103
      prefix: --file_checksum
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atol-genome-launcher:0.4.1--pyhdfd78af_0
stdout: atol-genome-launcher_bpa-file-downloader.out
