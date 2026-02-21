cwlVersion: v1.2
class: CommandLineTool
baseCommand: bp_extract_full_seq.pl
label: perl-bioperl_bp_extract_full_seq.pl
doc: "A BioPerl script to extract full sequences. Note: The provided input text contains
  system error messages regarding a container build failure and does not contain the
  actual help documentation for the tool.\n\nTool homepage: http://metacpan.org/pod/BioPerl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bioperl:1.7.8--hdfd78af_1
stdout: perl-bioperl_bp_extract_full_seq.pl.out
