cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-biosails
label: perl-biosails
doc: "The provided text does not contain help information or usage instructions for
  perl-biosails. It consists of system logs and a fatal error indicating that the
  executable was not found in the environment.\n\nTool homepage: https://github.com/biosails/BioSAILs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-biosails:0.02--pl526_0
stdout: perl-biosails.out
