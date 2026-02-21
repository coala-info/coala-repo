cwlVersion: v1.2
class: CommandLineTool
baseCommand: ginpiper
label: ginpiper
doc: "The provided text does not contain help information for ginpiper; it contains
  system log messages and a fatal error regarding container image conversion and disk
  space.\n\nTool homepage: https://github.com/KleistLab/ginpiper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ginpiper:1.0.0--r44hdfd78af_3
stdout: ginpiper.out
