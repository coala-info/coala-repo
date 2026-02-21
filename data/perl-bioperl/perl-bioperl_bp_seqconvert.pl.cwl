cwlVersion: v1.2
class: CommandLineTool
baseCommand: bp_seqconvert.pl
label: perl-bioperl_bp_seqconvert.pl
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or argument definitions for the tool. bp_seqconvert.pl
  is a BioPerl script used for converting biological sequence formats.\n\nTool homepage:
  http://metacpan.org/pod/BioPerl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bioperl:1.7.8--hdfd78af_1
stdout: perl-bioperl_bp_seqconvert.pl.out
