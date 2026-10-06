cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - registry
  - update
label: anchore-cli_registry_update
doc: "Update an existing registry\n\nThis command talks to a running Anchore Engine server; give its URL, user and password.\n\nTool homepage: https://github.com/anchore/anchore-cli"
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
  - id: registry
    type: string
    doc: "Full hostname/port of registry, e.g. myrepo.example.com:5000"
    inputBinding:
      position: 2
  - id: registry_user
    type: string
    doc: "Registry user name"
    inputBinding:
      position: 3
  - id: registry_pass
    type: string
    doc: "Registry password"
    inputBinding:
      position: 4
  - id: insecure
    type:
      - 'null'
      - boolean
    doc: "Allow connection to registry without SSL cert checks (ex: if registry uses a self-signed SSL certificate)"
    inputBinding:
      position: 1
      prefix: --insecure
  - id: registry_type
    type:
      - 'null'
      - string
    doc: "Specify the registry type (default='docker_v2')"
    inputBinding:
      position: 1
      prefix: --registry-type
  - id: skip_validate
    type:
      - 'null'
      - boolean
    doc: "Do not attempt to validate registry/creds on registry add"
    inputBinding:
      position: 1
      prefix: --skip-validate
outputs:
  - id: stdout
    type: stdout
    doc: Command output (text table, or JSON when json_output is set)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_registry_update.out
