cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phastMotif
label: phast_phastmotif
doc: "Predicts motifs from a set of multiple alignments. Uses an EM algorithm similar to that\
  \ of MEME, but a motif is defined by phylogenetic models rather than multinomial distributions.\n\
  \nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: tree
    type:
      - 'null'
      - File
    doc: (Required unless -m or -p) Tree topology for all phylogenetic models (Newick format).
    inputBinding:
      position: 1
      prefix: -t
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Input format for alignment: FASTA, PHYLIP, MPM, SS or MAF (default FASTA).'
    inputBinding:
      position: 1
      prefix: -i
  - id: background_mod
    type:
      - 'null'
      - File
    doc: Read background model from specified file (.mod format).
    inputBinding:
      position: 1
      prefix: -b
  - id: motif_size
    type:
      - 'null'
      - int
    doc: Learn motifs of the specified size (default 10).
    inputBinding:
      position: 1
      prefix: -k
  - id: nbest
    type:
      - 'null'
      - int
    doc: Report best n motifs (default 3).
    inputBinding:
      position: 1
      prefix: -B
  - id: meme_mode
    type:
      - 'null'
      - boolean
    doc: 'MEME mode: use multinomial rather than phylogenetic models.'
    inputBinding:
      position: 1
      prefix: -m
  - id: positive_list
    type:
      - 'null'
      - string
    doc: Use discriminative training; comma-separated list of the msa_list file names that
      are positive examples.
    inputBinding:
      position: 1
      prefix: -d
  - id: profile
    type:
      - 'null'
      - boolean
    doc: Use profile models rather than phylogenetic models (not yet implemented).
    inputBinding:
      position: 1
      prefix: -p
  - id: nrestarts
    type:
      - 'null'
      - int
    doc: Number of random restarts (default 10).
    inputBinding:
      position: 1
      prefix: -n
  - id: init_consensus
    type:
      - 'null'
      - string
    doc: Soft initialization with each of the consensus sequences in this comma-separated
      list.
    inputBinding:
      position: 1
      prefix: -I
  - id: init_prevalent
    type:
      - 'null'
      - string
    doc: Initialize with the x most prevalent y-tuples (x,y).
    inputBinding:
      position: 1
      prefix: -P
  - id: init_random
    type:
      - 'null'
      - string
    doc: Initialize with a random sample of x y-tuples (x,y).
    inputBinding:
      position: 1
      prefix: -R
  - id: winnow
    type:
      - 'null'
      - int
    doc: (With -I, -P, -R) Winnow initialization sequences to the top n.
    inputBinding:
      position: 1
      prefix: -w
  - id: pseudocounts
    type:
      - 'null'
      - int
    doc: (With -I, -P, -R) Pseudocounts for consensus bases (default 5).
    inputBinding:
      position: 1
      prefix: -c
  - id: sample_params
    type:
      - 'null'
      - boolean
    doc: (With -I, -P, -R) Sample parameters from a Dirichlet distribution.
    inputBinding:
      position: 1
      prefix: -S
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: Prefix for all output files (default "phastm").
    default: phastm
    inputBinding:
      position: 1
      prefix: -o
  - id: html
    type:
      - 'null'
      - boolean
    doc: Produce HTML formatted output, in addition to ordinary output.
    inputBinding:
      position: 1
      prefix: -H
  - id: bed
    type:
      - 'null'
      - boolean
    doc: Produce a BED file with predicted motifs.
    inputBinding:
      position: 1
      prefix: -D
  - id: suppress_stdout
    type:
      - 'null'
      - boolean
    doc: (With -H or -D) Suppress ordinary output to stdout.
    inputBinding:
      position: 1
      prefix: -x
  - id: msa_files
    type: File[]
    doc: Alignments (or single sequences with -m), passed as a comma-separated list.
    inputBinding:
      position: 2
      itemSeparator: ','
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the file for ordinary output (standard output).
    default: phastMotif.out
outputs:
  - id: report
    type: File
    doc: Ordinary motif report.
    outputBinding:
      glob: $(inputs.output_name)
  - id: motif_files
    type:
      type: array
      items: File
    doc: Files written with the output prefix (HTML, BED, models).
    outputBinding:
      glob: $(inputs.out_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
stdout: $(inputs.output_name)
