cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - query
  - images-by-package
label: anchore-cli_query_images-by-package
doc: "Search system for images with the given package installed\n\nThis command talks to a running Anchore Engine server; give its URL, user and password.\n\nTool homepage: https://github.com/anchore/anchore-cli"
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
  - id: name
    type: string
    doc: "Search for images with this package name (e.g. sed)"
    inputBinding:
      position: 1
      prefix: --name
  - id: package_version
    type:
      - 'null'
      - string
    doc: "Filter results to only packages with given version (e.g. 4.4-1)"
    inputBinding:
      position: 1
      prefix: --version
  - id: package_type
    type:
      - 'null'
      - string
    doc: "Filter results to only packages of given type (e.g. dpkg)"
    inputBinding:
      position: 1
      prefix: --package-type
outputs:
  - id: stdout
    type: stdout
    doc: Command output (text table, or JSON when json_output is set)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_query_images-by-package.out
