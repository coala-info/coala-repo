cwlVersion: v1.2
class: CommandLineTool
baseCommand: consensusfixer
label: consensusfixer
doc: "ConsensusFixer is a tool designed to correct errors in consensus sequences.
  (Note: The provided help text contains only system logs and an execution error;
  no specific usage or arguments were found in the input text.)\n\nTool homepage:
  https://github.com/cbg-ethz/ConsensusFixer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consensusfixer:0.4--2
stdout: consensusfixer.out
