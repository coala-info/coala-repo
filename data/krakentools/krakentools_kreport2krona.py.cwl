cwlVersion: v1.2
class: CommandLineTool
baseCommand: kreport2krona.py
label: krakentools_kreport2krona.py
doc: "A script to convert Kraken report files (kreport) into a format compatible with
  Krona tools for visualization.\n\nTool homepage: https://github.com/jenniferlu717/KrakenTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
stdout: krakentools_kreport2krona.py.out
