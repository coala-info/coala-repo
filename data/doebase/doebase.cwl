cwlVersion: v1.2
class: CommandLineTool
baseCommand: doebase
label: doebase
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image conversion and disk
  space.\n\nTool homepage: https://github.com/pablocarb/doebase"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/doebase:v2.0.2
stdout: doebase.out
