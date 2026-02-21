cwlVersion: v1.2
class: CommandLineTool
baseCommand: isajson-validator
label: isajson-validator
doc: "A tool for validating ISA-JSON files.\n\nTool homepage: https://github.com/phnmnl/container-isajson-validator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isajson-validator:phenomenal-v0.9.4_cv0.4.38
stdout: isajson-validator.out
