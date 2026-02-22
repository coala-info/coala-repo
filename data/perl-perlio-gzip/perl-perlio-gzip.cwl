cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-perlio-gzip
doc: "A Perl extension to provide a PerlIO layer to manipulate gzipped files. Note:
  The provided text contains system error messages regarding a failed container build
  and does not list command-line arguments.\n\nTool homepage: http://metacpan.org/pod/PerlIO-gzip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-perlio-gzip:0.20--pl5321h577a1d6_7
stdout: perl-perlio-gzip.out
