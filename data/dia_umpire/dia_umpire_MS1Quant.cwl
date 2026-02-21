cwlVersion: v1.2
class: CommandLineTool
baseCommand: dia_umpire_MS1Quant
label: dia_umpire_MS1Quant
doc: "A tool for MS1 quantification within the DIA-Umpire pipeline. (Note: The provided
  help text contains system error messages regarding container execution and does
  not list specific command-line arguments.)\n\nTool homepage: https://github.com/Nesvilab/DIA-Umpire"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dia-umpire:v2.1.2_cv4
stdout: dia_umpire_MS1Quant.out
