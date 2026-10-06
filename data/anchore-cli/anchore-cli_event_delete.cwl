cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - event
  - delete
label: anchore-cli_event_delete
doc: "Delete one or more events\n\nThis command talks to a running Anchore Engine server; give its URL, user and password.\n\nTool homepage: https://github.com/anchore/anchore-cli"
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
    doc: "Specify an ISO8601 formatted UTC timestamp to delete events that occurred after the timestamp"
    inputBinding:
      position: 1
      prefix: --since
  - id: before
    type:
      - 'null'
      - string
    doc: "Specify an ISO8601 formatted UTC timestamp to delete events that occurred before the timestamp"
    inputBinding:
      position: 1
      prefix: --before
  - id: dontask
    type:
      - 'null'
      - boolean
    doc: "Do not ask for confirmation when omitting event_id, since and before (i.e. delete all events)"
    inputBinding:
      position: 1
      prefix: --dontask
  - id: event_id
    type:
      - 'null'
      - string
    doc: "Event ID"
    inputBinding:
      position: 2
  - id: all
    type:
      - 'null'
      - boolean
    doc: "Delete all events"
    inputBinding:
      position: 1
      prefix: --all
outputs:
  - id: stdout
    type: stdout
    doc: Command output (text table, or JSON when json_output is set)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_event_delete.out
