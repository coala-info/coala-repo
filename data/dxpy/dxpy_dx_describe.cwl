cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dx
  - describe
label: dxpy_dx_describe
doc: 'Describe a DNAnexus entity.  Use this command to describe data objects by name
  or ID, jobs, apps, users, organizations, etc.  If using the "--json" flag, it will
  thrown an error if more than one match is found (but if you would like a JSON array
  of the describe hashes of all matches, then provide the "--multi" flag).  Otherwise,
  it will always display all results it finds.


  Tool homepage: https://github.com/dnanexus/dx-toolkit'
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: object_path
    type: string
    doc: Object ID or path to an object (possibly in another project) to describe.
    inputBinding:
      position: 1
  - id: json
    type:
      - 'null'
      - boolean
    doc: Display return value in JSON
    inputBinding:
      position: 101
      prefix: --json
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
  - id: details
    type:
      - 'null'
      - boolean
    doc: Include details of data objects
    inputBinding:
      position: 101
      prefix: --details
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Include additional metadata
    inputBinding:
      position: 101
      prefix: --verbose
  - id: name
    type:
      - 'null'
      - boolean
    doc: Only print the matching names, one per line
    inputBinding:
      position: 101
      prefix: --name
  - id: multi
    type:
      - 'null'
      - boolean
    doc: If the flag --json is also provided, then returns a JSON array of describe
      hashes of all matching results
    inputBinding:
      position: 101
      prefix: --multi
  - id: try
    type:
      - 'null'
      - string
    doc: When describing a job that was restarted, describe job try T. T=0 refers
      to the first try. Default is the last job try.
    inputBinding:
      position: 101
      prefix: --try
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
stdout: dxpy_dx_describe.out
