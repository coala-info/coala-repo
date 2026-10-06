cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - evaluate
  - check
label: anchore-cli_evaluate_check
doc: "Check latest policy evaluation for an image\n\nThis command talks to a running Anchore Engine server; give its URL, user and password.\n\nTool homepage: https://github.com/anchore/anchore-cli"
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
  - id: show_history
    type:
      - 'null'
      - boolean
    doc: "Show all previous policy evaluations"
    inputBinding:
      position: 1
      prefix: --show-history
  - id: detail
    type:
      - 'null'
      - boolean
    doc: "Show detailed policy evaluation report"
    inputBinding:
      position: 1
      prefix: --detail
  - id: tag
    type:
      - 'null'
      - string
    doc: "Specify which TAG is evaluated for a given image ID or Image Digest"
    inputBinding:
      position: 1
      prefix: --tag
  - id: policy
    type:
      - 'null'
      - string
    doc: "Specify which POLICY to use for evaluate (defaults currently active policy)"
    inputBinding:
      position: 1
      prefix: --policy
  - id: input_image
    type: string
    doc: "Input image: image digest, image ID or registry/repo:tag"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Command output (text table, or JSON when json_output is set)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_evaluate_check.out
