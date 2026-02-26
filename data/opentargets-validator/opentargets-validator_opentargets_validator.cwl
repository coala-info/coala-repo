cwlVersion: v1.2
class: CommandLineTool
baseCommand: opentargets_validator
label: opentargets-validator_opentargets_validator
doc: "Open Targets evidence string validator, version 1.0.0.\n\nTool homepage: https://github.com/opentargets/validator"
inputs:
  - id: data
    type:
      - 'null'
      - File
    doc: Data file to validate. If not specified, STDIN is the default.
    inputBinding:
      position: 1
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Log level. Default: INFO'
    default: INFO
    inputBinding:
      position: 102
      prefix: --log-level
  - id: schema
    type: File
    doc: Schema file to validate against. Mandatory.
    inputBinding:
      position: 102
      prefix: --schema
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show program's version number and exit
    inputBinding:
      position: 102
      prefix: -V
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/opentargets-validator:1.0.0--pyhdfd78af_0
stdout: opentargets-validator_opentargets_validator.out
