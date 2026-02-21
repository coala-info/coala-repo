cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-net-netrc
label: perl-net-netrc
doc: "The provided text does not contain help information as the executable was not
  found in the environment. Net::Netrc is typically a Perl module used to interface
  with .netrc files.\n\nTool homepage: https://github.com/Altai-man/perl6-Config-Netrc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-net-netrc:2.14--pl526_1
stdout: perl-net-netrc.out
