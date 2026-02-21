cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-gzip
label: perl-io-gzip
doc: "The provided text does not contain help information as the executable was not
  found in the environment. perl-io-gzip is typically a Perl module (IO::Gzip) providing
  a layer for manipulating gzip-compressed files.\n\nTool homepage: https://metacpan.org/pod/PerlIO::gzip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-gzip:0.20--pl5.22.0_0
stdout: perl-io-gzip.out
