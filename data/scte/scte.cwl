cwlVersion: v1.2
class: CommandLineTool
baseCommand: scte
label: scte
doc: "Single-cell Transposable Element (scTE) analysis tool\n\nTool homepage: https://github.com/JiekaiLab/scTE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scte:1.0.0--pyhdfd78af_0
stdout: scte.out
