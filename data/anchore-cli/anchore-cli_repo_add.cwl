cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - repo
  - add
label: anchore-cli_repo_add
doc: "Add a repository\n\nThis command talks to a running Anchore Engine server; give its URL, user and password.\n\nTool homepage: https://github.com/anchore/anchore-cli"
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
  - id: noautosubscribe
    type:
      - 'null'
      - boolean
    doc: "If set, instruct the engine to disable subscriptions for any discovered tags."
    inputBinding:
      position: 1
      prefix: --noautosubscribe
  - id: lookuptag
    type:
      - 'null'
      - string
    doc: "Specify a tag to use for repo tag scan if 'latest' tag does not exist in the repo."
    inputBinding:
      position: 1
      prefix: --lookuptag
  - id: input_repo
    type: string
    doc: "Input repository: registry/repo"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Command output (text table, or JSON when json_output is set)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_repo_add.out
