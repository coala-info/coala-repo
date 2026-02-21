cwlVersion: v1.2
class: CommandLineTool
baseCommand: Helixer.py
label: helixer-docker_Helixer.py
doc: "Helixer is a tool for gene prediction. (Note: The provided text appears to be
  a system error log regarding a container build failure and does not contain usage
  instructions or argument definitions).\n\nTool homepage: https://github.com/gglyptodon/helixer-docker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/helixer-docker:helixer_v0.3.2_cuda_11.8.0-cudnn8
stdout: helixer-docker_Helixer.py.out
