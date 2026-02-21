cwlVersion: v1.2
class: CommandLineTool
baseCommand: biogridpy
label: biogridpy
doc: "The provided text does not contain help information for biogridpy; it is an
  error log indicating the executable was not found.\n\nTool homepage: https://github.com/arvkevi/biogridpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biogridpy:0.1.1--py35_1
stdout: biogridpy.out
