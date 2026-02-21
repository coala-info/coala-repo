cwlVersion: v1.2
class: CommandLineTool
baseCommand: diffexpir
label: diffexpir
doc: "Differential expression analysis tool (Note: The provided text contains system
  error messages rather than tool help documentation).\n\nTool homepage: https://github.com/r78v10a07/DiffExpIR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/diffexpir:v0.0.1_cv5
stdout: diffexpir.out
