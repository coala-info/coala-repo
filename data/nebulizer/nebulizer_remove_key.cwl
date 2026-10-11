cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sh
  - -c
  - echo y | nebulizer "$@"
  - nebulizer
label: nebulizer_remove_key
doc: "Remove stored Galaxy API key.\n\nRemoves the Galaxy URL/API key pair associated\
  \ with ALIAS from the list of\nstored keys.\n\nTool homepage: https://github.com/pjbriggs/nebulizer\n\
  \nThe tool asks for confirmation before removing the key; this wrapper answers y."
inputs:
  - id: alias
    type: string
    doc: ALIAS
    inputBinding:
      position: 11
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
    valueFrom: remove_key
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_remove_key.out
