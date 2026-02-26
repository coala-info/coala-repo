cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - config
label: nebulizer_config
doc: "Report the Galaxy configuration.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy
    type: string
    doc: Galaxy configuration to report
    inputBinding:
      position: 1
  - id: name
    type:
      - 'null'
      - string
    doc: only show configuration items that match NAME. Can include glob-style 
      wild-cards.
    inputBinding:
      position: 102
      prefix: --name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_config.out
