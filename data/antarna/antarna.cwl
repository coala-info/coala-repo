cwlVersion: v1.2
class: CommandLineTool
baseCommand: antarna
label: antarna
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://github.com/RobertKleinkauf/antarna"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/antarna:2.0.1.2--py27_0
stdout: antarna.out
