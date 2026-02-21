cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-bioperl
doc: "BioPerl is a toolkit of Perl modules useful in building bioinformatics solutions
  in Perl.\n\nTool homepage: http://metacpan.org/pod/BioPerl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bioperl:1.7.8--hdfd78af_1
stdout: perl-bioperl.out
