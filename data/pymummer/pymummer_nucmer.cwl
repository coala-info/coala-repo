cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucmer
label: pymummer_nucmer
doc: "nucmer generates nucleotide alignments between two mutli-FASTA input files.
  The out.delta output file lists the distance between insertions and deletions that
  produce maximal scoring alignments between each sequence. The show-* utilities know
  how to read this format.\n\nTool homepage: https://github.com/sanger-pathogens/pymummer"
inputs:
  - id: reference
    type: File
    doc: Set the input reference multi-FASTA filename
    inputBinding:
      position: 1
  - id: query
    type: File
    doc: Set the input query multi-FASTA filename
    inputBinding:
      position: 2
  - id: banded
    type:
      - 'null'
      - boolean
    doc: Enforce absolute banding of dynamic programming matrix based on 
      diagdiff parameter EXPERIMENTAL
    default: false
    inputBinding:
      position: 103
      prefix: --banded
  - id: breaklen
    type:
      - 'null'
      - int
    doc: Set the distance an alignment extension will attempt to extend poor 
      scoring regions before giving up
    default: 200
    inputBinding:
      position: 103
      prefix: --breaklen
  - id: coords
    type:
      - 'null'
      - string
    doc: Automatically generate the original NUCmer1.1 coords output file using 
      the 'show-coords' program
    inputBinding:
      position: 103
      prefix: --coords
  - id: delta
    type:
      - 'null'
      - boolean
    doc: Toggle the creation of the delta file
    default: true
    inputBinding:
      position: 103
      prefix: --delta
  - id: depend
    type:
      - 'null'
      - boolean
    doc: Print the dependency information and exit
    inputBinding:
      position: 103
      prefix: --depend
  - id: diagdiff
    type:
      - 'null'
      - int
    doc: Set the maximum diagonal difference between two adjacent anchors in a 
      cluster
    default: 5
    inputBinding:
      position: 103
      prefix: --diagdiff
  - id: diagfactor
    type:
      - 'null'
      - float
    doc: Set the maximum diagonal difference between two adjacent anchors in a 
      cluster as a differential fraction of the gap length
    default: 0.12
    inputBinding:
      position: 103
      prefix: --diagfactor
  - id: extend
    type:
      - 'null'
      - boolean
    doc: Toggle the cluster extension step
    default: true
    inputBinding:
      position: 103
      prefix: --extend
  - id: forward
    type:
      - 'null'
      - boolean
    doc: Use only the forward strand of the Query sequences
    inputBinding:
      position: 103
      prefix: --forward
  - id: maxgap
    type:
      - 'null'
      - int
    doc: Set the maximum gap between two adjacent matches in a cluster
    default: 90
    inputBinding:
      position: 103
      prefix: --maxgap
  - id: maxmatch
    type:
      - 'null'
      - boolean
    doc: Use all anchor matches regardless of their uniqueness
    inputBinding:
      position: 103
      prefix: --maxmatch
  - id: mincluster
    type:
      - 'null'
      - int
    doc: Sets the minimum length of a cluster of matches
    default: 65
    inputBinding:
      position: 103
      prefix: --mincluster
  - id: minmatch
    type:
      - 'null'
      - int
    doc: Set the minimum length of a single match
    default: 20
    inputBinding:
      position: 103
      prefix: --minmatch
  - id: mum
    type:
      - 'null'
      - boolean
    doc: Use anchor matches that are unique in both the reference and query
    inputBinding:
      position: 103
      prefix: --mum
  - id: mumcand
    type:
      - 'null'
      - boolean
    doc: Same as --mumreference
    inputBinding:
      position: 103
      prefix: --mumcand
  - id: mumreference
    type:
      - 'null'
      - boolean
    doc: Use anchor matches that are unique in in the reference but not 
      necessarily unique in the query (default behavior)
    default: true
    inputBinding:
      position: 103
      prefix: --mumreference
  - id: no_banded
    type:
      - 'null'
      - boolean
    doc: Enforce absolute banding of dynamic programming matrix based on 
      diagdiff parameter EXPERIMENTAL
    default: true
    inputBinding:
      position: 103
      prefix: --no-banded
  - id: no_delta
    type:
      - 'null'
      - boolean
    doc: Toggle the creation of the delta file
    default: false
    inputBinding:
      position: 103
      prefix: --no-delta
  - id: no_extend
    type:
      - 'null'
      - boolean
    doc: Toggle the cluster extension step
    default: false
    inputBinding:
      position: 103
      prefix: --no-extend
  - id: no_optimize
    type:
      - 'null'
      - boolean
    doc: Toggle alignment score optimization, i.e. if an alignment extension 
      reaches the end of a sequence, it will backtrack to optimize the alignment
      score instead of terminating the alignment at the end of the sequence
    default: false
    inputBinding:
      position: 103
      prefix: --no-optimize
  - id: no_simplify
    type:
      - 'null'
      - boolean
    doc: Simplify alignments by removing shadowed clusters. Turn this option off
      if aligning a sequence to itself to look for repeats
    default: false
    inputBinding:
      position: 103
      prefix: --no-simplify
  - id: optimize
    type:
      - 'null'
      - boolean
    doc: Toggle alignment score optimization, i.e. if an alignment extension 
      reaches the end of a sequence, it will backtrack to optimize the alignment
      score instead of terminating the alignment at the end of the sequence
    default: true
    inputBinding:
      position: 103
      prefix: --optimize
  - id: prefix
    type:
      - 'null'
      - string
    doc: Set the prefix of the output files
    default: out
    inputBinding:
      position: 103
      prefix: --prefix
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Use only the reverse complement of the Query sequences
    inputBinding:
      position: 103
      prefix: --reverse
  - id: simplify
    type:
      - 'null'
      - boolean
    doc: Simplify alignments by removing shadowed clusters. Turn this option off
      if aligning a sequence to itself to look for repeats
    default: true
    inputBinding:
      position: 103
      prefix: --simplify
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymummer:0.12.0--pyhdfd78af_0
stdout: pymummer_nucmer.out
