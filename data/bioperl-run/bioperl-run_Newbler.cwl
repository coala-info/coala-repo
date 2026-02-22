cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioperl-run_Newbler
label: bioperl-run_Newbler
doc: "A BioPerl wrapper for the Newbler (454) sequence assembly software. Note: The
  provided text contains system error messages regarding disk space and container
  execution rather than command-line help documentation.\n\nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_Newbler.out
