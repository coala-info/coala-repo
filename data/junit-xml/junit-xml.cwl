cwlVersion: v1.2
class: CommandLineTool
baseCommand: junit-xml
label: junit-xml
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image building (no space left on device).\n\nTool homepage: https://github.com/kyrus/python-junit-xml"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/junit-xml:1.8--py_0
stdout: junit-xml.out
