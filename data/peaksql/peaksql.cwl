cwlVersion: v1.2
class: CommandLineTool
baseCommand: peaksql
label: peaksql
doc: "The provided text does not contain help information or a description of the
  tool, as it appears to be an error log from a container execution environment indicating
  that the executable was not found.\n\nTool homepage: https://vanheeringen-lab.github.io/peaksql/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peaksql:0.0.4--py_0
stdout: peaksql.out
