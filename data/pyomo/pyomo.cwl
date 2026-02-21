cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyomo
label: pyomo
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error message regarding a container build
  failure.\n\nTool homepage: https://github.com/Pyomo/pyomo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyomo:4.1.10527--py34_0
stdout: pyomo.out
