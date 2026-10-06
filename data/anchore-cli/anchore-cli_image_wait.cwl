cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - image
  - wait
label: anchore-cli_image_wait
doc: "Wait for an image to analyze\n\nThis command talks to a running Anchore Engine server; give its URL, user and password.\n\nTool homepage: https://github.com/anchore/anchore-cli"
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
  - id: input_image
    type: string
    doc: "Input image: image digest, image ID or registry/repo:tag"
    inputBinding:
      position: 2
  - id: timeout
    type:
      - 'null'
      - float
    doc: "Time to wait, in seconds. If < 0, wait forever, if 0, do not wait (default=-1)"
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
outputs:
  - id: stdout
    type: stdout
    doc: Command output (text table, or JSON when json_output is set)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_image_wait.out
