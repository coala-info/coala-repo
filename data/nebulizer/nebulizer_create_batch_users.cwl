cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
label: nebulizer_create_batch_users
doc: "Create multiple Galaxy users from a template.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
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
    doc: GALAXY instance or identifier
    inputBinding:
      position: 11
  - id: template
    type: string
    doc: Template email address with '#' as placeholder for index
    inputBinding:
      position: 12
  - id: start
    type: int
    doc: Start of the integer range for user creation
    inputBinding:
      position: 13
  - id: end
    type:
      - 'null'
      - int
    doc: End of the integer range for user creation (defaults to START if not provided)
    inputBinding:
      position: 14
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check user details but don't try to create the new account.
    inputBinding:
      position: 115
      prefix: --check
  - id: password
    type:
      - 'null'
      - string
    doc: Specify password for new user accounts (otherwise program will prompt for
      password). All accounts will be created with the same password.
    inputBinding:
      position: 115
      prefix: --password
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
arguments:
  - position: 8
    valueFrom: create_batch_users
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_create_batch_users.out
