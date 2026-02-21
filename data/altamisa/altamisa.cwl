cwlVersion: v1.2
class: CommandLineTool
baseCommand: altamisa
label: altamisa
doc: "Altamisa is a Python library and command-line tool for parsing, validating,
  and manipulating ISA-tab (Investigation/Study/Assay) files.\n\nTool homepage: https://github.com/bihealth/altamisa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/altamisa:0.3.1--pyhdfd78af_0
stdout: altamisa.out
