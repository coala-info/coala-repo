cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-cigar
label: perl-bio-cigar
doc: "A Perl-based tool for parsing and manipulating CIGAR strings. (Note: The provided
  help text was an error log and did not contain specific usage or argument details.)\n
  \nTool homepage: http://search.cpan.org/~tsibley/Bio-Cigar-1.01"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-cigar:1.01--pl526_3
stdout: perl-bio-cigar.out
