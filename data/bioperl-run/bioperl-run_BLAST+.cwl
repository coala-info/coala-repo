cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioperl-run_BLAST+
label: bioperl-run_BLAST+
doc: "BioPerl wrapper for BLAST+. (Note: The provided input text contains system error
  messages regarding disk space and container image handling rather than command-line
  help documentation.)\n\nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_BLAST+.out
