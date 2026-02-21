cwlVersion: v1.2
class: CommandLineTool
baseCommand: dia-umpire_DIA_Umpire_ProtQuant.jar
label: dia-umpire_DIA_Umpire_ProtQuant.jar
doc: "DIA-Umpire ProtQuant (Note: The provided text contains system error messages
  regarding container execution and does not include usage instructions or argument
  definitions).\n\nTool homepage: https://github.com/cctsou/DIA-Umpire"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dia-umpire:v2.1.2_cv4
stdout: dia-umpire_DIA_Umpire_ProtQuant.jar.out
