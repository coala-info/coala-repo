cwlVersion: v1.2
class: CommandLineTool
baseCommand: dbcan
label: dbcan
doc: "The provided text contains system error messages and logs related to a container
  environment failure rather than the tool's help documentation. No usage information
  or arguments could be extracted.\n\nTool homepage: http://bcb.unl.edu/dbCAN2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcan:5.2.6--pyhdfd78af_0
stdout: dbcan.out
