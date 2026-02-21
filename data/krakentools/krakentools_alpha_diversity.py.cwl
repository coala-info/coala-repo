cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakentools_alpha_diversity.py
label: krakentools_alpha_diversity.py
doc: "A script from KrakenTools to calculate alpha diversity. (Note: The provided
  input text contains container execution error logs rather than the tool's help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/jenniferlu717/KrakenTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
stdout: krakentools_alpha_diversity.py.out
