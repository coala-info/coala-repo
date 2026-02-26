cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - create_library
label: nebulizer_create_library
doc: "Create new data library.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy_name
    type: string
    doc: Name of the new library in GALAXY
    inputBinding:
      position: 1
  - id: description
    type:
      - 'null'
      - string
    doc: description of the new library
    inputBinding:
      position: 102
      prefix: --description
  - id: synopsis
    type:
      - 'null'
      - string
    doc: synopsis text for the new library
    inputBinding:
      position: 102
      prefix: --synopsis
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_create_library.out
