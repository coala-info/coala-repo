cwlVersion: v1.2
class: CommandLineTool
baseCommand: tedna
label: tedna
doc: "tedna (Transposable Element De Novo Assembler) is a tool for the de novo assembly
  of transposable elements from genomic reads.\n\nTool homepage: https://github.com/mzytnicki/tedna"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tedna:1.3.1--h503566f_0
stdout: tedna.out
