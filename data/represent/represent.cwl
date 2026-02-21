cwlVersion: v1.2
class: CommandLineTool
baseCommand: represent
label: represent
doc: "The provided text appears to be a container build log rather than CLI help text.
  No usage information or arguments could be extracted from the input.\n\nTool homepage:
  https://github.com/microsoft/fluentui"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/represent:1.5.1--py27_1
stdout: represent.out
