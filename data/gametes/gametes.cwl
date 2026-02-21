cwlVersion: v1.2
class: CommandLineTool
baseCommand: gametes
label: gametes
doc: "Genetic Architecture Model Emulator for Testing and Evaluation Software (Note:
  The provided text contains container runtime error messages rather than tool help
  text, so no arguments could be extracted).\n\nTool homepage: https://sourceforge.net/projects/gametes/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gametes:2.1--py312h7e72e81_1
stdout: gametes.out
