cwlVersion: v1.2
class: CommandLineTool
baseCommand: bracken
label: bracken
doc: "The provided text contains system error messages regarding a failed container
  execution and does not contain help text or usage information for the tool.\n\n\
  Tool homepage: https://github.com/jenniferlu717/Bracken"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bracken:3.1--h9948957_0
stdout: bracken.out
