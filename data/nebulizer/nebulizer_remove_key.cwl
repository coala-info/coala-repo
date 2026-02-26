cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - remove_key
label: nebulizer_remove_key
doc: "Remove stored Galaxy API key.\n\nRemoves the Galaxy URL/API key pair associated
  with ALIAS from the list of\nstored keys.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: alias
    type: string
    doc: ALIAS
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_remove_key.out
