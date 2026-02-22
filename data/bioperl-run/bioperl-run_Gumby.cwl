cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioperl-run_Gumby
label: bioperl-run_Gumby
doc: "BioPerl wrapper for the Gumby tool. (Note: The provided text contains system
  error messages regarding container execution and disk space, rather than command-line
  help documentation.)\n\nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_Gumby.out
