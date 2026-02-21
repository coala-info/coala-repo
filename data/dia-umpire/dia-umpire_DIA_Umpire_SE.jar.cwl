cwlVersion: v1.2
class: CommandLineTool
baseCommand: dia-umpire_DIA_Umpire_SE.jar
label: dia-umpire_DIA_Umpire_SE.jar
doc: "DIA-Umpire is a computational workflow for processing DIA (Data-Independent
  Acquisition) mass spectrometry data. (Note: The provided help text contains system
  error messages and does not list specific command-line arguments).\n\nTool homepage:
  https://github.com/cctsou/DIA-Umpire"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dia-umpire:v2.1.2_cv4
stdout: dia-umpire_DIA_Umpire_SE.jar.out
