cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyhalcyon
label: pyhalcyon
doc: "The provided text does not contain help information or usage instructions for
  pyhalcyon. It contains system logs and error messages related to a container build
  process.\n\nTool homepage: https://pypi.org/project/pyhalcyon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyhalcyon:0.1.1--py_0
stdout: pyhalcyon.out
