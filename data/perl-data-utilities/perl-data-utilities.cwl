cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-data-utilities
label: perl-data-utilities
doc: "The provided text does not contain help information for 'perl-data-utilities'.
  It appears to be a log of a failed execution where the executable was not found
  in the system path.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-data-utilities:0.04--pl526_1
stdout: perl-data-utilities.out
