cwlVersion: v1.2
class: CommandLineTool
baseCommand: nebulizer_list_keys
label: nebulizer_list_keys
doc: "List stored Galaxy API key aliases.\n\n  Prints a list of stored aliases with
  the associated Galaxy URLs;\n  optionally also show the API key string.\n\nTool
  homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: name
    type:
      - 'null'
      - string
    doc: "list only aliases matching name. Can include glob-style\n              \
      \         wild-cards."
    inputBinding:
      position: 101
      prefix: --name
  - id: show_api_keys
    type:
      - 'null'
      - boolean
    doc: show the API key string associated with each alias
    inputBinding:
      position: 101
      prefix: --show-api-keys
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_list_keys.out
