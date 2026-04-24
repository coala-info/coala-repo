cwlVersion: v1.2
class: CommandLineTool
baseCommand: pal2nal.pl
label: pal2nal_pal2nal.pl
doc: "pal2nal is a program that converts a multiple sequence alignment of proteins
  and the corresponding DNA (or mRNA) sequences into a codon-based DNA alignment.\n
  \nTool homepage: http://www.bork.embl.de/pal2nal/"
inputs:
  - id: pep_aln
    type: File
    doc: protein alignment either in CLUSTAL or FASTA format
    inputBinding:
      position: 1
  - id: nuc_fasta
    type:
      type: array
      items: File
    doc: DNA sequences (single multi-fasta or separated files)
    inputBinding:
      position: 2
  - id: block_only
    type:
      - 'null'
      - boolean
    doc: Show only user specified blocks '#' under CLUSTAL alignment
    inputBinding:
      position: 103
      prefix: -blockonly
  - id: codon_table
    type:
      - 'null'
      - int
    doc: Genetic code table (1-23, e.g., 1 for Universal, 2 for Vertebrate mitochondrial)
    inputBinding:
      position: 103
      prefix: -codontable
  - id: html
    type:
      - 'null'
      - boolean
    doc: HTML output (only for the web server)
    inputBinding:
      position: 103
      prefix: -html
  - id: no_gap
    type:
      - 'null'
      - boolean
    doc: remove columns with gaps and inframe stop codons
    inputBinding:
      position: 103
      prefix: -nogap
  - id: no_mismatch
    type:
      - 'null'
      - boolean
    doc: remove mismatched codons (mismatch between pep and cDNA) from the output
    inputBinding:
      position: 103
      prefix: -nomismatch
  - id: no_stderr
    type:
      - 'null'
      - boolean
    doc: No STDERR messages (only for the web server)
    inputBinding:
      position: 103
      prefix: -nostderr
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format (clustal|paml|fasta|codon)
    inputBinding:
      position: 103
      prefix: -output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pal2nal:v14.1-2-deb_cv1
stdout: pal2nal_pal2nal.pl.out
