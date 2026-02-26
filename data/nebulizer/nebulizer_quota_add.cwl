cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - quota_add
label: nebulizer_quota_add
doc: "Create new quota.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy
    type: string
    doc: Galaxy name for the quota
    inputBinding:
      position: 1
  - id: name
    type: string
    doc: Name of the new quota
    inputBinding:
      position: 2
  - id: quota
    type: string
    doc: Type of quota, format [OPERATION][AMOUNT]
    inputBinding:
      position: 3
  - id: default_for
    type:
      - 'null'
      - string
    doc: set the quota as the default for either 'registered' or 'unregistered' 
      users.
    inputBinding:
      position: 104
      prefix: --default_for
  - id: description
    type:
      - 'null'
      - string
    doc: description of the new quota (will be the same as the NAME if not 
      supplied).
    inputBinding:
      position: 104
      prefix: --description
  - id: groups
    type:
      - 'null'
      - type: array
        items: string
    doc: list of group names to associate with the quota, separated by commas.
    inputBinding:
      position: 104
      prefix: --groups
  - id: users
    type:
      - 'null'
      - type: array
        items: string
    doc: list of user emails to associate with the quota, separated by commas.
    inputBinding:
      position: 104
      prefix: --users
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_quota_add.out
