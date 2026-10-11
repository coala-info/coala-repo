cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
label: nebulizer_list_keys
doc: "List stored Galaxy API key aliases.\n\n  Prints a list of stored aliases with\
  \ the associated Galaxy URLs;\n  optionally also show the API key string.\n\nTool\
  \ homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: name
    type:
      - 'null'
      - string
    doc: "list only aliases matching name. Can include glob-style\n              \
      \         wild-cards."
    inputBinding:
      position: 111
      prefix: --name
  - id: show_api_keys
    type:
      - 'null'
      - boolean
    doc: show the API key string associated with each alias
    inputBinding:
      position: 111
      prefix: --show-api-keys
  - id: keys_file
    type:
      - 'null'
      - File
    doc: Stored Galaxy URLs and API keys (the ~/.nebulizer file); staged as .nebulizer
      in the working directory so that the command sees these aliases
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: keys_file_out
    type:
      - 'null'
      - File
    doc: The .nebulizer file after the command (stored Galaxy URLs and API keys)
    outputBinding:
      glob: .nebulizer
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.keys_file ? [{"entryname": ".nebulizer", "entry": inputs.keys_file,
      "writable": true}] : [])'
arguments:
  - position: 8
    valueFrom: list_keys
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_list_keys.out
