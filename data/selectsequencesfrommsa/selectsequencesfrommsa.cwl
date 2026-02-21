cwlVersion: v1.2
class: CommandLineTool
baseCommand: selectsequencesfrommsa
label: selectsequencesfrommsa
doc: "The provided text is an error log indicating a failure to build or run the container
  (no space left on device) and does not contain the help text or usage information
  for the tool.\n\nTool homepage: https://github.com/eggzilla/SelectSequencesFromMSA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/selectsequencesfrommsa:1.0.5--pl526h9ebf644_0
stdout: selectsequencesfrommsa.out
