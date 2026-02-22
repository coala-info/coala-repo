cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioperl-run
label: bioperl-run
doc: "BioPerl-run is a collection of modules that provide a consistent interface to
  various bioinformatics applications. (Note: The provided text contains system error
  messages regarding container image acquisition and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run.out
