cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge-build
label: centrifuge_centrifuge-build
doc: "Builds a Centrifuge index from a set of DNA sequences.\n\nTool homepage: https://github.com/DaehwanKimLab/centrifuge"
inputs:
  - id: reference_in
    type: string
    doc: Comma-separated list of files with ref sequences
    inputBinding:
      position: 1
  - id: conversion_table
    type:
      - 'null'
      - File
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
    type:
      - 'null'
      - File
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
  - id: centrifuge_index_base
    type: File
    doc: Write centrifuge index data to files with this base
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge:1.0.4.2--h077b44d_1
