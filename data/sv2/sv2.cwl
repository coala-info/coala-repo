cwlVersion: v1.2
class: CommandLineTool
baseCommand: sv2
label: sv2
doc: "Structural Variant Support Vector Machine Classifier (Note: The provided text
  contains container build logs rather than tool help text; no arguments could be
  extracted).\n\nTool homepage: https://github.com/dantaki/SV2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sv2:1.4.3.4--py27h3010b51_2
stdout: sv2.out
