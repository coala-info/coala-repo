cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioperl-run_Cap3
label: bioperl-run_Cap3
doc: "BioPerl wrapper for the CAP3 sequence assembly program. (Note: The provided
  input text contains system error messages regarding container image retrieval and
  disk space, and does not include actual command-line help documentation or argument
  definitions.)\n\nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_Cap3.out
