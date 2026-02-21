cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaclassifier
label: metaclassifier
doc: "A tool for meta-classification (Note: The provided text contains system error
  messages rather than tool help documentation).\n\nTool homepage: https://github.com/ewafula/MetaClassifier"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaclassifier:v1.0.1--py_0
stdout: metaclassifier.out
