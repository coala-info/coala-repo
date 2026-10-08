cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dx
  - get
label: dxpy_dx_get
doc: 'Download the contents of some types of data (records, apps, applets, workflows,
  files, and databases). Downloading an app, applet or a workflow will attempt to
  reconstruct a source directory that can be used to rebuild it with "dx build". Use
  "-o -" to direct the output to stdout.


  Tool homepage: https://github.com/dnanexus/dx-toolkit'
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
inputs:
  - id: object_path
    type: string
    doc: Data object ID or name to access
    inputBinding:
      position: 1
  - id: output
    type:
      - 'null'
      - string
    doc: local file path where the data is to be saved ("-" indicates stdout output
      for objects of class file and record). If not supplied, the object's name on
      the platform will be used, along with any applicable extensions. For app(let)
      and workflow objects, if OUTPUT does not exist, the object's source directory
      will be created there; if OUTPUT is an existing directory, a new directory with
      the object's name will be created inside it.
    inputBinding:
      position: 101
      prefix: --output
  - id: filename
    type:
      - 'null'
      - string
    doc: When downloading from a database, name of the file or folder to be downloaded.
      If omitted, all files in the database will be downloaded, so use caution and
      include the --allow-all-files argument.
    inputBinding:
      position: 101
      prefix: --filename
  - id: allow_all_files
    type:
      - 'null'
      - boolean
    doc: When downloading from a database, this allows all files in a database to
      be downloaded when --filename argument is omitted.
    inputBinding:
      position: 101
      prefix: --allow-all-files
  - id: recurse
    type:
      - 'null'
      - boolean
    doc: When downloading from a database, look for files recursively down the directory
      structure. Otherwise, by default, only look on one level.
    inputBinding:
      position: 101
      prefix: --recurse
  - id: no_ext
    type:
      - 'null'
      - boolean
    doc: If -o is not provided, do not add an extension to the filename
    inputBinding:
      position: 101
      prefix: --no-ext
  - id: omit_resources
    type:
      - 'null'
      - boolean
    doc: When downloading an app(let), omit fetching the resources associated with
      the app(let).
    inputBinding:
      position: 101
      prefix: --omit-resources
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite the local file if necessary
    inputBinding:
      position: 101
      prefix: --overwrite
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
    doc: Downloaded data object or reconstructed app(let)/workflow source directory
    outputBinding:
      glob: '$(inputs.output ? inputs.output : ''*'')'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
