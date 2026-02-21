cwlVersion: v1.2
class: CommandLineTool
baseCommand: cloudspades_spades.py
label: cloudspades_spades.py
doc: "CloudSPAdes is a tool for distributed assembly of genomic data. (Note: The provided
  text contains only system error logs and no help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/ablab/spades"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cloudspades:3.16.0--haf24da9_3
stdout: cloudspades_spades.py.out
