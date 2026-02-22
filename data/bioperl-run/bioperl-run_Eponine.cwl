cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioperl-run_Eponine
label: bioperl-run_Eponine
doc: "The provided text contains system error messages (Singularity/Docker execution
  failure due to lack of disk space) rather than command-line help text. Consequently,
  no arguments or tool descriptions could be extracted.\n\nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_Eponine.out
