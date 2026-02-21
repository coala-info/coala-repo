cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis
label: mantis
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error logs indicating a failure to build the
  SIF image due to lack of disk space.\n\nTool homepage: https://github.com/splatlab/mantis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
stdout: mantis.out
