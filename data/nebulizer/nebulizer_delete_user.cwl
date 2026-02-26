cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - delete_user
label: nebulizer_delete_user
doc: "Delete a user account from a Galaxy instance\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy_instance
    type: string
    doc: Galaxy instance identifier
    inputBinding:
      position: 1
  - id: email
    type: string
    doc: User's email address
    inputBinding:
      position: 2
  - id: purge
    type:
      - 'null'
      - boolean
    doc: also purge (permanently delete) the user.
    inputBinding:
      position: 103
      prefix: --purge
  - id: yes
    type:
      - 'null'
      - boolean
    doc: don't ask for confirmation of deletions.
    inputBinding:
      position: 103
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_delete_user.out
