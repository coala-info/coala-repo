cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycoverm
label: pycoverm
doc: "The provided text does not contain help information or usage instructions for
  pycoverm; it is a log of a container build failure.\n\nTool homepage: https://github.com/apcamargo/pycoverm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycoverm:0.6.2--py39h52a3210_0
stdout: pycoverm.out
