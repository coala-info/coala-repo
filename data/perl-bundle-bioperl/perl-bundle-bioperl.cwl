cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bundle-bioperl
label: perl-bundle-bioperl
doc: "BioPerl is a toolkit of Perl modules that facilitates the development of Perl
  scripts for bioinformatics applications.\n\nTool homepage: http://metacpan.org/pod/Bundle::BioPerl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bundle-bioperl:2.1.9--pl526_0
stdout: perl-bundle-bioperl.out
