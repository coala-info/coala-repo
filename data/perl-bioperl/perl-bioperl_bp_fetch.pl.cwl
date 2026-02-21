cwlVersion: v1.2
class: CommandLineTool
baseCommand: bp_fetch.pl
label: perl-bioperl_bp_fetch.pl
doc: "A BioPerl script for fetching sequences from various biological databases. (Note:
  The provided text was a system error log and did not contain help documentation;
  arguments could not be extracted from the input.)\n\nTool homepage: http://metacpan.org/pod/BioPerl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bioperl:1.7.8--hdfd78af_1
stdout: perl-bioperl_bp_fetch.pl.out
