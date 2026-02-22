cwlVersion: v1.2
class: CommandLineTool
baseCommand: biothings_client
label: biothings_client
doc: "Python client for BioThings API services (Note: The provided text contains system
  error logs rather than help documentation, so no arguments could be extracted).\n\
  \nTool homepage: https://github.com/biothings/biothings_client.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biothings_client:0.2.6--pyh7cba7a3_1
stdout: biothings_client.out
