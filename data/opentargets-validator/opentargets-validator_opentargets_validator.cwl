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
    inputBinding:
      position: 102
      prefix: --log-level
  - id: schema
    type: File
    doc: Schema file to validate against. Mandatory.
    inputBinding:
      position: 102
      prefix: --schema
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: validation_log
    type: stderr
    doc: Validation log (the tool logs to standard error)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/opentargets-validator:1.0.0--pyhdfd78af_0
stdout: opentargets-validator_opentargets_validator.out
stderr: opentargets-validator_opentargets_validator.err
successCodes:
  - 0
  - 1
