cwlVersion: v1.2
class: CommandLineTool
baseCommand: gangstr
label: gangstr
doc: "The provided text does not contain help information or a description of the
  tool. It contains system log messages and a fatal error regarding container image
  building.\n\nTool homepage: https://github.com/gymreklab/GangSTR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gangstr:2.5.0--h7337834_10
stdout: gangstr.out
