cwlVersion: v1.2
class: CommandLineTool
baseCommand: bp_index.pl
label: perl-bioperl_bp_index.pl
doc: "The provided text is a system error log regarding a container build failure
  and does not contain help information for the tool.\n\nTool homepage: http://metacpan.org/pod/BioPerl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bioperl:1.7.8--hdfd78af_1
stdout: perl-bioperl_bp_index.pl.out
