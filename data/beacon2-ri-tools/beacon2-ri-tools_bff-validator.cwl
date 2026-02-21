cwlVersion: v1.2
class: CommandLineTool
baseCommand: bff-validator
label: beacon2-ri-tools_bff-validator
doc: "A tool for validating Beacon Framework Format (BFF) files. Note: The provided
  help text contains only system error messages regarding a container build failure
  and does not list specific command-line arguments.\n\nTool homepage: https://github.com/EGA-archive/beacon2-ri-tools/tree/main"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beacon2-ri-tools:2.0.5--py310hdfd78af_0
stdout: beacon2-ri-tools_bff-validator.out
