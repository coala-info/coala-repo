cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dx
  - upload
label: dxpy_dx_upload
doc: 'Upload local file(s) or directory. If "-" is provided, stdin will be used instead.
  By default, the filename will be used as its new name. If --path/--destination is
  provided with a path ending in a slash, the filename will be used, and the folder
  path will be used as a destination. If it does not end in a slash, then it will
  be used as the final name.


  Tool homepage: https://github.com/dnanexus/dx-toolkit'
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: filename
    type:
      type: array
      items:
        - File
        - Directory
    doc: Local file(s) or directories to upload
    inputBinding:
      position: 1
  - id: brief
    type:
      - 'null'
      - boolean
    doc: Display a brief version of the return value; for most commands, prints a
      DNAnexus ID per line
    inputBinding:
      position: 101
      prefix: --brief
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: If available, displays extra verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: dx_path
    type:
      - 'null'
      - string
    doc: DNAnexus path to upload file(s) to (default uses current project and folder
      if not provided)
    inputBinding:
      position: 101
      prefix: --path
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Upload directories recursively
    inputBinding:
      position: 101
      prefix: --recursive
  - id: wait
    type:
      - 'null'
      - boolean
    doc: Wait until the file has finished closing
    inputBinding:
      position: 101
      prefix: --wait
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Do not show a progress bar
    inputBinding:
      position: 101
      prefix: --no-progress
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Set the write buffer size (in bytes)
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: singlethread
    type:
      - 'null'
      - boolean
    doc: Enable singlethreaded uploading
    inputBinding:
      position: 101
      prefix: --singlethread
  - id: visibility
    type:
      - 'null'
      - string
    doc: Whether the object is hidden or not
    inputBinding:
      position: 101
      prefix: --visibility
  - id: property
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --property
    doc: Key-value pair to add as a property; repeat as necessary, e.g. "--property
      key1=val1 --property key2=val2"
    inputBinding:
      position: 101
  - id: type
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --type
    doc: Type of the data object; repeat as necessary, e.g. "-- type type1 --type
      type2"
    inputBinding:
      position: 101
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --tag
    doc: Tag of the data object; repeat as necessary, e.g. "-- tag tag1 --tag tag2"
    inputBinding:
      position: 101
  - id: details
    type:
      - 'null'
      - string
    doc: JSON to store as details
    inputBinding:
      position: 101
      prefix: --details
  - id: parents
    type:
      - 'null'
      - boolean
    doc: Create any parent folders necessary
    inputBinding:
      position: 101
      prefix: --parents
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
  - id: stdout
    type: stdout
    doc: Description of the uploaded object(s) (IDs with --brief)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
stdout: dxpy_dx_upload.out
