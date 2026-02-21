cwlVersion: v1.2
class: CommandLineTool
baseCommand: womtool
label: cromwell_womtool
doc: "The provided text does not contain help information or documentation for the
  tool; it is a system log showing a container build failure due to insufficient disk
  space.\n\nTool homepage: https://github.com/broadinstitute/cromwell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromwell:0.40--1
stdout: cromwell_womtool.out
