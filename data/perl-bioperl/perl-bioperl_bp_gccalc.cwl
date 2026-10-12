cwlVersion: v1.2
class: CommandLineTool
baseCommand: bp_gccalc
label: perl-bioperl_bp_gccalc
doc: "Print the GC content and the base counts of every nucleotide sequence in the input file (BioPerl script gccalc).\n\nTool homepage: http://metacpan.org/pod/BioPerl"
inputs:
  - id: input_file
    type: File
    doc: Sequence file to calculate the GC content from (FASTA by default)
    inputBinding:
      position: 1
      prefix: -i
  - id: format
    type:
      - 'null'
      - string
    doc: Sequence format of the input file (default fasta)
    inputBinding:
      position: 101
      prefix: -f
  - id: aggregate
    type:
      - 'null'
      - boolean
    doc: Also print the total GC content over all sequences
    inputBinding:
      position: 102
      prefix: -a
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the GC content report
stdout: $(inputs.input_file.nameroot).gccalc.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bioperl:1.7.8--hdfd78af_1
