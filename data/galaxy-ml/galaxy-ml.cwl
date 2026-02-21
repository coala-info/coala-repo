cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-ml
label: galaxy-ml
doc: "A toolset for machine learning within the Galaxy framework. Note: The provided
  text contains system error logs regarding container execution and does not list
  specific command-line arguments.\n\nTool homepage: https://github.com/goeckslab/Galaxy-ML"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-ml:0.10.0--py39he88f293_3
stdout: galaxy-ml.out
