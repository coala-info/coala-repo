cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
label: nebulizer_add_library_datasets
doc: "Add datasets to a data library.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
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
    doc: URL or stored alias of the Galaxy instance
    inputBinding:
      position: 11
  - id: dest
    type: string
    doc: Path to a data library or library folder of the form 'data_library[/folder[/subfolder[...]]]';
      it must already exist
    inputBinding:
      position: 12
  - id: files
    type:
      type: array
      items: File
    doc: One or more files to upload as new datasets.
    inputBinding:
      position: 13
  - id: dbkey
    type:
      - 'null'
      - string
    doc: dbkey to assign to files
    inputBinding:
      position: 113
      prefix: --dbkey
  - id: file_type
    type:
      - 'null'
      - string
    doc: Galaxy data type to assign the files to. Must be a valid Galaxy data type.
      If not 'auto' then all files will be assigned the same type.
    inputBinding:
      position: 113
      prefix: --file-type
  - id: link
    type:
      - 'null'
      - boolean
    doc: Create symlinks to files on server (only valid if used with --server; default
      is to copy files into Galaxy)
    inputBinding:
      position: 113
      prefix: --link
  - id: server
    type:
      - 'null'
      - boolean
    doc: Upload files from the Galaxy server file system (default is to upload files
      from local system)
    inputBinding:
      position: 113
      prefix: --server
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
arguments:
  - position: 8
    valueFrom: add_library_datasets
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_add_library_datasets.out
