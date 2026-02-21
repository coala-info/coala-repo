cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioservices
label: bioservices
doc: "The provided text does not contain help information. It is an error log indicating
  that the 'bioservices' executable was not found in the system PATH.\n\nTool homepage:
  http://pypi.python.org/pypi/bioservices"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioservices:1.7.11--pyh3252c3a_0
stdout: bioservices.out
