cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - add_key
label: nebulizer_add_key
doc: "Store new Galaxy URL and API key.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: alias
    type: string
    doc: ALIAS is the name that the instance will be stored against
    inputBinding:
      position: 1
  - id: galaxy_url
    type: string
    doc: GALAXY_URL is the URL for the instance
    inputBinding:
      position: 2
  - id: api_key
    type:
      - 'null'
      - string
    doc: API_KEY is the corresponding API key. If API_KEY is not supplied then 
      nebulizer will attempt to fetch one automatically.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_add_key.out
