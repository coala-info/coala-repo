cwlVersion: v1.2
class: CommandLineTool
baseCommand: savage
label: savage
doc: "Strain-aware viral genome assembly\n\nTool homepage: https://github.com/HaploConduct/HaploConduct/tree/master/savage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savage:0.4.2--py27h3e4de3e_0
stdout: savage.out
