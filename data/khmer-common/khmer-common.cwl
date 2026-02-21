cwlVersion: v1.2
class: CommandLineTool
baseCommand: khmer-common
label: khmer-common
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error indicating a failure to build the container
  image due to lack of disk space.\n\nTool homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/khmer-common:v2.1.2dfsg-6-deb_cv1
stdout: khmer-common.out
