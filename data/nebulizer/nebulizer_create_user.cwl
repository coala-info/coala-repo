cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
label: nebulizer_create_user
doc: "Create new Galaxy user.\n\nCreates a new user in GALAXY, using EMAIL for the\
  \ username. If PUBLIC_NAME\nis not supplied then it will be generated automatically\
  \ from the leading\npart of the email address.\n\nIf a password for the new account\
  \ is not supplied using the --password\noption then nebulizer will prompt for one.\n\
  \nTool homepage: https://github.com/pjbriggs/nebulizer"
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
    doc: GALAXY instance identifier
    inputBinding:
      position: 11
  - id: email
    type: string
    doc: Email address for the new user
    inputBinding:
      position: 12
  - id: public_name
    type:
      - 'null'
      - string
    doc: Public name for the new user (defaults to part of email)
    inputBinding:
      position: 13
  - id: check
    type:
      - 'null'
      - boolean
    doc: check user details but don't try to create the new account
    inputBinding:
      position: 114
      prefix: --check
  - id: message
    type:
      - 'null'
      - File
    doc: Mako template to populate and output
    inputBinding:
      position: 114
      prefix: --message
  - id: password
    type:
      - 'null'
      - string
    doc: specify password for new user account (otherwise program will prompt for
      password)
    inputBinding:
      position: 114
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
    valueFrom: create_user
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_create_user.out
