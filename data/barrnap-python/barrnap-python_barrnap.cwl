cwlVersion: v1.2
class: CommandLineTool
baseCommand: barrnap
label: barrnap-python_barrnap
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log regarding a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/nickp60/barrnap-python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barrnap-python:0.0.5--py36_0
stdout: barrnap-python_barrnap.out
