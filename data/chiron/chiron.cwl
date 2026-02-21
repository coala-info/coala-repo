cwlVersion: v1.2
class: CommandLineTool
baseCommand: chiron
label: chiron
doc: "Chiron is a nanopore basecaller that uses a deep neural network to translate
  raw signal into DNA sequences.\n\nTool homepage: https://github.com/haotianteng/chiron"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chiron:0.6.1.1--py_0
stdout: chiron.out
