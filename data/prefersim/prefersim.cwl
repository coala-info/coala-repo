cwlVersion: v1.2
class: CommandLineTool
baseCommand: prefersim
label: prefersim
doc: "A forward-time population genetic simulation program (Note: The provided text
  contains container build errors rather than tool help documentation).\n\nTool homepage:
  https://github.com/LohmuellerLab/PReFerSim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prefersim:1.0--h940b034_4
stdout: prefersim.out
