cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
label: nebulizer_update_key
doc: "Update stored Galaxy API key.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
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
  - id: alias
    type: string
    doc: Alias for the Galaxy instance
    inputBinding:
      position: 11
  - id: fetch_api_key
    type:
      - 'null'
      - boolean
    doc: fetch new API key for Galaxy instance
    inputBinding:
      position: 112
      prefix: --fetch-api-key
  - id: new_api_key
    type:
      - 'null'
      - string
    doc: specify new API key for Galaxy instance
    inputBinding:
      position: 112
      prefix: --new-api-key
  - id: new_url
    type:
      - 'null'
      - string
    doc: specify new URL for Galaxy instance
    inputBinding:
      position: 112
      prefix: --new-url
  - id: keys_file
    type:
      - 'null'
      - File
    doc: Stored Galaxy URLs and API keys (the ~/.nebulizer file); staged as .nebulizer
      in the working directory so that the command sees these aliases
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: keys_file_out
    type:
      - 'null'
      - File
    doc: The .nebulizer file after the command (stored Galaxy URLs and API keys)
    outputBinding:
      glob: .nebulizer
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.keys_file ? [{"entryname": ".nebulizer", "entry": inputs.keys_file,
      "writable": true}] : [])'
  - class: NetworkAccess
    networkAccess: true
arguments:
  - position: 8
    valueFrom: update_key
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_update_key.out
