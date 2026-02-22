cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-alien-libxml2
label: perl-alien-libxml2
doc: "Alien::Libxml2 is a Perl module designed to find or install the libxml2 C library
  for use by other Perl modules.\n\nTool homepage: https://metacpan.org/pod/Alien::Libxml2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-alien-libxml2:0.20--pl5321hd2ab53c_0
stdout: perl-alien-libxml2.out
