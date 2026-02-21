cwlVersion: v1.2
class: CommandLineTool
baseCommand: go-filter.pl
label: perl-go-perl_go-filter.pl
doc: "A script from the perl-go-perl package (Gene Ontology Perl library) used for
  filtering GO files. Note: The provided input text was a system error log rather
  than help text, so specific arguments could not be extracted.\n\nTool homepage:
  http://metacpan.org/pod/go-perl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
stdout: perl-go-perl_go-filter.pl.out
