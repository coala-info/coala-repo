cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - policy
  - describe
label: anchore-cli_policy_describe
doc: "Describes the policy gates and triggers available\n\nThis command talks to a running Anchore Engine server; give its URL, user and password.\n\nTool homepage: https://github.com/anchore/anchore-cli"
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
  - id: all
    type:
      - 'null'
      - boolean
    doc: "Display deprecated and end-of-lifed entries, which are filtered out by default"
    inputBinding:
      position: 1
      prefix: --all
  - id: gate
    type:
      - 'null'
      - string
    doc: "Pick a specific gate to describe instead of all"
    inputBinding:
      position: 1
      prefix: --gate
  - id: trigger
    type:
      - 'null'
      - string
    doc: "Pick a specific trigger to describe instead of all, requires the --gate option to be specified"
    inputBinding:
      position: 1
      prefix: --trigger
outputs:
  - id: stdout
    type: stdout
    doc: Command output (text table, or JSON when json_output is set)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_policy_describe.out
