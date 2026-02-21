cwlVersion: v1.2
class: CommandLineTool
baseCommand: pseqsid
label: pseqsid
doc: "The provided text contains container execution and build errors rather than
  the tool's help documentation. As a result, no arguments or descriptions could be
  extracted.\n\nTool homepage: https://github.com/amaurypm/pseqsid"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pseqsid:1.0.2--h4349ce8_0
stdout: pseqsid.out
