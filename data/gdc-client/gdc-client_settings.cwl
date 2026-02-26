cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gdc-client
  - settings
label: gdc-client_settings
doc: "Manage gdc-client settings\n\nTool homepage: https://gdc.cancer.gov/access-data/gdc-data-transfer-tool"
inputs:
  - id: section
    type: string
    doc: Settings section to display (download or upload)
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: "Path to INI-type config file. See what settings will look\n            \
      \         like if a custom config file is used"
    inputBinding:
      position: 102
      prefix: --config
  - id: download
    type:
      - 'null'
      - boolean
    doc: Display download settings
    inputBinding:
      position: 102
  - id: upload
    type:
      - 'null'
      - boolean
    doc: Display upload settings
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdc-client:2.3--pyhdfd78af_1
stdout: gdc-client_settings.out
