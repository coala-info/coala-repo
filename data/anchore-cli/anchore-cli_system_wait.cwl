cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - system
  - wait
label: anchore-cli_system_wait
doc: "Blocking operation that will return when anchore-engine is available and ready\n\nThis command talks to a running Anchore Engine server; give its URL, user and password.\n\nTool homepage: https://github.com/anchore/anchore-cli"
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
  - id: timeout
    type:
      - 'null'
      - float
    doc: "Time to wait, in seconds. If < 0, wait forever (default=-1)"
    inputBinding:
      position: 1
      prefix: --timeout
  - id: interval
    type:
      - 'null'
      - float
    doc: "Interval between checks, in seconds (default=5)"
    inputBinding:
      position: 1
      prefix: --interval
  - id: feedsready
    type:
      - 'null'
      - string
    doc: "In addition to API and set of core services being available, wait until at least one full feed sync has been completed for the CSV list of feeds (default=\"vulnerabilities\")."
    inputBinding:
      position: 1
      prefix: --feedsready
  - id: servicesready
    type:
      - 'null'
      - string
    doc: "Wait for the specified CSV list of anchore-engine services to have at least one service reporting as available (default=\"catalog,apiext,policy_engine,simplequeue,analyzer\")"
    inputBinding:
      position: 1
      prefix: --servicesready
outputs:
  - id: stdout
    type: stdout
    doc: Command output (text table, or JSON when json_output is set)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_system_wait.out
