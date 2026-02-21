cwlVersion: v1.2
class: CommandLineTool
baseCommand: involucro
label: involucro
doc: "Involucro is a tool used for orchestrating and wrapping Docker builds, often
  used in bioinformatics containerization workflows.\n\nTool homepage: https://github.com/involucro/involucro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/involucro:1.1.2--0
stdout: involucro.out
