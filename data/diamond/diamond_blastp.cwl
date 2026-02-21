cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - blastp
label: diamond_blastp
doc: "DIAMOND is a sequence aligner for protein and translated DNA searches, designed
  for high performance analysis of big sequence data.\n\nTool homepage: https://github.com/bbuchfink/diamond"
inputs:
  - id: alfmt
    type:
      - 'null'
      - string
    doc: format of aligned query file (fasta/fastq)
    inputBinding:
      position: 101
      prefix: --alfmt
  - id: approx_id
    type:
      - 'null'
      - float
    doc: minimum approx. identity% to report an alignment/to cluster sequences
    inputBinding:
      position: 101
      prefix: --approx-id
  - id: block_size
    type:
      - 'null'
      - float
    doc: sequence block size in billions of letters
    default: 2.0
    inputBinding:
      position: 101
      prefix: --block-size
  - id: comp_based_stats
    type:
      - 'null'
      - int
    doc: composition based statistics mode (0-4)
    inputBinding:
      position: 101
      prefix: --comp-based-stats
  - id: compress
    type:
      - 'null'
      - int
    doc: compression for output files (0=none, 1=gzip, zstd)
    inputBinding:
      position: 101
      prefix: --compress
  - id: custom_matrix
    type:
      - 'null'
      - File
    doc: file containing custom scoring matrix
    inputBinding:
      position: 101
      prefix: --custom-matrix
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
  - id: ext
    type:
      - 'null'
      - string
    doc: Extension mode (banded-fast/banded-slow/full)
    inputBinding:
      position: 101
      prefix: --ext
  - id: fast
    type:
      - 'null'
      - boolean
    doc: enable fast mode
    inputBinding:
      position: 101
      prefix: --fast
  - id: faster
    type:
      - 'null'
      - boolean
    doc: enable faster mode
    inputBinding:
      position: 101
      prefix: --faster
  - id: gapextend
    type:
      - 'null'
      - int
    doc: gap extension penalty
    inputBinding:
      position: 101
      prefix: --gapextend
  - id: gapopen
    type:
      - 'null'
      - int
    doc: gap open penalty
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: header
    type:
      - 'null'
      - string
    doc: Use header lines in tabular output format (0/simple/verbose).
    inputBinding:
      position: 101
      prefix: --header
  - id: id
    type:
      - 'null'
      - float
    doc: minimum identity% to report an alignment
    inputBinding:
      position: 101
      prefix: --id
  - id: index_chunks
    type:
      - 'null'
      - int
    doc: number of chunks for index processing
    default: 4
    inputBinding:
      position: 101
      prefix: --index-chunks
  - id: iterate
    type:
      - 'null'
      - boolean
    doc: iterated search with increasing sensitivity
    inputBinding:
      position: 101
      prefix: --iterate
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: masking
    type:
      - 'null'
      - string
    doc: masking algorithm (none, seg, tantan=default)
    inputBinding:
      position: 101
      prefix: --masking
  - id: matrix
    type:
      - 'null'
      - string
    doc: score matrix for protein alignment
    default: BLOSUM62
    inputBinding:
      position: 101
      prefix: --matrix
  - id: max_hsps
    type:
      - 'null'
      - int
    doc: maximum number of HSPs per target sequence to report for each query
    default: 1
    inputBinding:
      position: 101
      prefix: --max-hsps
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: maximum number of target sequences to report alignments for
    default: 25
    inputBinding:
      position: 101
      prefix: --max-target-seqs
  - id: mid_sensitive
    type:
      - 'null'
      - boolean
    doc: enable mid-sensitive mode
    inputBinding:
      position: 101
      prefix: --mid-sensitive
  - id: min_orf
    type:
      - 'null'
      - int
    doc: ignore translated sequences without an open reading frame of at least 
      this length
    inputBinding:
      position: 101
      prefix: --min-orf
  - id: min_score
    type:
      - 'null'
      - float
    doc: minimum bit score to report alignments (overrides e-value setting)
    inputBinding:
      position: 101
      prefix: --min-score
  - id: more_sensitive
    type:
      - 'null'
      - boolean
    doc: enable more sensitive mode
    inputBinding:
      position: 101
      prefix: --more-sensitive
  - id: motif_masking
    type:
      - 'null'
      - int
    doc: softmask abundant motifs (0/1)
    inputBinding:
      position: 101
      prefix: --motif-masking
  - id: no_self_hits
    type:
      - 'null'
      - boolean
    doc: suppress reporting of identical self hits
    inputBinding:
      position: 101
      prefix: --no-self-hits
  - id: outfmt
    type:
      - 'null'
      - type: array
        items: string
    doc: output format (0, 5, 6, 100, 101, 102, 103, 104) followed by optional 
      keywords
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: query
    type:
      - 'null'
      - File
    doc: input query file
    inputBinding:
      position: 101
      prefix: --query
  - id: query_cover
    type:
      - 'null'
      - float
    doc: minimum query cover% to report an alignment
    inputBinding:
      position: 101
      prefix: --query-cover
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: range_culling
    type:
      - 'null'
      - boolean
    doc: restrict hit culling to overlapping query ranges
    inputBinding:
      position: 101
      prefix: --range-culling
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: enable sensitive mode
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: seqidlist
    type:
      - 'null'
      - File
    doc: filter the database by list of accessions
    inputBinding:
      position: 101
      prefix: --seqidlist
  - id: shapes
    type:
      - 'null'
      - int
    doc: number of seed shapes (default=all available)
    inputBinding:
      position: 101
      prefix: --shapes
  - id: soft_masking
    type:
      - 'null'
      - string
    doc: soft masking (none=default, seg, tantan)
    inputBinding:
      position: 101
      prefix: --soft-masking
  - id: strand
    type:
      - 'null'
      - string
    doc: query strands to search (both/minus/plus)
    inputBinding:
      position: 101
      prefix: --strand
  - id: subject_cover
    type:
      - 'null'
      - float
    doc: minimum subject cover% to report an alignment
    inputBinding:
      position: 101
      prefix: --subject-cover
  - id: swipe
    type:
      - 'null'
      - boolean
    doc: exhaustive alignment against all database sequences
    inputBinding:
      position: 101
      prefix: --swipe
  - id: taxonlist
    type:
      - 'null'
      - string
    doc: restrict search to list of taxon ids (comma-separated)
    inputBinding:
      position: 101
      prefix: --taxonlist
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: top
    type:
      - 'null'
      - float
    doc: report alignments within this percentage range of top alignment score 
      (overrides --max-target-seqs)
    inputBinding:
      position: 101
      prefix: --top
  - id: ultra_sensitive
    type:
      - 'null'
      - boolean
    doc: enable ultra sensitive mode
    inputBinding:
      position: 101
      prefix: --ultra-sensitive
  - id: unal
    type:
      - 'null'
      - int
    doc: report unaligned queries (0=no, 1=yes)
    inputBinding:
      position: 101
      prefix: --unal
  - id: unfmt
    type:
      - 'null'
      - string
    doc: format of unaligned query file (fasta/fastq)
    inputBinding:
      position: 101
      prefix: --unfmt
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose console output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: very_sensitive
    type:
      - 'null'
      - boolean
    doc: enable very sensitive mode
    inputBinding:
      position: 101
      prefix: --very-sensitive
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
  - id: un
    type:
      - 'null'
      - File
    doc: file for unaligned queries
    outputBinding:
      glob: $(inputs.un)
  - id: al
    type:
      - 'null'
      - File
    doc: file or aligned queries
    outputBinding:
      glob: $(inputs.al)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
