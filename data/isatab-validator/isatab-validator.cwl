cwlVersion: v1.2
class: CommandLineTool
baseCommand: isatab-validator
label: isatab-validator
doc: "A tool for validating ISA-Tab files.\n\nTool homepage: https://github.com/ISA-tools/ISAValidatorWS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isatab-validator:phenomenal-v0.10.0_cv0.7.1.42
stdout: isatab-validator.out
