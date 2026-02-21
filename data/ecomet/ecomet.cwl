cwlVersion: v1.2
class: CommandLineTool
baseCommand: ecomet
label: ecomet
doc: "ecomet tool (Note: The provided text contains container runtime error logs rather
  than help documentation, so no arguments could be extracted.)\n\nTool homepage:
  https://github.com/mamin27/ecomet_i2c_raspberry_tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ecomet:phenomenal-v1.1_cv0.3.39
stdout: ecomet.out
