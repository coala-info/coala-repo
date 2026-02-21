cwlVersion: v1.2
class: CommandLineTool
baseCommand: fetch_helixer_models.py
label: helixer-docker_fetch_helixer_models.py
doc: "A script to fetch or download Helixer models. (Note: The provided text contains
  error logs rather than help documentation, so no arguments could be extracted.)\n
  \nTool homepage: https://github.com/gglyptodon/helixer-docker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/helixer-docker:helixer_v0.3.2_cuda_11.8.0-cudnn8
stdout: helixer-docker_fetch_helixer_models.py.out
