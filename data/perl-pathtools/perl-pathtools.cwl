cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pathtools
label: perl-pathtools
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed execution attempt where the executable was not found in
  the system PATH.\n\nTool homepage: http://dev.perl.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pathtools:3.75--pl526h14c3975_1
stdout: perl-pathtools.out
