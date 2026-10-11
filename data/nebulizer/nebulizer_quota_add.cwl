cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
label: nebulizer_quota_add
doc: "Create new quota.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
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
    doc: Galaxy name for the quota
    inputBinding:
      position: 11
  - id: name
    type: string
    doc: Name of the new quota
    inputBinding:
      position: 12
  - id: quota
    type: string
    doc: Type of quota, format [OPERATION][AMOUNT]
    inputBinding:
      position: 13
  - id: default_for
    type:
      - 'null'
      - string
    doc: set the quota as the default for either 'registered' or 'unregistered' users.
    inputBinding:
      position: 114
      prefix: --default_for
  - id: description
    type:
      - 'null'
      - string
    doc: description of the new quota (will be the same as the NAME if not supplied).
    inputBinding:
      position: 114
      prefix: --description
  - id: groups
    type:
      - 'null'
      - type: array
        items: string
    doc: list of group names to associate with the quota, separated by commas.
    inputBinding:
      position: 114
      prefix: --groups
      itemSeparator: ','
  - id: users
    type:
      - 'null'
      - type: array
        items: string
    doc: list of user emails to associate with the quota, separated by commas.
    inputBinding:
      position: 114
      prefix: --users
      itemSeparator: ','
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
arguments:
  - position: 8
    valueFrom: quota_add
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_quota_add.out
