cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - blastx
label: diamond_blastx
doc: DIAMOND is a sequence aligner for protein and translated DNA searches, 
  designed for high performance analysis of big sequence data.
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: db
    type: File
    doc: database file
    inputBinding:
      position: 101
      prefix: --db
  - id: out
    type: string
    doc: output file
    inputBinding:
      position: 101
      prefix: --out
  - id: header
    type:
      - 'null'
      - string
    doc: Use header lines in tabular output format (0/simple/verbose).
    inputBinding:
      position: 101
      prefix: --header
  - id: comp_based_stats
    type:
      - 'null'
      - int
    doc: composition based statistics mode (0-4)
    inputBinding:
      position: 101
      prefix: --comp-based-stats
  - id: masking
    type:
      - 'null'
      - string
    doc: masking algorithm (none, seg, tantan=default)
    inputBinding:
      position: 101
      prefix: --masking
  - id: soft_masking
    type:
      - 'null'
      - string
    doc: soft masking (none=default, seg, tantan)
    inputBinding:
      position: 101
      prefix: --soft-masking
  - id: gapopen
    type:
      - 'null'
      - int
    doc: gap open penalty
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: gapextend
    type:
      - 'null'
      - int
    doc: gap extension penalty
    inputBinding:
      position: 101
      prefix: --gapextend
  - id: matrix
    type:
      - 'null'
      - string
    doc: score matrix for protein alignment
    inputBinding:
      position: 101
      prefix: --matrix
  - id: custom_matrix
    type:
      - 'null'
      - File
    doc: file containing custom scoring matrix
    inputBinding:
      position: 101
      prefix: --custom-matrix
  - id: evalue
    type:
      - 'null'
      - float
    doc: maximum e-value to report alignments
    inputBinding:
      position: 101
      prefix: --evalue
  - id: motif_masking
    type:
      - 'null'
      - int
    doc: softmask abundant motifs (0/1)
    inputBinding:
      position: 101
      prefix: --motif-masking
  - id: approx_id
    type:
      - 'null'
      - float
    doc: minimum approx. identity% to report an alignment/to cluster sequences
    inputBinding:
      position: 101
      prefix: --approx-id
  - id: ext
    type:
      - 'null'
      - string
    doc: Extension mode (banded-fast/banded-slow/full)
    inputBinding:
      position: 101
      prefix: --ext
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: maximum number of target sequences to report alignments for
    inputBinding:
      position: 101
      prefix: --max-target-seqs
  - id: top
    type:
      - 'null'
      - float
    doc: report alignments within this percentage range of top alignment score 
      (overrides --max-target-seqs)
    inputBinding:
      position: 101
      prefix: --top
  - id: faster
    type:
      - 'null'
      - boolean
    doc: enable faster mode
    inputBinding:
      position: 101
      prefix: --faster
  - id: fast
    type:
      - 'null'
      - boolean
    doc: enable fast mode
    inputBinding:
      position: 101
      prefix: --fast
  - id: mid_sensitive
    type:
      - 'null'
      - boolean
    doc: enable mid-sensitive mode
    inputBinding:
      position: 101
      prefix: --mid-sensitive
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: enable sensitive mode
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: more_sensitive
    type:
      - 'null'
      - boolean
    doc: enable more sensitive mode
    inputBinding:
      position: 101
      prefix: --more-sensitive
  - id: very_sensitive
    type:
      - 'null'
      - boolean
    doc: enable very sensitive mode
    inputBinding:
      position: 101
      prefix: --very-sensitive
  - id: ultra_sensitive
    type:
      - 'null'
      - boolean
    doc: enable ultra sensitive mode
    inputBinding:
      position: 101
      prefix: --ultra-sensitive
  - id: query
    type:
      - 'null'
      - File
    doc: input query file
    inputBinding:
      position: 101
      prefix: --query
  - id: strand
    type:
      - 'null'
      - string
    doc: query strands to search (both/minus/plus)
    inputBinding:
      position: 101
      prefix: --strand
  - id: un
    type: string
    doc: file for unaligned queries
    inputBinding:
      position: 101
      prefix: --un
  - id: al
    type: string
    doc: file or aligned queries
    inputBinding:
      position: 101
      prefix: --al
  - id: unfmt
    type:
      - 'null'
      - string
    doc: format of unaligned query file (fasta/fastq)
    inputBinding:
      position: 101
      prefix: --unfmt
  - id: alfmt
    type:
      - 'null'
      - string
    doc: format of aligned query file (fasta/fastq)
    inputBinding:
      position: 101
      prefix: --alfmt
  - id: unal
    type:
      - 'null'
      - int
    doc: report unaligned queries (0=no, 1=yes)
    inputBinding:
      position: 101
      prefix: --unal
  - id: max_hsps
    type:
      - 'null'
      - int
    doc: maximum number of HSPs per target sequence to report for each query
    inputBinding:
      position: 101
      prefix: --max-hsps
  - id: range_culling
    type:
      - 'null'
      - boolean
    doc: restrict hit culling to overlapping query ranges
    inputBinding:
      position: 101
      prefix: --range-culling
  - id: compress
    type:
      - 'null'
      - int
    doc: compression for output files (0=none, 1=gzip, zstd)
    inputBinding:
      position: 101
      prefix: --compress
  - id: min_score
    type:
      - 'null'
      - float
    doc: minimum bit score to report alignments (overrides e-value setting)
    inputBinding:
      position: 101
      prefix: --min-score
  - id: id
    type:
      - 'null'
      - float
    doc: minimum identity% to report an alignment
    inputBinding:
      position: 101
      prefix: --id
  - id: query_cover
    type:
      - 'null'
      - float
    doc: minimum query cover% to report an alignment
    inputBinding:
      position: 101
      prefix: --query-cover
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
  - id: iterate
    type:
      - 'null'
      - boolean
    doc: iterated search with increasing sensitivity
    inputBinding:
      position: 101
      prefix: --iterate
  - id: block_size
    type:
      - 'null'
      - float
    doc: sequence block size in billions of letters
    inputBinding:
      position: 101
      prefix: --block-size
  - id: index_chunks
    type:
      - 'null'
      - int
    doc: number of chunks for index processing
    inputBinding:
      position: 101
      prefix: --index-chunks
  - id: frameshift
    type:
      - 'null'
      - int
    doc: frame shift penalty (default=disabled)
    inputBinding:
      position: 101
      prefix: --frameshift
  - id: query_gencode
    type:
      - 'null'
      - int
    doc: genetic code to use to translate query
    inputBinding:
      position: 101
      prefix: --query-gencode
  - id: no_self_hits
    type:
      - 'null'
      - boolean
    doc: suppress reporting of identical self hits
    inputBinding:
      position: 101
      prefix: --no-self-hits
  - id: taxonlist
    type:
      - 'null'
      - string
    doc: restrict search to list of taxon ids (comma-separated)
    inputBinding:
      position: 101
      prefix: --taxonlist
  - id: taxon_exclude
    type:
      - 'null'
      - string
    doc: exclude list of taxon ids (comma-separated)
    inputBinding:
      position: 101
      prefix: --taxon-exclude
  - id: seqidlist
    type:
      - 'null'
      - File
    doc: filter the database by list of accessions
    inputBinding:
      position: 101
      prefix: --seqidlist
  - id: outfmt
    type:
      - 'null'
      - type: array
        items: string
    doc: output format and optional space-separated list of keywords
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: parallel_tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files used by multiprocessing
    inputBinding:
      position: 101
      prefix: --parallel-tmpdir
  - id: min_orf
    type:
      - 'null'
      - int
    doc: ignore translated sequences without an open reading frame of at least 
      this length
    inputBinding:
      position: 101
      prefix: --min-orf
  - id: min_query_len
    type:
      - 'null'
      - int
    doc: filter query sequences shorter than this length
    inputBinding:
      position: 101
      prefix: --min-query-len
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
  - id: output_un
    type:
      - 'null'
      - File
    doc: file for unaligned queries
    outputBinding:
      glob: $(inputs.un)
  - id: output_al
    type:
      - 'null'
      - File
    doc: file or aligned queries
    outputBinding:
      glob: $(inputs.al)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
s:url: https://github.com/bbuchfink/diamond
$namespaces:
  s: https://schema.org/
