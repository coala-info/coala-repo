cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - update_key
label: nebulizer_update_key
doc: "Update stored Galaxy API key.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: alias
    type: string
    doc: Alias for the Galaxy instance
    inputBinding:
      position: 1
  - id: fetch_api_key
    type:
      - 'null'
      - boolean
    doc: fetch new API key for Galaxy instance
    inputBinding:
      position: 102
      prefix: --fetch-api-key
  - id: new_api_key
    type:
      - 'null'
      - string
    doc: specify new API key for Galaxy instance
    inputBinding:
      position: 102
      prefix: --new-api-key
  - id: new_url
    type:
      - 'null'
      - string
    doc: specify new URL for Galaxy instance
    inputBinding:
      position: 102
      prefix: --new-url
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_update_key.out
