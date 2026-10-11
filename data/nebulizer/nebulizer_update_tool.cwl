cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
label: nebulizer_update_tool
doc: "Update tool installed from toolshed.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
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
    doc: GALAXY instance to update tool into
    inputBinding:
      position: 11
  - id: repositories
    type:
      type: array
      items: string
    doc: Repository to update tool from (full URL, OWNER/TOOLNAME, or [TOOLSHED] OWNER
      TOOLNAME)
    inputBinding:
      position: 12
  - id: check_toolshed
    type:
      - 'null'
      - boolean
    doc: check installed revisions directly against those available in the toolshed.
    inputBinding:
      position: 113
      prefix: --check-toolshed
  - id: install_repository_dependencies
    type:
      - 'null'
      - string
    doc: install repository dependencies via the toolshed, if any are defined
    inputBinding:
      position: 113
      prefix: --install-repository-dependencies
  - id: install_resolver_dependencies
    type:
      - 'null'
      - string
    doc: install dependencies through a resolver that supports installation (e.g.
      conda)
    inputBinding:
      position: 113
      prefix: --install-resolver-dependencies
  - id: install_tool_dependencies
    type:
      - 'null'
      - string
    doc: install tool dependencies via the toolshed, if any are defined
    inputBinding:
      position: 113
      prefix: --install-tool-dependencies
  - id: no_wait
    type:
      - 'null'
      - boolean
    doc: don't wait for lengthy tool installations to complete.
    inputBinding:
      position: 113
      prefix: --no-wait
  - id: timeout
    type:
      - 'null'
      - int
    doc: wait up to TIMEOUT seconds for tool installations to complete
    inputBinding:
      position: 113
      prefix: --timeout
  - id: assume_yes
    type:
      - 'null'
      - boolean
    doc: don't ask for confirmation of updates.
    inputBinding:
      position: 113
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
arguments:
  - position: 8
    valueFrom: update_tool
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_update_tool.out
