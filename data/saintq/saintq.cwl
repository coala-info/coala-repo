cwlVersion: v1.2
class: CommandLineTool
baseCommand: saintq
label: saintq
doc: "SAINTq is a tool for scoring protein-protein interactions in affinity purification-mass
  spectrometry (AP-MS) data.\n\nTool homepage: https://github.com/Lionel107/SaintQuiz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/saintq:v0.0.2_cv3
stdout: saintq.out
