cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge-build
label: centrifuge_centrifuge-build
doc: "Builds a Centrifuge index from a set of DNA sequences.\n\nTool homepage: https://github.com/DaehwanKimLab/centrifuge"
inputs:
  - id: reference_in
    type:
      type: array
      items: File
    doc: Files with reference sequences (FASTA); joined with commas
    inputBinding:
      position: 1
      itemSeparator: ','
  - id: index_base
    type: string
    doc: Write centrifuge index data to files with this dir/basename
    inputBinding:
      position: 2
  - id: noauto
    type:
      - 'null'
      - boolean
    doc: Disable automatic -p/--bmax/--dcv memory-fitting
    inputBinding:
      position: 102
      prefix: --noauto
  - id: bmax
    type:
      - 'null'
      - int
    doc: Max bucket size for blockwise suffix-array builder
    inputBinding:
      position: 102
      prefix: --bmax
  - id: bmaxdivn
    type:
      - 'null'
      - int
    doc: 'Max bucket size as divisor of ref len (default: 4)'
    inputBinding:
      position: 102
      prefix: --bmaxdivn
  - id: dcv
    type:
      - 'null'
      - int
    doc: 'Diff-cover period for blockwise (default: 1024)'
    inputBinding:
      position: 102
      prefix: --dcv
  - id: nodc
    type:
      - 'null'
      - boolean
    doc: Disable diff-cover (algorithm becomes quadratic)
    inputBinding:
      position: 102
      prefix: --nodc
  - id: noref
    type:
      - 'null'
      - boolean
    doc: Do not build .3/.4 (packed reference) portion
    inputBinding:
      position: 102
      prefix: --noref
  - id: justref
    type:
      - 'null'
      - boolean
    doc: Just build .3/.4 (packed reference) portion
    inputBinding:
      position: 102
      prefix: --justref
  - id: size_table
    type:
      - 'null'
      - File
    doc: Table of contig (or genome) sizes
    inputBinding:
      position: 102
      prefix: --size-table
  - id: kmer_count
    type:
      - 'null'
      - int
    doc: k size for counting the number of distinct k-mers
    inputBinding:
      position: 102
      prefix: --kmer-count
  - id: conversion_table
    type: File
    doc: A table that maps every reference sequence to a specific taxonomic ID
    inputBinding:
      position: 102
      prefix: --conversion-table
  - id: ftabchars
    type:
      - 'null'
      - int
    doc: Number of chars consumed in initial lookup
    inputBinding:
      position: 102
      prefix: --ftabchars
  - id: name_table
    type:
      - 'null'
      - File
    doc: Names table file (names.dmp)
    inputBinding:
      position: 102
      prefix: --name-table
  - id: offrate
    type:
      - 'null'
      - int
    doc: SA is sampled every 2^offRate BWT chars
    inputBinding:
      position: 102
      prefix: --offrate
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Verbose output (for debugging)
    inputBinding:
      position: 102
      prefix: --quiet
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator
    inputBinding:
      position: 102
      prefix: --seed
  - id: taxonomy_tree
    type: File
    doc: Taxonomy tree file (nodes.dmp)
    inputBinding:
      position: 102
      prefix: --taxonomy-tree
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: centrifuge_index
    type:
      type: array
      items: File
    doc: Centrifuge index files (<index_base>.1.cf ... .4.cf)
    outputBinding:
      glob: $(inputs.index_base).*.cf
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge:1.0.4.2--h077b44d_1
