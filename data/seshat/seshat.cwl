cwlVersion: v1.2
class: CommandLineTool
baseCommand: seshat
label: seshat
doc: "Seshat is a tool for the annotation of TP53 variants.\n\nTool homepage: https://github.com/clintval/tp53"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
stdout: seshat.out
