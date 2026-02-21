cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - DIA-Umpire_To_Skyline
label: dia-umpire_DIA-Umpire_To_Skyline
doc: "A tool to convert DIA-Umpire results to Skyline format. (Note: The provided
  help text contains system error messages regarding container execution and does
  not list specific command-line arguments.)\n\nTool homepage: https://github.com/cctsou/DIA-Umpire"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dia-umpire:v2.1.2_cv4
stdout: dia-umpire_DIA-Umpire_To_Skyline.out
