cwlVersion: v1.2
class: CommandLineTool
baseCommand: google-cloud-sdk
label: google-cloud-sdk
doc: "Google Cloud SDK (Note: The provided text is an error log and does not contain
  help documentation or argument definitions).\n\nTool homepage: https://cloud.google.com/sdk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
stdout: google-cloud-sdk.out
