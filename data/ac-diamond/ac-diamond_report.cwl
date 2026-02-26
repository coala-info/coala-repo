cwlVersion: v1.2
class: CommandLineTool
baseCommand: ac-diamond
label: ac-diamond_report
doc: "AC-DIAMOND: A tool for building databases, aligning DNA sequences against protein
  databases, and viewing alignment archives.\n\nTool homepage: https://github.com/Maihj/AC-DIAMOND"
inputs:
  - id: command
    type: string
    doc: Command to execute (makedb, align, or view)
    inputBinding:
      position: 1
  - id: band
    type:
      - 'null'
      - int
    doc: band for dynamic programming computation
    default: 0
    inputBinding:
      position: 102
      prefix: --band
  - id: block_size
    type:
      - 'null'
      - int
    doc: reference sequence block size in billions of letters
    default: 4
    inputBinding:
      position: 102
      prefix: --block-size
  - id: compress
    type:
      - 'null'
      - int
    doc: compression for output files (0=none, 1=gzip)
    default: 0
    inputBinding:
      position: 102
      prefix: --compress
  - id: daa
    type:
      - 'null'
      - File
    doc: AC-DIAMOND alignment archive (DAA) file
    inputBinding:
      position: 102
      prefix: --daa
  - id: db
    type:
      - 'null'
      - File
    doc: database file
    inputBinding:
      position: 102
      prefix: --db
  - id: evalue
    type:
      - 'null'
      - float
    doc: maximum e-value to report alignments
    default: 0.001
    inputBinding:
      position: 102
      prefix: --evalue
  - id: fetch_size
    type:
      - 'null'
      - int
    doc: trace point fetch size
    default: 4096
    inputBinding:
      position: 102
      prefix: --fetch-size
  - id: forwardonly
    type:
      - 'null'
      - boolean
    doc: only show alignments of forward strand
    inputBinding:
      position: 102
      prefix: --forwardonly
  - id: gapextend
    type:
      - 'null'
      - int
    doc: gap extension penalty, -1=default (1 for protein)
    default: -1
    inputBinding:
      position: 102
      prefix: --gapextend
  - id: gapopen
    type:
      - 'null'
      - int
    doc: gap open penalty, -1=default (11 for protein)
    default: -1
    inputBinding:
      position: 102
      prefix: --gapopen
  - id: gapped_xdrop
    type:
      - 'null'
      - float
    doc: xdrop for gapped alignment in bits
    default: 20
    inputBinding:
      position: 102
      prefix: --gapped-xdrop
  - id: hit_band
    type:
      - 'null'
      - int
    doc: band for hit verification
    default: 0
    inputBinding:
      position: 102
      prefix: --hit-band
  - id: hit_score
    type:
      - 'null'
      - float
    doc: minimum score to keep a tentative alignment
    default: 0
    inputBinding:
      position: 102
      prefix: --hit-score
  - id: id
    type:
      - 'null'
      - float
    doc: minimum identity% to report an alignment
    default: 0
    inputBinding:
      position: 102
      prefix: --id
  - id: in
    type:
      - 'null'
      - File
    doc: input reference file in FASTA format
    inputBinding:
      position: 102
      prefix: --in
  - id: index_mode
    type:
      - 'null'
      - int
    doc: index mode (1=10x1, 2=10x8)
    default: 0
    inputBinding:
      position: 102
      prefix: --index-mode
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 102
      prefix: --log
  - id: matrix
    type:
      - 'null'
      - string
    doc: score matrix for protein alignment
    default: blosum62
    inputBinding:
      position: 102
      prefix: --matrix
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: maximum number of target sequences to report alignments for
    default: 25
    inputBinding:
      position: 102
      prefix: --max-target-seqs
  - id: min_score
    type:
      - 'null'
      - float
    doc: minimum bit score to report alignments (overrides e-value setting)
    default: 0
    inputBinding:
      position: 102
      prefix: --min-score
  - id: outfmt
    type:
      - 'null'
      - string
    doc: output format (tab/sam)
    default: tab
    inputBinding:
      position: 102
      prefix: --outfmt
  - id: query
    type:
      - 'null'
      - File
    doc: input query file
    inputBinding:
      position: 102
      prefix: --query
  - id: query_block_size
    type:
      - 'null'
      - int
    doc: query sequence block size in billions of letters
    default: 6
    inputBinding:
      position: 102
      prefix: --query-block-size
  - id: seg
    type:
      - 'null'
      - string
    doc: enable SEG masking of queries (yes/no)
    inputBinding:
      position: 102
      prefix: --seg
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: enable building index for sensitive mode / enable sensitive mode
    inputBinding:
      position: 102
      prefix: --sensitive
  - id: single_domain
    type:
      - 'null'
      - boolean
    doc: Discard secondary domains within one target sequence
    inputBinding:
      position: 102
      prefix: --single-domain
  - id: threads
    type:
      - 'null'
      - int
    doc: number of cpu threads
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    default: /dev/shm
    inputBinding:
      position: 102
      prefix: --tmpdir
  - id: top
    type:
      - 'null'
      - int
    doc: report alignments within this percentage range of top alignment score 
      (overrides --max-target-seqs)
    default: 100
    inputBinding:
      position: 102
      prefix: --top
  - id: ungapped_score
    type:
      - 'null'
      - float
    doc: minimum raw alignment score to continue local extension
    default: 0
    inputBinding:
      position: 102
      prefix: --ungapped-score
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: enable verbose out
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - int
    doc: window size for local hit search
    default: 0
    inputBinding:
      position: 102
      prefix: --window
  - id: xdrop
    type:
      - 'null'
      - float
    doc: xdrop for ungapped alignment
    default: 20
    inputBinding:
      position: 102
      prefix: --xdrop
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ac-diamond:1.0--boost1.64_0
