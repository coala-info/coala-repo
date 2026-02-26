cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ac-diamond
  - align
label: ac-diamond_align
doc: "Align DNA query sequences against a protein reference database\n\nTool homepage:
  https://github.com/Maihj/AC-DIAMOND"
inputs:
  - id: band
    type:
      - 'null'
      - int
    doc: band for dynamic programming computation
    default: 0
    inputBinding:
      position: 101
      prefix: --band
  - id: compress
    type:
      - 'null'
      - int
    doc: compression for output files (0=none, 1=gzip)
    default: 0
    inputBinding:
      position: 101
      prefix: --compress
  - id: daa
    type:
      - 'null'
      - File
    doc: AC-DIAMOND alignment archive (DAA) file
    inputBinding:
      position: 101
      prefix: --daa
  - id: db
    type:
      - 'null'
      - File
    doc: database file
    inputBinding:
      position: 101
      prefix: --db
  - id: evalue
    type:
      - 'null'
      - float
    doc: maximum e-value to report alignments
    default: 0.001
    inputBinding:
      position: 101
      prefix: --evalue
  - id: fetch_size
    type:
      - 'null'
      - int
    doc: trace point fetch size
    default: 4096
    inputBinding:
      position: 101
      prefix: --fetch-size
  - id: gapextend
    type:
      - 'null'
      - int
    doc: gap extension penalty, -1=default (1 for protein)
    default: -1
    inputBinding:
      position: 101
      prefix: --gapextend
  - id: gapopen
    type:
      - 'null'
      - int
    doc: gap open penalty, -1=default (11 for protein)
    default: -1
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: gapped_xdrop
    type:
      - 'null'
      - int
    doc: xdrop for gapped alignment in bits
    default: 20
    inputBinding:
      position: 101
      prefix: --gapped-xdrop
  - id: hit_band
    type:
      - 'null'
      - int
    doc: band for hit verification
    default: 0
    inputBinding:
      position: 101
      prefix: --hit-band
  - id: hit_score
    type:
      - 'null'
      - int
    doc: minimum score to keep a tentative alignment
    default: 0
    inputBinding:
      position: 101
      prefix: --hit-score
  - id: id
    type:
      - 'null'
      - int
    doc: minimum identity% to report an alignment
    default: 0
    inputBinding:
      position: 101
      prefix: --id
  - id: index_mode
    type:
      - 'null'
      - int
    doc: index mode (1=10x1, 2=10x8)
    default: 0
    inputBinding:
      position: 101
      prefix: --index-mode
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: matrix
    type:
      - 'null'
      - string
    doc: score matrix for protein alignment
    default: blosum62
    inputBinding:
      position: 101
      prefix: --matrix
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: maximum number of target sequences to report alignments for
    default: 25
    inputBinding:
      position: 101
      prefix: --max-target-seqs
  - id: min_score
    type:
      - 'null'
      - int
    doc: minimum bit score to report alignments (overrides e-value setting)
    default: 0
    inputBinding:
      position: 101
      prefix: --min-score
  - id: query
    type:
      - 'null'
      - File
    doc: input query file
    inputBinding:
      position: 101
      prefix: --query
  - id: query_block_size
    type:
      - 'null'
      - float
    doc: query sequence block size in billions of letters
    default: 6
    inputBinding:
      position: 101
      prefix: --query-block-size
  - id: seg
    type:
      - 'null'
      - string
    doc: enable SEG masking of queries (yes/no)
    inputBinding:
      position: 101
      prefix: --seg
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: 'enable sensitive mode (default: fast)'
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: single_domain
    type:
      - 'null'
      - boolean
    doc: Discard secondary domains within one target sequence
    inputBinding:
      position: 101
      prefix: --single-domain
  - id: threads
    type:
      - 'null'
      - int
    doc: number of cpu threads
    default: 0
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    default: /dev/shm
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: top
    type:
      - 'null'
      - int
    doc: report alignments within this percentage range of top alignment score 
      (overrides --max-target-seqs)
    default: 100
    inputBinding:
      position: 101
      prefix: --top
  - id: ungapped_score
    type:
      - 'null'
      - int
    doc: minimum raw alignment score to continue local extension
    default: 0
    inputBinding:
      position: 101
      prefix: --ungapped-score
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: enable verbose out
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - int
    doc: window size for local hit search
    default: 0
    inputBinding:
      position: 101
      prefix: --window
  - id: xdrop
    type:
      - 'null'
      - int
    doc: xdrop for ungapped alignment
    default: 20
    inputBinding:
      position: 101
      prefix: --xdrop
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ac-diamond:1.0--boost1.64_0
stdout: ac-diamond_align.out
