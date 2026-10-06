cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - event
  - list
label: anchore-cli_event_list
doc: "List events\n\nThis command talks to a running Anchore Engine server; give its URL, user and password.\n\nTool homepage: https://github.com/anchore/anchore-cli"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: ANCHORE_CLI_URL
        envValue: $(inputs.anchore_url)
      - envName: ANCHORE_CLI_USER
        envValue: $(inputs.anchore_user)
      - envName: ANCHORE_CLI_PASS
        envValue: $(inputs.anchore_password)
      - envName: ANCHORE_CLI_JSON
        envValue: '$(inputs.json_output ? "y" : "n")'
inputs:
  - id: anchore_url
    type: string
    doc: Anchore Engine service URL, e.g. http://localhost:8228/v1 (sets ANCHORE_CLI_URL)
  - id: anchore_user
    type: string
    doc: Anchore Engine user name (sets ANCHORE_CLI_USER)
  - id: anchore_password
    type: string
    doc: Anchore Engine password (sets ANCHORE_CLI_PASS)
  - id: json_output
    type:
      - 'null'
      - boolean
    doc: Output raw API JSON (sets ANCHORE_CLI_JSON=y)
  - id: since
    type:
      - 'null'
      - string
    doc: "ISO8601 formatted UTC timestamp to filter events that occurred after the timestamp"
    inputBinding:
      position: 1
      prefix: --since
  - id: before
    type:
      - 'null'
      - string
    doc: "ISO8601 formatted UTC timestamp to filter events that occurred before the timestamp"
    inputBinding:
      position: 1
      prefix: --before
  - id: level
    type:
      - 'null'
      - string
    doc: "Filter results based on the level, supported levels are info and error"
    inputBinding:
      position: 1
      prefix: --level
  - id: service
    type:
      - 'null'
      - string
    doc: "Filter events based on the originating service"
    inputBinding:
      position: 1
      prefix: --service
  - id: host
    type:
      - 'null'
      - string
    doc: "Filter events based on the originating host"
    inputBinding:
      position: 1
      prefix: --host
  - id: all
    type:
      - 'null'
      - boolean
    doc: "Display all results. If not specified only the first 100 events are displayed"
    inputBinding:
      position: 1
      prefix: --all
  - id: resource
    type:
      - 'null'
      - string
    doc: "A tag, image digest or repository name"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Command output (text table, or JSON when json_output is set)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_event_list.out
