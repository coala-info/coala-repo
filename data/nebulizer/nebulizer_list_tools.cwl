cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
label: nebulizer_list_tools
doc: "List information about tools and installed tool repositories.\n\nTool homepage:\
  \ https://github.com/pjbriggs/nebulizer"
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
  - id: built_in
    type:
      - 'null'
      - boolean
    doc: include built-in tools. (NB this option is ignored in 'export' mode.)
    inputBinding:
      position: 112
      prefix: --built-in
  - id: check_toolshed
    type:
      - 'null'
      - boolean
    doc: check installed revisions directly against those available in the toolshed.
      NB this can be extremely slow.
    inputBinding:
      position: 112
      prefix: --check-toolshed
  - id: mode
    type:
      - 'null'
      - string
    doc: 'set reporting mode: either ''repos'' (repository-centric view, the default),
      ''tools'' (tool-centric view) or ''export'' (tab-delimited format for use with
      ''install_tool'').'
    inputBinding:
      position: 112
      prefix: --mode
  - id: name
    type:
      - 'null'
      - string
    doc: only list tool repositories matching NAME. Can include glob-style wild-cards.
    inputBinding:
      position: 112
      prefix: --name
  - id: owner
    type:
      - 'null'
      - string
    doc: only list repositories from matching OWNER. Can include glob-style wild-cards.
    inputBinding:
      position: 112
      prefix: --owner
  - id: toolshed
    type:
      - 'null'
      - string
    doc: only list repositories installed from toolshed matching TOOLSHED. Can include
      glob-style wild-cards.
    inputBinding:
      position: 112
      prefix: --toolshed
  - id: updateable
    type:
      - 'null'
      - boolean
    doc: only show repositories with uninstalled updates or upgrades.
    inputBinding:
      position: 112
      prefix: --updateable
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
arguments:
  - position: 8
    valueFrom: list_tools
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_list_tools.out
