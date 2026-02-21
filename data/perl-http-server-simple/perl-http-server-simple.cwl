cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-http-server-simple
label: perl-http-server-simple
doc: "The provided text does not contain help information or a description for the
  tool; it is an error log indicating the executable was not found.\n\nTool homepage:
  https://metacpan.org/pod/HTTP::Server::Simple"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-http-server-simple:0.52--pl526_2
stdout: perl-http-server-simple.out
