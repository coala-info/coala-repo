cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcloud
label: google-cloud-sdk_gcloud
doc: "Google Cloud CLI\n\nTool homepage: https://cloud.google.com/sdk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
stdout: google-cloud-sdk_gcloud.out
