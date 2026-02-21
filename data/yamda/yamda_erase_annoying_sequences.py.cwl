cwlVersion: v1.2
class: CommandLineTool
baseCommand: yamda_erase_annoying_sequences.py
label: yamda_erase_annoying_sequences.py
doc: "The provided text does not contain help information or a description for the
  tool; it contains container engine log errors.\n\nTool homepage: https://github.com/daquang/YAMDA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yamda:0.1.00e9c9d--py_0
stdout: yamda_erase_annoying_sequences.py.out
