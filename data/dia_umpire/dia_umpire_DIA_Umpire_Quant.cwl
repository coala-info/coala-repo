cwlVersion: v1.2
class: CommandLineTool
baseCommand: dia_umpire_DIA_Umpire_Quant
label: dia_umpire_DIA_Umpire_Quant
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to container image extraction (no space left on device).\n
  \nTool homepage: https://github.com/Nesvilab/DIA-Umpire"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dia-umpire:v2.1.2_cv4
stdout: dia_umpire_DIA_Umpire_Quant.out
