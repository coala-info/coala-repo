cwlVersion: v1.2
class: CommandLineTool
baseCommand: decoypyrat
label: decoypyrat
doc: "A tool for generating decoy protein sequences for proteomics search engine validation.
  (Note: The provided help text contains system error messages and does not list specific
  command-line arguments).\n\nTool homepage: https://github.com/tdido/DecoyPYrat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/decoypyrat:1.0.1--py_0
stdout: decoypyrat.out
