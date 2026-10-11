cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
label: nebulizer_list_users
doc: "List users in Galaxy instance.\n\n  Prints details of user accounts in GALAXY\
  \ instance.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
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
    doc: GALAXY instance
    inputBinding:
      position: 11
  - id: long_listing
    type:
      - 'null'
      - boolean
    doc: use a long listing format that includes ids, disk usage and admin status.
    inputBinding:
      position: 112
      prefix: --long
  - id: name
    type:
      - 'null'
      - string
    doc: list only users with matching email or user name. Can include glob-style
      wild-cards.
    inputBinding:
      position: 112
      prefix: --name
  - id: show_id
    type:
      - 'null'
      - boolean
    doc: include internal Galaxy user ID.
    inputBinding:
      position: 112
      prefix: --show_id
  - id: sort
    type:
      - 'null'
      - string
    doc: comma-separated list of fields to output on; valid fields are 'email', 'disk_usage',
      'quota', 'quota_usage'
    inputBinding:
      position: 112
      prefix: --sort
  - id: status
    type:
      - 'null'
      - string
    doc: list users with the specified status; can be one of 'active', 'deleted',
      'purged', 'all'
    inputBinding:
      position: 112
      prefix: --status
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
arguments:
  - position: 8
    valueFrom: list_users
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_list_users.out
