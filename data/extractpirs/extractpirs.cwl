cwlVersion: v1.2
class: CommandLineTool
baseCommand: extractpirs
label: extractpirs
doc: 'A tool for extracting PIRs (Profile Inferences of Relationship). Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extractpirs:1.0--0
stdout: extractpirs.out
