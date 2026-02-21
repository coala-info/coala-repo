cwlVersion: v1.2
class: CommandLineTool
baseCommand: escher
label: escher
doc: "The provided text does not contain help information or a description of the
  tool. It contains system error messages related to a container runtime failure.\n
  \nTool homepage: https://escher.github.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/escher:1.7.3--py_0
stdout: escher.out
