cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyprophet
label: pyprophet
doc: "The provided text does not contain help information for pyprophet; it is a log
  of a failed container build/fetch process.\n\nTool homepage: https://github.com/PyProphet/pyprophet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyprophet:3.0.5--py311haab0aaa_0
stdout: pyprophet.out
