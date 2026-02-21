cwlVersion: v1.2
class: CommandLineTool
baseCommand: barrnap-python
label: barrnap-python
doc: "BAsic Rapid Ribosomal RNA Predictor (Python wrapper/version)\n\nTool homepage:
  https://github.com/nickp60/barrnap-python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barrnap-python:0.0.5--py36_0
stdout: barrnap-python.out
