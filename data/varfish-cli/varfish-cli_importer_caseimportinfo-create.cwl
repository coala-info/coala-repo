cwlVersion: v1.2
class: CommandLineTool
baseCommand: [varfish-cli]
label: varfish-cli_importer_caseimportinfo-create
doc: "Create case import info and upload the files.\n\nTool homepage: https://github.com/bihealth/varfish-cli"
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
    doc: "UUID of project to import the case into"
    inputBinding:
      position: 20
  - id: paths
    type: File[]
    doc: Path(s) to files to use for the import. Must include PED, and annotation TSV files
    inputBinding:
      position: 31
  - id: strip_family_regex
    type: ['null', string]
    doc: "Regular expression to process family name with (default ^FAM_)"
    inputBinding:
      position: 25
      prefix: --strip-family-regex
  - id: case_name_suffix
    type: ['null', string]
    doc: "Suffix to append to case name"
    inputBinding:
      position: 25
      prefix: --case-name-suffix
  - id: force_fresh
    type: ['null', boolean]
    doc: Force using fresh case import even if old draft found
    inputBinding:
      position: 25
      prefix: --force-fresh
  - id: no_force_fresh
    type: ['null', boolean]
    doc: Do not force a fresh case import (default)
    inputBinding:
      position: 25
      prefix: --no-force-fresh
  - id: resubmit
    type: ['null', boolean]
    doc: Force resubmission of cases in submit state
    inputBinding:
      position: 25
      prefix: --resubmit
  - id: no_resubmit
    type: ['null', boolean]
    doc: Do not resubmit cases in submit state (default)
    inputBinding:
      position: 25
      prefix: --no-resubmit
  - id: genomebuild
    type: ['null', string]
    doc: "The genome build of this case: GRCh37 or GRCh38 (default GRCh37)"
    inputBinding:
      position: 25
      prefix: --genomebuild
  - id: index
    type: ['null', string]
    doc: "Name of the index case in the pedigree, defaults to the first affected member of the pedigree file"
    inputBinding:
      position: 25
      prefix: --index
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 10
    valueFrom: importer
  - position: 11
    valueFrom: caseimportinfo-create
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
stdout: varfish-cli_importer_caseimportinfo-create.out
