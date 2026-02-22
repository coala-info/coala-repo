cwlVersion: v1.2
class: CommandLineTool
baseCommand: fishplotpy
label: fishplotpy
doc: "A tool for visualizing clonal evolution, typically used to create fish plots
  that represent the expansion and contraction of subclonal populations over time.\n\
  \nTool homepage: https://github.com/Sayitobar/fishplotpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fishplotpy:1.0.0--pyh7e72e81_0
stdout: fishplotpy.out
