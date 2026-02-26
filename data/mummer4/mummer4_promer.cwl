cwlVersion: v1.2
class: CommandLineTool
baseCommand: promer
label: mummer4_promer
doc: "promer generates amino acid alignments between two mutli-FASTA DNA input files.
  The out.delta output file lists the distance between insertions and deletions that
  produce maximal scoring alignments between each sequence. The show-* utilities know
  how to read this format. The DNA input is translated into all 6 reading frames in
  order to generate the output, but the output coordinates reference the original
  DNA input.\n\nTool homepage: https://mummer4.github.io/"
inputs:
  - id: reference
    type: File
    doc: Set the input reference multi-FASTA DNA file
    inputBinding:
      position: 1
  - id: query
    type: File
    doc: Set the input query multi-FASTA DNA file
    inputBinding:
      position: 2
  - id: breaklen
    type:
      - 'null'
      - int
    doc: Set the distance an alignment extension will attempt to extend poor 
      scoring regions before giving up, measured in amino acids
    default: 60
    inputBinding:
      position: 103
      prefix: --breaklen
  - id: coords
    type:
      - 'null'
      - boolean
    doc: Automatically generate the original PROmer1.1 ".coords" output file 
      using the "show-coords" program
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
  - id: diagfactor
    type:
      - 'null'
      - float
    doc: Set the clustering diagonal difference separation factor
    default: 0.11
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
  - id: masklen
    type:
      - 'null'
      - int
    doc: Set the maximum bookend masking lenth, measured in amino acids
    default: 8
    inputBinding:
      position: 103
      prefix: --masklen
  - id: matrix
    type:
      - 'null'
      - int
    doc: Set the alignment matrix number to 1 [BLOSUM 45], 2 [BLOSUM 62] or 3 
      [BLOSUM 80]
    default: 2
    inputBinding:
      position: 103
      prefix: --matrix
  - id: maxgap
    type:
      - 'null'
      - int
    doc: Set the maximum gap between two adjacent matches in a cluster, measured
      in amino acids
    default: 30
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
    doc: Sets the minimum length of a cluster of matches, measured in amino 
      acids
    default: 20
    inputBinding:
      position: 103
      prefix: --mincluster
  - id: minmatch
    type:
      - 'null'
      - int
    doc: Set the minimum length of a single match, measured in amino acids
    default: 6
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
    inputBinding:
      position: 103
      prefix: --mumreference
  - id: no_delta
    type:
      - 'null'
      - boolean
    doc: Toggle the creation of the delta file
    inputBinding:
      position: 103
      prefix: --no-delta
  - id: no_extend
    type:
      - 'null'
      - boolean
    doc: Toggle the cluster extension step
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
    inputBinding:
      position: 103
      prefix: --no-optimize
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_promer.out
