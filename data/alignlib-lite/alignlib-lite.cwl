cwlVersion: v1.2
class: CommandLineTool
baseCommand: alignlib-lite
label: alignlib-lite
doc: 'A library for sequence alignment (Note: The provided text contains system error
  logs rather than help documentation, so specific arguments could not be extracted).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alignlib-lite:0.3--py312h9c9b0c2_9
stdout: alignlib-lite.out
