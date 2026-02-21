cwlVersion: v1.2
class: CommandLineTool
baseCommand: springsuite
label: springsuite
doc: "The provided text contains system logs and error messages related to container
  image retrieval and does not contain the help text or usage information for the
  'springsuite' tool. As a result, no arguments could be extracted.\n\nTool homepage:
  https://github.com/guerler/springsuite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/springsuite:0.2--pyh5e36f6f_1
stdout: springsuite.out
