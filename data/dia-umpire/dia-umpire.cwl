cwlVersion: v1.2
class: CommandLineTool
baseCommand: dia-umpire
label: dia-umpire
doc: "DIA-Umpire is a computational workflow for processing DIA (Data-Independent
  Acquisition) mass spectrometry data. (Note: The provided text contains container
  runtime error messages rather than CLI help documentation, so no arguments could
  be extracted).\n\nTool homepage: https://github.com/cctsou/DIA-Umpire"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dia-umpire:v2.1.2_cv4
stdout: dia-umpire.out
