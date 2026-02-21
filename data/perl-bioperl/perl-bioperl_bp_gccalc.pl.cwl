cwlVersion: v1.2
class: CommandLineTool
baseCommand: bp_gccalc.pl
label: perl-bioperl_bp_gccalc.pl
doc: "Calculates the GC content of DNA sequences. Part of the BioPerl suite.\n\nTool
  homepage: http://metacpan.org/pod/BioPerl"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Sequence files (FASTA or other BioPerl supported formats) to calculate GC
      content from.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bioperl:1.7.8--hdfd78af_1
stdout: perl-bioperl_bp_gccalc.pl.out
