cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-bioperl-core
doc: "BioPerl is a community effort to produce Perl modules which are useful in biology.
  This package provides the core modules.\n\nTool homepage: http://metacpan.org/pod/BioPerl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bioperl-core:1.007002--pl526_0
stdout: perl-bioperl-core.out
