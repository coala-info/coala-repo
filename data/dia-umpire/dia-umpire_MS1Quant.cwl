cwlVersion: v1.2
class: CommandLineTool
baseCommand: dia-umpire_MS1Quant
label: dia-umpire_MS1Quant
doc: "DIA-Umpire MS1 quantification tool. (Note: The provided help text contains only
  system error messages regarding container execution and does not list command-line
  arguments.)\n\nTool homepage: https://github.com/cctsou/DIA-Umpire"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dia-umpire:v2.1.2_cv4
stdout: dia-umpire_MS1Quant.out
