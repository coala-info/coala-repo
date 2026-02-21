cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-go-perl
label: perl-go-perl
doc: "The provided text is an error log from a container build process and does not
  contain help information or command-line arguments for the tool.\n\nTool homepage:
  http://metacpan.org/pod/go-perl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
stdout: perl-go-perl.out
