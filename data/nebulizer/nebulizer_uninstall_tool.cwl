cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
label: nebulizer_uninstall_tool
doc: "Uninstall previously installed tool.\n\nUninstalls the specified tool which\
  \ was previously installed from\nREPOSITORY into GALAXY, where REPOSITORY can be\
  \ as one of:\n\n- full URL (without revision) e.g.\nhttps://toolshed.g2.bx.psu.edu/view/devteam/fastqc\n\
  \n- OWNER/TOOLNAME combination e.g. devteam/fastqc (toolshed is assumed to\nbe main\
  \ Galaxy toolshed)\n\n- [ TOOLSHED ] OWNER TOOLNAME e.g. https://toolshed.g2.bx.psu.edu\
  \ devteam\nfastqc\n\nThe tool must already be present in GALAXY; a revision must\
  \ be specified\nif more than one revision is installed (use '*' to match all revisions).\n\
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
    doc: Galaxy instance to uninstall from
    inputBinding:
      position: 11
  - id: repositories
    type:
      type: array
      items: string
    doc: Repository/tool to uninstall
    inputBinding:
      position: 12
  - id: remove_from_disk
    type:
      - 'null'
      - boolean
    doc: "remove the uninstalled tool from disk (otherwise tool is\njust deactivated)."
    inputBinding:
      position: 113
      prefix: --remove_from_disk
  - id: assume_yes
    type:
      - 'null'
      - boolean
    doc: don't ask for confirmation of uninstallation.
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
    valueFrom: uninstall_tool
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_uninstall_tool.out
