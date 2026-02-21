cwlVersion: v1.2
class: CommandLineTool
baseCommand: kreport2mpa.py
label: krakentools_kreport2mpa.py
doc: "A tool from KrakenTools to convert Kraken report files to MPA (Metagenomics
  Phylogenetic Analysis) format. (Note: The provided help text contains a system error
  and does not list arguments.)\n\nTool homepage: https://github.com/jenniferlu717/KrakenTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
stdout: krakentools_kreport2mpa.py.out
