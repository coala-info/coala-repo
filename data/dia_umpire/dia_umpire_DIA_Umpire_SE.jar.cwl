cwlVersion: v1.2
class: CommandLineTool
baseCommand: dia_umpire_DIA_Umpire_SE.jar
label: dia_umpire_DIA_Umpire_SE.jar
doc: "DIA-Umpire Signal Extraction (SE) tool for processing DIA mass spectrometry
  data. Note: The provided help text contains only system error messages and does
  not list command-line arguments.\n\nTool homepage: https://github.com/Nesvilab/DIA-Umpire"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dia-umpire:v2.1.2_cv4
stdout: dia_umpire_DIA_Umpire_SE.jar.out
