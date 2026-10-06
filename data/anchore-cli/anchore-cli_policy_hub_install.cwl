cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - policy
  - hub
  - install
label: anchore-cli_policy_hub_install
doc: "\n\nThis command talks to a running Anchore Engine server; give its URL, user and password.\n\nTool homepage: https://github.com/anchore/anchore-cli"
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
  - id: bundlename
    type: string
    doc: "Policy bundle name on Anchore Hub"
    inputBinding:
      position: 2
  - id: target_id
    type:
      - 'null'
      - string
    doc: "Override bundle target ID with supplied ID string"
    inputBinding:
      position: 1
      prefix: --target-id
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Install specified bundleid in place of existing policy bundle with same ID, if present"
    inputBinding:
      position: 1
      prefix: --force
outputs:
  - id: stdout
    type: stdout
    doc: Command output (text table, or JSON when json_output is set)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_policy_hub_install.out
