cwlVersion: v1.2
class: CommandLineTool
baseCommand: exonerate
label: bioperl-run_Exonerate
doc: "Exonerate is a generic tool for pairwise sequence alignment. Note: The provided
  help text contains system error messages regarding container execution and does
  not list specific command-line arguments.\n\nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_Exonerate.out
