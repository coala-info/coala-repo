cwlVersion: v1.2
class: CommandLineTool
baseCommand: dia_umpire
label: dia_umpire
doc: "DIA-Umpire is an open-source computational pipeline for the analysis of data-independent
  acquisition (DIA) mass spectrometry-based proteomics data.\n\nTool homepage: https://github.com/Nesvilab/DIA-Umpire"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dia-umpire:v2.1.2_cv4
stdout: dia_umpire.out
