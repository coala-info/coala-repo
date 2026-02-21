cwlVersion: v1.2
class: CommandLineTool
baseCommand: google-api-python-client
label: google-api-python-client
doc: "The Google API Client Library for Python is designed for Python developers.
  It offers simple, flexible, and powerful access to many Google APIs.\n\nTool homepage:
  https://github.com/googleapis/google-api-python-client"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/google-api-python-client:1.4.2--py27_0
stdout: google-api-python-client.out
