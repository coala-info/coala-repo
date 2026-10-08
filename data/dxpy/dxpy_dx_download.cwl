cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dx
  - download
label: dxpy_dx_download
doc: 'Download the contents of a file object or multiple objects. Use "-o -" to direct
  the output to stdout.


  Tool homepage: https://github.com/dnanexus/dx-toolkit'
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
inputs:
  - id: object_path
    type:
      type: array
      items: string
    doc: Data object ID or name, or folder to download
    inputBinding:
      position: 1
  - id: output
    type:
      - 'null'
      - string
    doc: Local filename or directory to be used ("-" indicates stdout output); if
      not supplied or a directory is given, the object's name on the platform will
      be used, along with any applicable extensions
    inputBinding:
      position: 101
      prefix: --output
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Resume an interupted download if the local and remote file signatures match.
      If the signatures do not match the local file will be overwritten.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Download folders recursively
    inputBinding:
      position: 101
      prefix: --recursive
  - id: all
    type:
      - 'null'
      - boolean
    doc: If multiple objects match the input, download all of them
    inputBinding:
      position: 101
      prefix: --all
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Do not show a progress bar
    inputBinding:
      position: 101
      prefix: --no-progress
  - id: lightweight
    type:
      - 'null'
      - boolean
    doc: Skip some validation steps to make fewer API calls
    inputBinding:
      position: 101
      prefix: --lightweight
  - id: symlink_max_tries
    type:
      - 'null'
      - int
    doc: Set maximum number of tries for downloading symlinked files using aria2c
    inputBinding:
      position: 101
      prefix: --symlink-max-tries
  - id: unicode
    type:
      - 'null'
      - boolean
    doc: Display the characters as text/unicode when writing to stdout
    inputBinding:
      position: 101
      prefix: --unicode
  - id: apiserver_host
    type:
      - 'null'
      - string
    doc: API server host (environment override option, see dx --env-help)
    inputBinding:
      position: 101
      prefix: --apiserver-host
  - id: apiserver_port
    type:
      - 'null'
      - string
    doc: API server port (environment override option, see dx --env-help)
    inputBinding:
      position: 101
      prefix: --apiserver-port
  - id: apiserver_protocol
    type:
      - 'null'
      - string
    doc: API server protocol (http or https) (environment override option, see dx
      --env-help)
    inputBinding:
      position: 101
      prefix: --apiserver-protocol
  - id: project_context_id
    type:
      - 'null'
      - string
    doc: Default project or project context ID (environment override option, see dx
      --env-help)
    inputBinding:
      position: 101
      prefix: --project-context-id
  - id: workspace_id
    type:
      - 'null'
      - string
    doc: Workspace ID (for jobs only) (environment override option, see dx --env-help)
    inputBinding:
      position: 101
      prefix: --workspace-id
  - id: security_context
    type:
      - 'null'
      - string
    doc: JSON string of security context (environment override option, see dx --env-help)
    inputBinding:
      position: 101
      prefix: --security-context
  - id: auth_token
    type:
      - 'null'
      - string
    doc: Authentication token (environment override option, see dx --env-help)
    inputBinding:
      position: 101
      prefix: --auth-token
outputs:
  - id: downloaded
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: Downloaded file(s) or folder(s)
    outputBinding:
      glob: '$(inputs.output ? inputs.output : ''*'')'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
