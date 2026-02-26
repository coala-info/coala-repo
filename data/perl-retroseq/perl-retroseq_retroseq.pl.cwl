cwlVersion: v1.2
class: CommandLineTool
baseCommand: retroseq.pl
label: perl-retroseq_retroseq.pl
doc: "A tool for discovery of transposable elements from short read alignments\n\n\
  Tool homepage: https://github.com/tk2/RetroSeq"
inputs:
  - id: call
    type:
      - 'null'
      - boolean
    doc: Takes multiple output of discovery stage and a BAM and outputs a VCF of
      TE calls
    inputBinding:
      position: 101
      prefix: -call
  - id: discover
    type:
      - 'null'
      - boolean
    doc: Takes a BAM and a set of reference TE (fasta) and calls candidate 
      supporting read pairs (BED output)
    inputBinding:
      position: 101
      prefix: -discover
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-retroseq:1.5--pl5321h7181c03_3
stdout: perl-retroseq_retroseq.pl.out
