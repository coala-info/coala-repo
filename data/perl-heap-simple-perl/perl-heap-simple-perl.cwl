cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-heap-simple-perl
label: perl-heap-simple-perl
doc: "The provided text does not contain help information; it indicates a fatal error
  where the executable was not found in the environment.\n\nTool homepage: https://github.com/gitpan/Heap-Simple-Perl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-heap-simple-perl:0.14--pl526_1
stdout: perl-heap-simple-perl.out
