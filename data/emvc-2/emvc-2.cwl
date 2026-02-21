cwlVersion: v1.2
class: CommandLineTool
baseCommand: emvc-2
label: emvc-2
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image conversion and disk
  space.\n\nTool homepage: https://github.com/guilledufort/EMVC-2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emvc-2:1.0--h031d066_0
stdout: emvc-2.out
