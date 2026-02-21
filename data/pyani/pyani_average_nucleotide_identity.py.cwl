cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyani_average_nucleotide_identity.py
label: pyani_average_nucleotide_identity.py
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process.\n\nTool homepage: https://github.com/widdowquinn/pyani"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani:0.2.13.1--pyhdc42f0e_0
stdout: pyani_average_nucleotide_identity.py.out
