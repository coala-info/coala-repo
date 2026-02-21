cwlVersion: v1.2
class: CommandLineTool
baseCommand: tesorter
label: tesorter
doc: "A tool for classifying transposable elements (TEs) based on their protein domains.\n
  \nTool homepage: https://github.com/NBISweden/TEsorter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tesorter:1.5.1--pyhdfd78af_0
stdout: tesorter.out
