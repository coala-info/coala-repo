cwlVersion: v1.2
class: CommandLineTool
baseCommand: megagta_megagta.py
label: megagta_megagta.py
doc: "Metagenomic Gene Targeted Assembler (MegaGTA). Note: The provided text contains
  container runtime error logs and does not list command-line arguments.\n\nTool homepage:
  https://github.com/HKU-BAL/MegaGTA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
stdout: megagta_megagta.py.out
