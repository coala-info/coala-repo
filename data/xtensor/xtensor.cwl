cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtensor
label: xtensor
doc: "The provided text does not contain help documentation for the tool. It appears
  to be a log of a failed container build process.\n\nTool homepage: https://github.com/xtensor-stack/xtensor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xtensor:0.19.1
stdout: xtensor.out
