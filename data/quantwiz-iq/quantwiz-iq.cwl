cwlVersion: v1.2
class: CommandLineTool
baseCommand: quantwiz-iq
label: quantwiz-iq
doc: "QuantWiz-IQ (Note: The provided text contains container build logs rather than
  tool help text; no arguments could be extracted).\n\nTool homepage: https://sourceforge.net/projects/quantwiz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quantwiz-iq:2.0--0
stdout: quantwiz-iq.out
