cwlVersion: v1.2
class: CommandLineTool
baseCommand: lassaseq
label: lassaseq
doc: "Lassa virus sequencing analysis tool. (Note: The provided help text contains
  only container execution errors and does not list specific command-line arguments.)\n
  \nTool homepage: https://github.com/DaanJansen94/LassaSeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lassaseq:0.1.2--pyhdfd78af_0
stdout: lassaseq.out
