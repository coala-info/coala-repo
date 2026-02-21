cwlVersion: v1.2
class: CommandLineTool
baseCommand: opentargets-validator
label: opentargets-validator
doc: "A tool for validating Open Targets data. Note: The provided text appears to
  be an error log rather than help text, so no arguments could be extracted.\n\nTool
  homepage: https://github.com/opentargets/validator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/opentargets-validator:1.0.0--pyhdfd78af_0
stdout: opentargets-validator.out
