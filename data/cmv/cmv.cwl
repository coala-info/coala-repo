cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmv
label: cmv
doc: "The provided text does not contain help information for the tool 'cmv'; it is
  a container runtime error log indicating a failure to build the SIF image due to
  lack of disk space.\n\nTool homepage: https://github.com/eggzilla/cmv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmv:1.0.8--1
stdout: cmv.out
