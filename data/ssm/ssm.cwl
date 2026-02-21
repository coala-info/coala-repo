cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssm
label: ssm
doc: "No description available from the provided text.\n\nTool homepage: https://www.ccp4.ac.uk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssm:1.4--h503566f_1
stdout: ssm.out
