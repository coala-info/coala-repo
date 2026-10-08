cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dx
  - find
  - data
label: dxpy_dx_find_data
doc: 'Finds data objects subject to the given search parameters. By default, restricts
  the search to the current project if set. To search over all projects (excluding
  public projects), use --all-projects (overrides --path and --norecurse).


  Tool homepage: https://github.com/dnanexus/dx-toolkit'
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
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
  - id: property
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --property
    doc: Key-value pair of a property or simply a property key; if only a key is provided,
      matches a result that has the key with any value; repeat as necessary, e.g.
      "-- property key1=val1 --property key2"
    inputBinding:
      position: 101
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --tag
    doc: Tag to match; repeat as necessary, e.g. "--tag tag1 --tag tag2" will require
      both tags
    inputBinding:
      position: 101
  - id: object_class
    type:
      - 'null'
      - string
    doc: Data object class
    inputBinding:
      position: 101
      prefix: --class
  - id: state
    type:
      - 'null'
      - string
    doc: State of the object
    inputBinding:
      position: 101
      prefix: --state
  - id: visibility
    type:
      - 'null'
      - string
    doc: Whether the object is hidden or not
    inputBinding:
      position: 101
      prefix: --visibility
  - id: name
    type:
      - 'null'
      - string
    doc: Search criteria for the object name, interpreted according to the --name-mode
    inputBinding:
      position: 101
      prefix: --name
  - id: name_mode
    type:
      - 'null'
      - string
    doc: Name mode to use for searching
    inputBinding:
      position: 101
      prefix: --name-mode
  - id: type
    type:
      - 'null'
      - string
    doc: Type of the data object
    inputBinding:
      position: 101
      prefix: --type
  - id: link
    type:
      - 'null'
      - string
    doc: Object ID that the data object links to
    inputBinding:
      position: 101
      prefix: --link
  - id: all_projects
    type:
      - 'null'
      - boolean
    doc: Extend search to all projects (excluding public projects)
    inputBinding:
      position: 101
      prefix: --all-projects
  - id: dx_path
    type:
      - 'null'
      - string
    doc: Project and/or folder in which to restrict the results
    inputBinding:
      position: 101
      prefix: --path
  - id: norecurse
    type:
      - 'null'
      - boolean
    doc: Do not recurse into subfolders
    inputBinding:
      position: 101
      prefix: --norecurse
  - id: created_after
    type:
      - 'null'
      - string
    doc: Date (e.g. --created-after="2021-12-01" or --created- after="2021-12-01 19:01:33")
      or integer Unix epoch timestamp in milliseconds (e.g. --created- after=1642196636000)
      after which the object was created. You can also specify negative numbers to
      indicate a time period in the past suffixed by s, m, h, d, w, M or y to indicate
      seconds, minutes, hours, days, weeks, months or years (e.g. --created-after=-2d
      for objects created in the last 2 days).
    inputBinding:
      position: 101
      prefix: --created-after
  - id: created_before
    type:
      - 'null'
      - string
    doc: Date (e.g. --created-before="2021-12-01" or --created- before="2021-12-01
      19:01:33") or integer Unix epoch timestamp in milliseconds (e.g. --created-
      before=1642196636000) before which the object was created. You can also specify
      negative numbers to indicate a time period in the past suffixed by s, m, h,
      d, w, M or y to indicate seconds, minutes, hours, days, weeks, months or years
      (e.g. --created- before=-2d for objects created earlier than 2 days ago)
    inputBinding:
      position: 101
      prefix: --created-before
  - id: mod_after
    type:
      - 'null'
      - string
    doc: Date (e.g. --mod-after="2021-12-01" or --mod- after="2021-12-01 19:01:33")
      or integer Unix epoch timestamp in milliseconds (e.g. --mod- after=1642196636000)
      after which the object was modified. You can also specify negative numbers to
      indicate a time period in the past suffixed by s, m, h, d, w, M or y to indicate
      seconds, minutes, hours, days, weeks, months or years (e.g. --mod-after=-2d
      for objects modified in the last 2 days)
    inputBinding:
      position: 101
      prefix: --mod-after
  - id: mod_before
    type:
      - 'null'
      - string
    doc: Date (e.g. --mod-before="2021-12-01" or --mod- before="2021-12-01 19:01:33")
      or integer Unix epoch timestamp in milliseconds (e.g. --mod- before=1642196636000)
      before which the object was modified. You can also specify negative numbers
      to indicate a time period in the past suffixed by s, m, h, d, w, M or y to indicate
      seconds, minutes, hours, days, weeks, months or years (e.g. --mod-before=-2d
      for objects modified earlier than 2 days ago)
    inputBinding:
      position: 101
      prefix: --mod-before
  - id: region
    type:
      - 'null'
      - string
    doc: Restrict the search to the provided region
    inputBinding:
      position: 101
      prefix: --region
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
stdout: dxpy_dx_find_data.out
