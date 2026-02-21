cwlVersion: v1.2
class: CommandLineTool
baseCommand: svdss
label: svdss
doc: "Structural Variant Discovery from Sample-specific Strings (Note: The provided
  text is a container runtime error log and does not contain help information or argument
  definitions).\n\nTool homepage: https://github.com/Parsoa/SVDSS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdss:2.1.0--h9013031_0
stdout: svdss.out
