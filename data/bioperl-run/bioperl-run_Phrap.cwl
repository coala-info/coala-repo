cwlVersion: v1.2
class: CommandLineTool
baseCommand: phrap
label: bioperl-run_Phrap
doc: "Phrap is a program for assembling shotgun DNA sequence data (Note: The provided
  text contains system error messages regarding disk space and container execution
  rather than tool help documentation; therefore, no arguments could be extracted).\n\
  \nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_Phrap.out
