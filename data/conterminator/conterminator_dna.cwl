cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - conterminator
  - dna
label: conterminator_dna
doc: "Searches for cross taxon contamination in DNA sequences\n\nTool homepage: https://github.com/martin-steinegger/conterminator"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA/FASTQ file
    inputBinding:
      position: 1
  - id: mapping_file
    type: File
    doc: Mapping file
    inputBinding:
      position: 2
  - id: tmp_dir
    type: Directory
    doc: Temporary directory
    inputBinding:
      position: 3
  - id: add_backtrace
    type:
      - 'null'
      - int
    doc: add backtrace string (convert to alignments with mmseqs convertalis utility)
    default: 1
    inputBinding:
      position: 104
      prefix: -a
  - id: add_self_matches
    type:
      - 'null'
      - boolean
    doc: artificially add entries of queries with themselves (for clustering)
    inputBinding:
      position: 104
      prefix: --add-self-matches
  - id: alignment_mode
    type:
      - 'null'
      - int
    doc: 'How to compute the alignment: 0: automatic; 1: only score and end_pos; 2:
      also start_pos and cov; 3: also seq.id; 4: only ungapped alignment'
    default: 3
    inputBinding:
      position: 104
      prefix: --alignment-mode
  - id: alph_size
    type:
      - 'null'
      - int
    doc: alphabet size (range 2-21)
    default: 21
    inputBinding:
      position: 104
      prefix: --alph-size
  - id: alt_ali
    type:
      - 'null'
      - int
    doc: Show up to this many alternative alignments
    default: 0
    inputBinding:
      position: 104
      prefix: --alt-ali
  - id: comp_bias_corr
    type:
      - 'null'
      - int
    doc: correct for locally biased amino acid composition (range 0-1)
    default: 0
    inputBinding:
      position: 104
      prefix: --comp-bias-corr
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: '0: coverage of query and target, 1: coverage of target, 2: coverage of query
      etc.'
    default: 0
    inputBinding:
      position: 104
      prefix: --cov-mode
  - id: coverage
    type:
      - 'null'
      - float
    doc: list matches above this fraction of aligned (covered) residues
    default: 0.0
    inputBinding:
      position: 104
      prefix: -c
  - id: diag_score
    type:
      - 'null'
      - boolean
    doc: Use ungapped diagonal scoring during prefilter
    inputBinding:
      position: 104
      prefix: --diag-score
  - id: disk_space_limit
    type:
      - 'null'
      - string
    doc: Set max disk space to use for reverse profile searches. E.g. 800B, 5K, 10M,
      1G.
    default: '0'
    inputBinding:
      position: 104
      prefix: --disk-space-limit
  - id: e_profile
    type:
      - 'null'
      - float
    doc: includes sequences matches with < e-value thr. into the profile (>=0.0)
    default: 0.001
    inputBinding:
      position: 104
      prefix: --e-profile
  - id: e_value
    type:
      - 'null'
      - float
    doc: list matches below this E-value (range 0.0-inf)
    default: 0.001
    inputBinding:
      position: 104
      prefix: -e
  - id: exact_kmer_matching
    type:
      - 'null'
      - int
    doc: only exact k-mer matching (range 0-1)
    default: 1
    inputBinding:
      position: 104
      prefix: --exact-kmer-matching
  - id: filter_msa
    type:
      - 'null'
      - int
    doc: 'filter msa: 0: do not filter, 1: filter'
    default: 1
    inputBinding:
      position: 104
      prefix: --filter-msa
  - id: force_reuse
    type:
      - 'null'
      - boolean
    doc: reuse tmp file in tmp/latest folder ignoring parameters and git version change
    inputBinding:
      position: 104
      prefix: --force-reuse
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: Gap extension cost
    default: 2
    inputBinding:
      position: 104
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - int
    doc: Gap open cost
    default: 5
    inputBinding:
      position: 104
      prefix: --gap-open
  - id: k_mer_size
    type:
      - 'null'
      - int
    doc: 'k-mer size in the range (0: set automatically to optimum)'
    default: 15
    inputBinding:
      position: 104
      prefix: -k
  - id: k_score
    type:
      - 'null'
      - int
    doc: K-mer threshold for generating similar k-mer lists
    default: 2147483647
    inputBinding:
      position: 104
      prefix: --k-score
  - id: local_tmp
    type:
      - 'null'
      - Directory
    doc: Path where some of the temporary files will be created
    inputBinding:
      position: 104
      prefix: --local-tmp
  - id: mask
    type:
      - 'null'
      - int
    doc: 'mask sequences in k-mer stage 0: w/o low complexity masking, 1: with low
      complexity masking'
    default: 0
    inputBinding:
      position: 104
      prefix: --mask
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: 'lowercase letters will be excluded from k-mer search 0: include region,
      1: exclude region'
    default: 0
    inputBinding:
      position: 104
      prefix: --mask-lower-case
  - id: mask_profile
    type:
      - 'null'
      - int
    doc: mask query sequence of profile using tantan [0,1]
    default: 1
    inputBinding:
      position: 104
      prefix: --mask-profile
  - id: max_accept
    type:
      - 'null'
      - int
    doc: maximum accepted alignments before alignment calculation for a query is stopped
    default: 2147483647
    inputBinding:
      position: 104
      prefix: --max-accept
  - id: max_rejected
    type:
      - 'null'
      - int
    doc: maximum rejected alignments before alignment calculation for a query is aborted
    default: 2147483647
    inputBinding:
      position: 104
      prefix: --max-rejected
  - id: max_seq_id_msa
    type:
      - 'null'
      - float
    doc: reduce redundancy of output MSA using max. pairwise sequence identity
    default: 0.9
    inputBinding:
      position: 104
      prefix: --max-seq-id
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: minimum alignment length (range 0-INT_MAX)
    default: 100
    inputBinding:
      position: 104
      prefix: --min-aln-len
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimum codon number in open reading frames
    default: 30
    inputBinding:
      position: 104
      prefix: --min-length
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: list matches above this sequence identity (for clustering) (range 0.0-1.0)
    default: 0.9
    inputBinding:
      position: 104
      prefix: --min-seq-id
  - id: min_ungapped_score
    type:
      - 'null'
      - int
    doc: accept only matches with ungapped alignment score above this threshold
    default: 25
    inputBinding:
      position: 104
      prefix: --min-ungapped-score
  - id: ncbi_tax_dump
    type:
      - 'null'
      - Directory
    doc: NCBI tax dump directory
    inputBinding:
      position: 104
      prefix: --ncbi-tax-dump
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: Search iterations
    default: 1
    inputBinding:
      position: 104
      prefix: --num-iterations
  - id: pca
    type:
      - 'null'
      - float
    doc: pseudo count admixture strength
    default: 1.0
    inputBinding:
      position: 104
      prefix: --pca
  - id: pcb
    type:
      - 'null'
      - float
    doc: 'pseudo counts: Neff at half of maximum admixture (range 0.0-inf)'
    default: 1.5
    inputBinding:
      position: 104
      prefix: --pcb
  - id: realign
    type:
      - 'null'
      - boolean
    doc: compute more conservative, shorter alignments (scores and E-values not changed)
    inputBinding:
      position: 104
      prefix: --realign
  - id: rescore_mode
    type:
      - 'null'
      - int
    doc: 'Rescore diagonal with: 0: Hamming distance, 1: local alignment, etc.'
    default: 2
    inputBinding:
      position: 104
      prefix: --rescore-mode
  - id: score_bias
    type:
      - 'null'
      - float
    doc: Score bias when computing the SW alignment (in bits)
    default: 0.0
    inputBinding:
      position: 104
      prefix: --score-bias
  - id: search_type
    type:
      - 'null'
      - int
    doc: 'search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated
      nucleotide alignment'
    default: 0
    inputBinding:
      position: 104
      prefix: --search-type
  - id: seed_sub_mat
    type:
      - 'null'
      - File
    doc: amino acid substitution matrix for kmer generation file
    inputBinding:
      position: 104
      prefix: --seed-sub-mat
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: 'sensitivity: 1.0 faster; 4.0 fast default; 7.5 sensitive (range 1.0-7.5)'
    default: 5.7
    inputBinding:
      position: 104
      prefix: -s
  - id: seq_id_mode
    type:
      - 'null'
      - int
    doc: '0: alignment length 1: shorter, 2: longer sequence'
    default: 0
    inputBinding:
      position: 104
      prefix: --seq-id-mode
  - id: slice_search
    type:
      - 'null'
      - boolean
    doc: For bigger profile DB, run iteratively the search by greedily swapping the
      search results.
    inputBinding:
      position: 104
      prefix: --slice-search
  - id: spaced_kmer_mode
    type:
      - 'null'
      - int
    doc: '0: use consecutive positions a k-mers; 1: use spaced k-mers'
    default: 1
    inputBinding:
      position: 104
      prefix: --spaced-kmer-mode
  - id: spaced_kmer_pattern
    type:
      - 'null'
      - string
    doc: User-specified spaced k-mer pattern
    inputBinding:
      position: 104
      prefix: --spaced-kmer-pattern
  - id: split
    type:
      - 'null'
      - int
    doc: Splits input sets into N equally distributed chunks.
    default: 0
    inputBinding:
      position: 104
      prefix: --split
  - id: split_mode
    type:
      - 'null'
      - int
    doc: '0: split target db; 1: split query db; 2: auto, depending on main memory'
    default: 2
    inputBinding:
      position: 104
      prefix: --split-mode
  - id: tax_mapping_file
    type:
      - 'null'
      - File
    doc: File to map sequence identifer to taxonomical identifier
    inputBinding:
      position: 104
      prefix: --tax-mapping-file
  - id: threads
    type:
      - 'null'
      - int
    doc: number of cores used for the computation
    default: 32
    inputBinding:
      position: 104
      prefix: --threads
  - id: translate
    type:
      - 'null'
      - int
    doc: translate ORF to amino acid
    default: 0
    inputBinding:
      position: 104
      prefix: --translate
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Genetic code translation table
    default: 1
    inputBinding:
      position: 104
      prefix: --translation-table
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'verbosity level: 0=nothing, 1: +errors, 2: +warnings, 3: +info'
    default: 3
    inputBinding:
      position: 104
      prefix: -v
  - id: wg
    type:
      - 'null'
      - boolean
    doc: use global sequence weighting for profile calculation
    inputBinding:
      position: 104
      prefix: --wg
  - id: wrapped_scoring
    type:
      - 'null'
      - boolean
    doc: Double the (nucleotide) query sequence during the scoring process to allow
      wrapped diagonal scoring around end and start
    inputBinding:
      position: 104
      prefix: --wrapped-scoring
outputs:
  - id: result
    type: File
    doc: Output result file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conterminator:1.c74b5--h9cf7dee_0
