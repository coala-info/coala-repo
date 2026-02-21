cwlVersion: v1.2
class: CommandLineTool
baseCommand: pauda
label: pauda
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating that the executable was not found.\n\nTool homepage:
  https://github.com/alfanshter/PaudAssabyan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pauda:1.0.1--1
stdout: pauda.out
