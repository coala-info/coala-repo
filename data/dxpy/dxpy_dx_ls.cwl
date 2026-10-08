cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dx
  - ls
label: dxpy_dx_ls
doc: 'List folders and/or objects in a folder


  Tool homepage: https://github.com/dnanexus/dx-toolkit'
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: object_path
    type:
      - 'null'
      - string
    doc: 'Folder (possibly in another project) to list the contents of, default is
      the current directory in the current project. Syntax: projectID:/folder/path'
    inputBinding:
      position: 1
  - id: color
    type:
      - 'null'
      - string
    doc: Set when color is used (color=auto is used when stdout is a TTY)
    inputBinding:
      position: 101
      prefix: --color
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Always use exactly one of DELIMITER to separate fields to be printed; if
      no delimiter is provided with this flag, TAB will be used
    inputBinding:
      position: 101
      prefix: --delimiter
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
  - id: all
    type:
      - 'null'
      - boolean
    doc: show hidden files
    inputBinding:
      position: 101
      prefix: --all
  - id: long
    type:
      - 'null'
      - boolean
    doc: Alias for "verbose"
    inputBinding:
      position: 101
      prefix: --long
  - id: obj
    type:
      - 'null'
      - boolean
    doc: show only objects
    inputBinding:
      position: 101
      prefix: --obj
  - id: folders
    type:
      - 'null'
      - boolean
    doc: show only folders
    inputBinding:
      position: 101
      prefix: --folders
  - id: full
    type:
      - 'null'
      - boolean
    doc: show full paths of folders
    inputBinding:
      position: 101
      prefix: --full
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
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
stdout: dxpy_dx_ls.out
