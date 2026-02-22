cwlVersion: v1.2
class: CommandLineTool
baseCommand: t_coffee
label: bioperl-run_T-Coffee
doc: "T-Coffee is a multiple sequence alignment package. (Note: The provided help
  text contains system error messages regarding disk space and container image retrieval
  rather than tool usage instructions.)\n\nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_T-Coffee.out
