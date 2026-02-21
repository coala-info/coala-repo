cwlVersion: v1.2
class: CommandLineTool
baseCommand: vibrant_VIBRANT_setup.py
label: vibrant_VIBRANT_setup.py
doc: "Setup script for VIBRANT (Virus Identification By iteRative ANnoTation). Note:
  The provided text appears to be a system log/error message rather than help text,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/AnantharamanLab/VIBRANT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vibrant:1.2.1--hdfd78af_4
stdout: vibrant_VIBRANT_setup.py.out
