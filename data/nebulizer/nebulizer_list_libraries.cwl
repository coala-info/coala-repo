cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
label: nebulizer_list_libraries
doc: "List data libraries and contents.\n\n  Prints details of the data library and\
  \ folders specified by PATH, in\n  GALAXY instance.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
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
  - id: path
    type:
      - 'null'
      - string
    doc: PATH should be of the form 'data_library[/folder[/subfolder[...]]]' (data
      library and folders)
    inputBinding:
      position: 12
  - id: long_listing
    type:
      - 'null'
      - boolean
    doc: "use a long listing format that includes descriptions, file sizes,\ndbkeys\
      \ and paths)"
    inputBinding:
      position: 113
      prefix: -l
  - id: show_id
    type:
      - 'null'
      - boolean
    doc: "include internal Galaxy IDs for data libraries, folders and\ndatasets."
    inputBinding:
      position: 113
      prefix: --show_id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
arguments:
  - position: 8
    valueFrom: list_libraries
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_list_libraries.out
