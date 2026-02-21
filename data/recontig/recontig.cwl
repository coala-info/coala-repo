cwlVersion: v1.2
class: CommandLineTool
baseCommand: recontig
label: recontig
doc: "The provided text does not contain help information or a description of the
  tool; it contains log messages regarding a container build failure.\n\nTool homepage:
  https://github.com/blachlylab/recontig"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recontig:1.5.0--h9ee0642_0
stdout: recontig.out
