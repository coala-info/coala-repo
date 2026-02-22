cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-net-ssleay
label: perl-net-ssleay
doc: "Net::SSLeay is a Perl extension for using OpenSSL. Note: The provided text contains
  system error logs regarding container image retrieval and does not contain CLI help
  documentation or argument definitions.\n\nTool homepage: http://metacpan.org/pod/Net::SSLeay"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-net-ssleay:1.92--pl5321h0e0aaa8_1
stdout: perl-net-ssleay.out
