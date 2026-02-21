cwlVersion: v1.2
class: CommandLineTool
baseCommand: legsta
label: legsta
doc: "Legionella pneumophila Sequence Typing from Assemblies\n\nTool homepage: https://github.com/tseemann/legsta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/legsta:0.5.2--hdfd78af_0
stdout: legsta.out
