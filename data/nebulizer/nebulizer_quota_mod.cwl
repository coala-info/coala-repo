cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - quota_mod
label: nebulizer_quota_mod
doc: "Modify an existing quota.\n\n  Updates the definition of the existing QUOTA
  in GALAXY.\n\n  The command line arguments can be used to modify any of the quota's\n\
  \  attributes, to set a new name, description or quota size and type.\n\n  Users
  and groups can also be associated with or disassociated from the\n  quota, and deleted
  quotas can be restored and modified.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy
    type: string
    doc: Galaxy instance identifier
    inputBinding:
      position: 1
  - id: quota
    type: string
    doc: Quota identifier
    inputBinding:
      position: 2
  - id: add_groups
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of group names to associate with the\n                            \
      \      quota, separated by commas."
    inputBinding:
      position: 103
      prefix: --add-groups
  - id: add_users
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of user emails to associate with the\n                            \
      \      quota, separated by commas."
    inputBinding:
      position: 103
      prefix: --add-users
  - id: default_for
    type:
      - 'null'
      - string
    doc: "set the quota as the default for either\n                              \
      \    'registered' or 'unregistered' users."
    inputBinding:
      position: 103
      prefix: --default_for
  - id: new_description
    type:
      - 'null'
      - string
    doc: new description for the quota.
    inputBinding:
      position: 103
      prefix: --description
  - id: new_name
    type:
      - 'null'
      - string
    doc: new name for the quota.
    inputBinding:
      position: 103
      prefix: --name
  - id: new_quota_size
    type:
      - 'null'
      - string
    doc: "new quota size in the form\n                                  '[OPERATION][AMOUNT]'
      (e.g. '=0.2T')."
    inputBinding:
      position: 103
      prefix: --quota-size
  - id: remove_groups
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of group names to disassociate from the\n                         \
      \         quota, separated by commas."
    inputBinding:
      position: 103
      prefix: --remove-groups
  - id: remove_users
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of user emails to disassociate from the\n                         \
      \         quota, separated by commas."
    inputBinding:
      position: 103
      prefix: --remove-users
  - id: undelete
    type:
      - 'null'
      - boolean
    doc: restores a previously deleted quota
    inputBinding:
      position: 103
      prefix: --undelete
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_quota_mod.out
