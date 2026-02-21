cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-net-ftp-recursive
label: perl-net-ftp-recursive
doc: "The provided text does not contain help information as the executable was not
  found in the environment. No arguments could be parsed.\n\nTool homepage: http://metacpan.org/pod/Net::FTP::Recursive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-net-ftp-recursive:2.04--pl526_1
stdout: perl-net-ftp-recursive.out
