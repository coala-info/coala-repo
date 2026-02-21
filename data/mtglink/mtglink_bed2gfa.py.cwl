cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtglink_bed2gfa.py
label: mtglink_bed2gfa.py
doc: "A tool to convert BED files to GFA format (Note: The provided help text contains
  system error messages and does not list specific arguments).\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
stdout: mtglink_bed2gfa.py.out
