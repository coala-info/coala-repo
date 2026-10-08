cwlVersion: v1.2
class: CommandLineTool
baseCommand: [varfish-cli]
label: varfish-cli_cases_case-list
doc: "List all Case entries for the project.\n\nTool homepage: https://github.com/bihealth/varfish-cli"
inputs:
  - id: server_url
    type: string
    doc: VarFish server URL (passed to the tool in the environment variable VARFISH_SERVER_URL; the --varfish-server-url option is not used because the tool binds it to the API token as well)
  - id: api_token
    type: string
    doc: VarFish API token (passed to the tool in the environment variable VARFISH_API_TOKEN)
  - id: config_path
    type: ['null', File]
    doc: "Path to configuration file"
    inputBinding:
      position: 2
      prefix: --config-path
  - id: verbose
    type: ['null', boolean]
    doc: Enable verbose output
    inputBinding:
      position: 3
      prefix: -v
  - id: verify_ssl
    type: ['null', boolean]
    doc: Verify SSL certificates (default)
    inputBinding:
      position: 4
      prefix: --verify-ssl
  - id: no_verify_ssl
    type: ['null', boolean]
    doc: Disable SSL verification
    inputBinding:
      position: 5
      prefix: --no-verify-ssl
  - id: project_uuid
    type: string
    doc: "UUID of project to list cases for"
    inputBinding:
      position: 20
  - id: output_file
    type: ['null', string]
    doc: "Path to file to write to (default -, standard output)"
    inputBinding:
      position: 26
      prefix: --output-file
  - id: output_format
    type: ['null', string]
    doc: "Output format: table, csv or json (default table)"
    inputBinding:
      position: 26
      prefix: --output-format
  - id: output_delimiter
    type: ['null', string]
    doc: "Delimiter for CSV output (default ,)"
    inputBinding:
      position: 26
      prefix: --output-delimiter
  - id: output_fields
    type: ['null', string]
    doc: "Output fields"
    inputBinding:
      position: 26
      prefix: --output-fields
outputs:
  - id: out_file
    type: ['null', File]
    doc: Result file written with --output-file
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 10
    valueFrom: cases
  - position: 11
    valueFrom: case-list
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: VARFISH_SERVER_URL
        envValue: $(inputs.server_url)
      - envName: VARFISH_API_TOKEN
        envValue: $(inputs.api_token)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
stdout: varfish-cli_cases_case-list.out
