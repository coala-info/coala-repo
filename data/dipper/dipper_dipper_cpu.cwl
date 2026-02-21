cwlVersion: v1.2
class: CommandLineTool
baseCommand: dipper
label: dipper_dipper_cpu
doc: "A tool for data ingestion and processing (Note: The provided text contains container
  runtime error messages rather than tool help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/TurakhiaLab/DIPPER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dipper:0.1.3--h6bb9b41_0
stdout: dipper_dipper_cpu.out
