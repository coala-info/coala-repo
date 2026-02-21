cwlVersion: v1.2
class: CommandLineTool
baseCommand: Platypus.py
label: platypus-variant_Platypus.py
doc: "Platypus is a tool for variant detection in high-throughput sequencing data.
  (Note: The provided help text contains only system error messages regarding container
  extraction and does not list specific command-line arguments).\n\nTool homepage:
  http://www.well.ox.ac.uk/platypus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/platypus-variant:0.8.1.2--py27h4fe4a89_4
stdout: platypus-variant_Platypus.py.out
