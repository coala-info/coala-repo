cwlVersion: v1.2
class: CommandLineTool
baseCommand: carnac
label: carna_carnac
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or extract a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/Code52/carnac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carna:1.3.3--1
stdout: carna_carnac.out
