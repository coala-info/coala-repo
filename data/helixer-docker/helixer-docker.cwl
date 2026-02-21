cwlVersion: v1.2
class: CommandLineTool
baseCommand: helixer-docker
label: helixer-docker
doc: "Helixer is a tool for gene prediction. (Note: The provided help text contains
  only system error logs and does not list specific command-line arguments.)\n\nTool
  homepage: https://github.com/gglyptodon/helixer-docker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/helixer-docker:helixer_v0.3.2_cuda_11.8.0-cudnn8
stdout: helixer-docker.out
