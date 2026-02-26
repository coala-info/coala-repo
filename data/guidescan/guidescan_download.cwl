cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - guidescan
  - download
label: guidescan_download
doc: "Downloads GuideScan data over HTTP.\n\nTool homepage: https://github.com/pritykinlab/guidescan-cli"
inputs:
  - id: download_url
    type:
      - 'null'
      - string
    doc: Endpoint for Download API
    default: http://guidescan.com:8000/download
    inputBinding:
      position: 101
      prefix: --download-url
  - id: item
    type:
      - 'null'
      - string
    doc: Download Item
    inputBinding:
      position: 101
      prefix: --item
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output Directory
    default: .
    inputBinding:
      position: 101
      prefix: --output-directory
  - id: show
    type:
      - 'null'
      - string
    doc: Show Options for type or item
    inputBinding:
      position: 101
      prefix: --show
  - id: type
    type:
      - 'null'
      - string
    doc: Download Type
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/guidescan:2.2.1--h4ac6f70_2
stdout: guidescan_download.out
