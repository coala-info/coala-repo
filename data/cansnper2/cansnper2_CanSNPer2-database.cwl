cwlVersion: v1.2
class: CommandLineTool
baseCommand: CanSNPer2-database
label: cansnper2_CanSNPer2-database
doc: "Database management tool for CanSNPer2. (Note: The provided text contains build
  logs and error messages rather than command-line help documentation.)\n\nTool homepage:
  https://github.com/FOI-Bioinformatics/CanSNPer2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansnper2:2.0.6--py_0
stdout: cansnper2_CanSNPer2-database.out
