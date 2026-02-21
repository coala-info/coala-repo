cwlVersion: v1.2
class: CommandLineTool
baseCommand: kubectl
label: google-cloud-sdk_kubectl
doc: "Kubernetes command-line tool (Note: The provided text is a system error log
  and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://cloud.google.com/sdk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
stdout: google-cloud-sdk_kubectl.out
