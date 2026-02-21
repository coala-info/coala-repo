cwlVersion: v1.2
class: CommandLineTool
baseCommand: gloome
label: gloome
doc: "GLOOME (Gain Loss Mapping Engine) - a tool for analyzing the evolution of presence-absence
  profiles.\n\nTool homepage: https://gloome.tau.ac.il/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gloome:VR01.266--h4ac6f70_3
stdout: gloome.out
