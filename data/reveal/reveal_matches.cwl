cwlVersion: v1.2
class: CommandLineTool
baseCommand: reveal_matches
label: reveal_matches
doc: "Outputs all (multi) m(u/e)ms.\n\nTool homepage: https://github.com/hakimel/reveal.js"
inputs:
  - id: reference
    type: string
    doc: Graph or sequence to which query/contigs should be assigned.
    inputBinding:
      position: 1
  - id: contigs
    type: string
    doc: Graph or fasta that is to be reverse complemented with respect to the 
      reference.
    inputBinding:
      position: 2
  - id: cache
    type:
      - 'null'
      - boolean
    doc: When specified, it caches the text, suffix and lcp array to disk after 
      construction.
    inputBinding:
      position: 103
      prefix: --cache
  - id: lcp1
    type:
      - 'null'
      - File
    doc: Specify a preconstructed lcp array for extracting matches between the 
      two genomes in their current orientation.
    inputBinding:
      position: 103
      prefix: --lcp1
  - id: lcp2
    type:
      - 'null'
      - File
    doc: Specify a preconstructed lcp array for extracting matches between the 
      two genomes in which the sequence of the contigs was reverse complemented.
    inputBinding:
      position: 103
      prefix: --lcp2
  - id: min_length
    type:
      - 'null'
      - int
    doc: Min length of maximal exact matches for considering
    default: 20
    inputBinding:
      position: 103
      prefix: -m
  - id: sa1
    type:
      - 'null'
      - File
    doc: Specify a preconstructed suffix array for extracting matches between 
      the two genomes in their current orientation.
    inputBinding:
      position: 103
      prefix: --sa1
  - id: sa2
    type:
      - 'null'
      - File
    doc: Specify a preconstructed suffix array for extracting matches between 
      the two genomes in which the sequence of the contigs was reverse 
      complemented.
    inputBinding:
      position: 103
      prefix: --sa2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reveal:0.1--py27_1
stdout: reveal_matches.out
