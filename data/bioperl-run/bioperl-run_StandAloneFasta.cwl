cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioperl-run_StandAloneFasta
label: bioperl-run_StandAloneFasta
doc: "BioPerl wrapper for StandAloneFasta. (Note: The provided input text contains
  system error messages regarding container execution and does not contain help documentation
  or argument definitions.)\n\nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_StandAloneFasta.out
