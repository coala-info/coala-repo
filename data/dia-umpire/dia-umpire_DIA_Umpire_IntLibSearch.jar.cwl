cwlVersion: v1.2
class: CommandLineTool
baseCommand: dia-umpire_DIA_Umpire_IntLibSearch.jar
label: dia-umpire_DIA_Umpire_IntLibSearch.jar
doc: "The provided text does not contain help information for the tool, but rather
  system error messages related to a container environment (Singularity/Apptainer)
  failing to build an image due to lack of disk space.\n\nTool homepage: https://github.com/cctsou/DIA-Umpire"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dia-umpire:v2.1.2_cv4
stdout: dia-umpire_DIA_Umpire_IntLibSearch.jar.out
