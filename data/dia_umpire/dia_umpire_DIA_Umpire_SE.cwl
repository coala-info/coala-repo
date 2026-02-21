cwlVersion: v1.2
class: CommandLineTool
baseCommand: DIA_Umpire_SE
label: dia_umpire_DIA_Umpire_SE
doc: "DIA-Umpire is a computational workflow for the analysis of data-independent
  acquisition (DIA) mass spectrometry data. The SE (Signal Extraction) module is used
  for processing raw DIA data.\n\nTool homepage: https://github.com/Nesvilab/DIA-Umpire"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dia-umpire:v2.1.2_cv4
stdout: dia_umpire_DIA_Umpire_SE.out
