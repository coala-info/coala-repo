cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyngost_pyngoST.py
label: pyngost_pyngoST.py
doc: "The provided text does not contain help information or usage instructions for
  pyngost_pyngoST.py; it is a log of a failed container build process.\n\nTool homepage:
  https://github.com/leosanbu/pyngoST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyngost:1.1.3--pyh7e72e81_0
stdout: pyngost_pyngoST.py.out
