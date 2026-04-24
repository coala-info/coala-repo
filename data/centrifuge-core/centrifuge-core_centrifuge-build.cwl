cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge-build
label: centrifuge-core_centrifuge-build
doc: "Builds a Centrifuge index from reference sequences.\n\nTool homepage: https://github.com/infphilo/centrifuge"
inputs:
  - id: reference_in
    type:
      type: array
      items: File
    doc: comma-separated list of files with ref sequences
    inputBinding:
      position: 1
  - id: cf_index_base
    type: Directory
    doc: write cf data to files with this dir/basename
    inputBinding:
      position: 2
  - id: bmax
    type:
      - 'null'
      - int
    doc: max bucket sz for blockwise suffix-array builder
    inputBinding:
      position: 103
      prefix: --bmax
  - id: bmaxdivn
    type:
      - 'null'
      - int
    doc: 'max bucket sz as divisor of ref len (default: 4)'
    inputBinding:
      position: 103
      prefix: --bmaxdivn
  - id: cmd_line_refs
    type:
      - 'null'
      - boolean
    doc: reference sequences given on cmd line (as <reference_in>)
    inputBinding:
      position: 103
      prefix: -c
  - id: conversion_table
    type: File
    doc: a table that converts any id to a taxonomy id
    inputBinding:
      position: 103
      prefix: --conversion-table
  - id: dcv
    type:
      - 'null'
      - int
    doc: 'diff-cover period for blockwise (default: 1024)'
    inputBinding:
      position: 103
      prefix: --dcv
  - id: ftabchars
    type:
      - 'null'
      - int
    doc: '# of chars consumed in initial lookup (default: 10)'
    inputBinding:
      position: 103
      prefix: --ftabchars
  - id: justref
    type:
      - 'null'
      - boolean
    doc: just build .3/.4.bt2 (packed reference) portion
    inputBinding:
      position: 103
      prefix: --justref
  - id: kmer_count
    type:
      - 'null'
      - int
    doc: k size for counting the number of distinct k-mer
    inputBinding:
      position: 103
      prefix: --kmer-count
  - id: name_table
    type:
      - 'null'
      - File
    doc: names corresponding to taxonomic IDs
    inputBinding:
      position: 103
      prefix: --name-table
  - id: noauto
    type:
      - 'null'
      - boolean
    doc: disable automatic -p/--bmax/--dcv memory-fitting
    inputBinding:
      position: 103
      prefix: --noauto
  - id: nodc
    type:
      - 'null'
      - boolean
    doc: disable diff-cover (algorithm becomes quadratic)
    inputBinding:
      position: 103
      prefix: --nodc
  - id: noref
    type:
      - 'null'
      - boolean
    doc: don't build .3/.4.bt2 (packed reference) portion
    inputBinding:
      position: 103
      prefix: --noref
  - id: offrate
    type:
      - 'null'
      - int
    doc: 'SA is sampled every 2^offRate BWT chars (default: 4)'
    inputBinding:
      position: 103
      prefix: --offrate
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: verbose output (for debugging)
    inputBinding:
      position: 103
      prefix: --quiet
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for random number generator
    inputBinding:
      position: 103
      prefix: --seed
  - id: size_table
    type:
      - 'null'
      - File
    doc: table of contig (or genome) sizes
    inputBinding:
      position: 103
      prefix: --size-table
  - id: taxonomy_tree
    type: File
    doc: taxonomy tree
    inputBinding:
      position: 103
      prefix: --taxonomy-tree
  - id: threads
    type:
      - 'null'
      - int
    doc: number of alignment threads to launch
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
stdout: centrifuge-core_centrifuge-build.out
