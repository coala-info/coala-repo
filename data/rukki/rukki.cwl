cwlVersion: v1.2
class: CommandLineTool
baseCommand: rukki
label: rukki
doc: "The provided text appears to be a container execution error log rather than
  CLI help text. No usage information or arguments could be extracted from the input.\n
  \nTool homepage: https://github.com/marbl/rukki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rukki:0.3.0--ha6fb395_1
stdout: rukki.out
