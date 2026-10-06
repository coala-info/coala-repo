cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - analysis-archive
  - rules
  - add
label: anchore-cli_analysis-archive_rules_add
doc: "Add a new transition rule\n\nThis command talks to a running Anchore Engine server; give its URL, user and password.\n\nTool homepage: https://github.com/anchore/anchore-cli"
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
  - id: days_old
    type: int
    doc: "The minimum age of the image analysis or archive records to select"
    inputBinding:
      position: 2
  - id: tag_versions_newer
    type: int
    doc: "The number of newer mappings of a tag to a digest that must exist for the tag to be selected by the rule"
    inputBinding:
      position: 3
  - id: transition
    type: string
    doc: "The transition to execute: archive or delete"
    inputBinding:
      position: 4
  - id: registry_selector
    type:
      - 'null'
      - string
    doc: "Registry to filter on, wildcard supported"
    inputBinding:
      position: 1
      prefix: --registry-selector
  - id: repository_selector
    type:
      - 'null'
      - string
    doc: "Repository to filter on, wildcard supported"
    inputBinding:
      position: 1
      prefix: --repository-selector
  - id: tag_selector
    type:
      - 'null'
      - string
    doc: "Tag to filter on, wildcard supported"
    inputBinding:
      position: 1
      prefix: --tag-selector
  - id: is_global
    type:
      - 'null'
      - boolean
    doc: "If true, make this a global rule (admin only)"
    inputBinding:
      position: 1
      prefix: --is-global
outputs:
  - id: stdout
    type: stdout
    doc: Command output (text table, or JSON when json_output is set)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_analysis-archive_rules_add.out
