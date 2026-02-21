cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyporegui
label: pypore_pyporegui
doc: "A graphical user interface for pypore, a Python package for analyzing nanopore
  data. (Note: The provided text contains system logs and error messages rather than
  command-line help documentation.)\n\nTool homepage: http://parkin.github.io/pypore/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypore:0.0.6.dev20161116235131--py27h24bf2e0_1
stdout: pypore_pyporegui.out
