cwlVersion: v1.2
class: CommandLineTool
baseCommand: varpubs
label: varpubs
doc: "A tool for variant publication and reporting (Note: The provided text contains
  container build logs rather than CLI help documentation, so no arguments could be
  extracted).\n\nTool homepage: https://github.com/koesterlab/varpubs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varpubs:0.5.0--pyhdfd78af_0
stdout: varpubs.out
