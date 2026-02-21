cwlVersion: v1.2
class: CommandLineTool
baseCommand: dbcan
label: dbcan_test_dbcan
doc: "The provided text contains runtime error messages and logs related to a container
  environment failure (no space left on device) rather than the tool's help documentation.
  As a result, no command-line arguments could be extracted.\n\nTool homepage: http://bcb.unl.edu/dbCAN2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcan:5.2.6--pyhdfd78af_0
stdout: dbcan_test_dbcan.out
