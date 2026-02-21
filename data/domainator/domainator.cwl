cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainator
label: domainator
doc: "The provided text does not contain help information for the tool. It consists
  of container runtime log messages and a fatal error indicating a failure to build
  the SIF image due to lack of disk space.\n\nTool homepage: https://github.com/nebiolabs/domainator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domainator:0.8.0--pyhdfd78af_0
stdout: domainator.out
