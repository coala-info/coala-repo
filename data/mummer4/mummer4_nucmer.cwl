cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucmer
label: mummer4_nucmer
doc: "generates nucleotide alignments between two mutli-FASTA input files. The out.delta
  output file lists the distance between insertions and deletions that produce maximal
  scoring alignments between each sequence. The show-* utilities know how to read
  this format.\n\nTool homepage: https://mummer4.github.io/"
inputs:
  - id: reference
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 1
  - id: query
    type:
      type: array
      items: File
    doc: Query FASTA file(s)
    inputBinding:
      position: 2
  - id: batch_bases
    type:
      - 'null'
      - int
    doc: Proceed by batch of chunks of BASES from the reference
    inputBinding:
      position: 103
      prefix: --batch
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
  - id: forward
    type:
      - 'null'
      - boolean
    doc: Use only the forward strand of the Query sequences
    default: false
    inputBinding:
      position: 103
      prefix: --forward
  - id: load_prefix
    type:
      - 'null'
      - string
    doc: Load suffix array from file starting with PREFIX
    inputBinding:
      position: 103
      prefix: --load
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
    default: false
    inputBinding:
      position: 103
      prefix: --maxmatch
  - id: minalign
    type:
      - 'null'
      - int
    doc: Minimum length of an alignment, after clustering and extension
    default: 0
    inputBinding:
      position: 103
      prefix: --minalign
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
    doc: Set the minimum length of a single exact match
    default: 20
    inputBinding:
      position: 103
      prefix: --minmatch
  - id: mum
    type:
      - 'null'
      - boolean
    doc: Use anchor matches that are unique in both the reference and query
    default: false
    inputBinding:
      position: 103
      prefix: --mum
  - id: noextend
    type:
      - 'null'
      - boolean
    doc: Do not perform cluster extension step
    default: false
    inputBinding:
      position: 103
      prefix: --noextend
  - id: nooptimize
    type:
      - 'null'
      - boolean
    doc: No alignment score optimization, i.e. if an alignment extension reaches
      the end of a sequence, it will not backtrack to optimize the alignment 
      score and instead terminate the alignment at the end of the sequence
    default: false
    inputBinding:
      position: 103
      prefix: --nooptimize
  - id: nosimplify
    type:
      - 'null'
      - boolean
    doc: Don't simplify alignments by removing shadowed clusters. Use this 
      option when aligning a sequence to itself to look for repeats
    default: false
    inputBinding:
      position: 103
      prefix: --nosimplify
  - id: prefix
    type:
      - 'null'
      - string
    doc: Write output to PREFIX.delta
    default: out
    inputBinding:
      position: 103
      prefix: --prefix
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Use only the reverse complement of the Query sequences
    default: false
    inputBinding:
      position: 103
      prefix: --reverse
  - id: save_prefix
    type:
      - 'null'
      - string
    doc: Save suffix array to files starting with PREFIX
    inputBinding:
      position: 103
      prefix: --save
  - id: threads
    type:
      - 'null'
      - int
    doc: Use NUM threads
    default: 2
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: delta_file
    type:
      - 'null'
      - File
    doc: Output delta file to PATH (instead of PREFIX.delta)
    outputBinding:
      glob: $(inputs.delta_file)
  - id: sam_short_file
    type:
      - 'null'
      - File
    doc: Output SAM file to PATH, short format
    outputBinding:
      glob: $(inputs.sam_short_file)
  - id: sam_long_file
    type:
      - 'null'
      - File
    doc: Output SAM file to PATH, long format
    outputBinding:
      glob: $(inputs.sam_long_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
