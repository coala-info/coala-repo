cwlVersion: v1.2
class: CommandLineTool
baseCommand: metametamerge_MetaMetaMerge.py
label: metametamerge_MetaMetaMerge.py
doc: "MetaMetaMerge tool (Note: The provided text contains system error messages regarding
  container execution and does not list command-line arguments).\n\nTool homepage:
  https://github.com/pirovc/metametamerge/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metametamerge:1.1--py35_1
stdout: metametamerge_MetaMetaMerge.py.out
