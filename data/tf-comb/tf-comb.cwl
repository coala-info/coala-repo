cwlVersion: v1.2
class: CommandLineTool
baseCommand: tf-comb
label: tf-comb
doc: "Transcription Factor Co-occurrence Database/Analysis tool (Note: The provided
  text was a container build error log and did not contain specific help documentation
  for the tool's arguments).\n\nTool homepage: https://tf-comb.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tf-comb:1.1--py38h24c8ff8_0
stdout: tf-comb.out
