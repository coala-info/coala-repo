cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
label: nebulizer_quota_mod
doc: "Modify an existing quota.\n\n  Updates the definition of the existing QUOTA\
  \ in GALAXY.\n\n  The command line arguments can be used to modify any of the quota's\n\
  \  attributes, to set a new name, description or quota size and type.\n\n  Users\
  \ and groups can also be associated with or disassociated from the\n  quota, and\
  \ deleted quotas can be restored and modified.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy_api_key
    type:
      - 'null'
      - string
    doc: specify API key to use for connecting to Galaxy instance. Must be supplied
      if there is no API key stored for the specified instance, (unless the username
      option is specified). If there is a stored API key this overrides it.
    inputBinding:
      position: 1
      prefix: --api_key
  - id: username
    type:
      - 'null'
      - string
    doc: specify username (i.e. email) for connecting to Galaxy instance, as an alternative
      to using the API key. Prompts for a password unless one is supplied via the
      galaxy_password option.
    inputBinding:
      position: 2
      prefix: --username
  - id: galaxy_password
    type:
      - 'null'
      - string
    doc: supply password for connecting to Galaxy instance, when using the username
      option.
    inputBinding:
      position: 3
      prefix: --galaxy_password
  - id: no_verify
    type:
      - 'null'
      - boolean
    doc: don't verify HTTPS connections when connecting to Galaxy instance. Use this
      when interacting with Galaxy instances which use self-signed certificates.
    inputBinding:
      position: 4
      prefix: --no-verify
  - id: suppress_warnings
    type:
      - 'null'
      - boolean
    doc: suppress warning messages from nebulizer.
    inputBinding:
      position: 5
      prefix: --suppress-warnings
  - id: debug
    type:
      - 'null'
      - boolean
    doc: turn on debugging output.
    inputBinding:
      position: 6
      prefix: --debug
  - id: galaxy
    type: string
    doc: Galaxy instance identifier
    inputBinding:
      position: 11
  - id: quota
    type: string
    doc: Quota identifier
    inputBinding:
      position: 12
  - id: add_groups
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of group names to associate with the\n                            \
      \      quota, separated by commas."
    inputBinding:
      position: 113
      prefix: --add-groups
      itemSeparator: ','
  - id: add_users
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of user emails to associate with the\n                            \
      \      quota, separated by commas."
    inputBinding:
      position: 113
      prefix: --add-users
      itemSeparator: ','
  - id: default_for
    type:
      - 'null'
      - string
    doc: "set the quota as the default for either\n                              \
      \    'registered' or 'unregistered' users."
    inputBinding:
      position: 113
      prefix: --default_for
  - id: new_description
    type:
      - 'null'
      - string
    doc: new description for the quota.
    inputBinding:
      position: 113
      prefix: --description
  - id: new_name
    type:
      - 'null'
      - string
    doc: new name for the quota.
    inputBinding:
      position: 113
      prefix: --name
  - id: new_quota_size
    type:
      - 'null'
      - string
    doc: "new quota size in the form\n                                  '[OPERATION][AMOUNT]'\
      \ (e.g. '=0.2T')."
    inputBinding:
      position: 113
      prefix: --quota-size
  - id: remove_groups
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of group names to disassociate from the\n                         \
      \         quota, separated by commas."
    inputBinding:
      position: 113
      prefix: --remove-groups
      itemSeparator: ','
  - id: remove_users
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of user emails to disassociate from the\n                         \
      \         quota, separated by commas."
    inputBinding:
      position: 113
      prefix: --remove-users
      itemSeparator: ','
  - id: undelete
    type:
      - 'null'
      - boolean
    doc: restores a previously deleted quota
    inputBinding:
      position: 113
      prefix: --undelete
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
arguments:
  - position: 8
    valueFrom: quota_mod
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_quota_mod.out
