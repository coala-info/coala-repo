cwlVersion: v1.2
class: CommandLineTool
baseCommand: interval-binning
label: interval-binning
doc: "The provided text does not contain help information or usage instructions; it
  contains system log messages and a fatal error regarding container image building.\n
  \nTool homepage: https://github.com/martijnvermaat/binning"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/interval-binning:1.0.0--pyh5e36f6f_0
stdout: interval-binning.out
