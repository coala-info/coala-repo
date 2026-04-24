cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spacedust
  - clusterdb
label: spacedust_clusterdb
doc: "By Ruoshi Zhang <ruoshi.zhang@mpinat.mpg.de> & Milot Mirdita <milot@mirdita.de>\n\
  \nTool homepage: https://github.com/soedinglab/spacedust"
inputs:
  - id: input_db
    type: File
    doc: inputDB
    inputBinding:
      position: 1
  - id: tmp_dir
    type: Directory
    doc: Temporary directory
    inputBinding:
      position: 2
  - id: add_backtrace
    type:
      - 'null'
      - boolean
    doc: Add backtrace string (convert to alignments with mmseqs convertalis 
      module) [0]
    inputBinding:
      position: 103
      prefix: -a
  - id: add_self_matches
    type:
      - 'null'
      - boolean
    doc: Artificially add entries of queries with themselves (for clustering) 
      [0]
    inputBinding:
      position: 103
      prefix: --add-self-matches
  - id: adjust_kmer_len
    type:
      - 'null'
      - boolean
    doc: Adjust k-mer length based on specificity (only for nucleotides) [0]
    inputBinding:
      position: 103
      prefix: --adjust-kmer-len
  - id: alignment_mode
    type:
      - 'null'
      - int
    doc: "How to compute the alignment:\n                                  0: automatic\n\
      \                                  1: only score and end_pos\n             \
      \                     2: also start_pos and cov\n                          \
      \        3: also seq.id\n                                  4: only ungapped
      alignment [0]"
    inputBinding:
      position: 103
      prefix: --alignment-mode
  - id: alignment_output_mode
    type:
      - 'null'
      - int
    doc: "How to compute the alignment:\n                                  0: automatic\n\
      \                                  1: only score and end_pos\n             \
      \                     2: also start_pos and cov\n                          \
      \        3: also seq.id\n                                  4: only ungapped
      alignment\n                                  5: score only (output) cluster
      format [0]"
    inputBinding:
      position: 103
      prefix: --alignment-output-mode
  - id: alph_size
    type:
      - 'null'
      - string
    doc: Alphabet size (range 2-21) [aa:21,nucl:5]
    inputBinding:
      position: 103
      prefix: --alph-size
  - id: alt_ali
    type:
      - 'null'
      - int
    doc: Show up to this many alternative alignments [0]
    inputBinding:
      position: 103
      prefix: --alt-ali
  - id: cluster_mode
    type:
      - 'null'
      - int
    doc: "0: Set-Cover (greedy)\n                                  1: Connected component
      (BLASTclust)\n                                  2,3: Greedy clustering by sequence
      length (CDHIT) [0]"
    inputBinding:
      position: 103
      prefix: --cluster-mode
  - id: cluster_reassign
    type:
      - 'null'
      - boolean
    doc: "Cascaded clustering can cluster sequence that do not fulfill the clustering
      criteria.\n                                  Cluster reassignment corrects these
      errors [0]"
    inputBinding:
      position: 103
      prefix: --cluster-reassign
  - id: cluster_steps
    type:
      - 'null'
      - int
    doc: Cascaded clustering steps from 1 to -s [3]
    inputBinding:
      position: 103
      prefix: --cluster-steps
  - id: cluster_weight_threshold
    type:
      - 'null'
      - float
    doc: Weight threshold used for cluster priorization [0.900]
    inputBinding:
      position: 103
      prefix: --cluster-weight-threshold
  - id: comp_bias_corr
    type:
      - 'null'
      - int
    doc: Correct for locally biased amino acid composition (range 0-1) [1]
    inputBinding:
      position: 103
      prefix: --comp-bias-corr
  - id: comp_bias_corr_scale
    type:
      - 'null'
      - float
    doc: Correct for locally biased amino acid composition (range 0-1) [1.000]
    inputBinding:
      position: 103
      prefix: --comp-bias-corr-scale
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output [0]
    inputBinding:
      position: 103
      prefix: --compressed
  - id: corr_score_weight
    type:
      - 'null'
      - float
    doc: Weight of backtrace correlation score that is added to the alignment 
      score [0.000]
    inputBinding:
      position: 103
      prefix: --corr-score-weight
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: "0: coverage of query and target\n                                  1: coverage
      of target\n                                  2: coverage of query\n        \
      \                          3: target seq. length has to be at least x% of query
      length\n                                  4: query seq. length has to be at
      least x% of target length\n                                  5: short seq. needs
      to be at least x% of the other seq. length [0]"
    inputBinding:
      position: 103
      prefix: --cov-mode
  - id: coverage_fraction
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see 
      --cov-mode) [0.800]
    inputBinding:
      position: 103
      prefix: -c
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]'
    inputBinding:
      position: 103
      prefix: --db-load-mode
  - id: diag_score
    type:
      - 'null'
      - boolean
    doc: Use ungapped diagonal scoring during prefilter [1]
    inputBinding:
      position: 103
      prefix: --diag-score
  - id: evalue
    type:
      - 'null'
      - float
    doc: List matches below this E-value (range 0.0-inf) [1.000E-03]
    inputBinding:
      position: 103
      prefix: -e
  - id: exact_kmer_matching
    type:
      - 'null'
      - int
    doc: Extract only exact k-mers for matching (range 0-1) [0]
    inputBinding:
      position: 103
      prefix: --exact-kmer-matching
  - id: filter_hits
    type:
      - 'null'
      - boolean
    doc: Filter hits by seq.id. and coverage [0]
    inputBinding:
      position: 103
      prefix: --filter-hits
  - id: foldseek_path
    type:
      - 'null'
      - string
    doc: Path to Foldseek binary [/usr/local/bin/foldseek]
    inputBinding:
      position: 103
      prefix: --foldseek-path
  - id: force_reuse
    type:
      - 'null'
      - boolean
    doc: Reuse tmp filse in tmp/latest folder ignoring parameters and version 
      changes [0]
    inputBinding:
      position: 103
      prefix: --force-reuse
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: Gap extension cost [aa:1,nucl:2]
    inputBinding:
      position: 103
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - string
    doc: Gap open cost [aa:11,nucl:5]
    inputBinding:
      position: 103
      prefix: --gap-open
  - id: hash_shift
    type:
      - 'null'
      - int
    doc: Shift k-mer hash initialization [67]
    inputBinding:
      position: 103
      prefix: --hash-shift
  - id: ignore_multi_kmer
    type:
      - 'null'
      - boolean
    doc: Skip k-mers occurring multiple times (>=2) [0]
    inputBinding:
      position: 103
      prefix: --ignore-multi-kmer
  - id: include_only_extendable
    type:
      - 'null'
      - boolean
    doc: Include only extendable [0]
    inputBinding:
      position: 103
      prefix: --include-only-extendable
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'k-mer length (0: automatically set to optimum) [0]'
    inputBinding:
      position: 103
      prefix: -k
  - id: kmer_per_seq
    type:
      - 'null'
      - int
    doc: k-mers per sequence [21]
    inputBinding:
      position: 103
      prefix: --kmer-per-seq
  - id: kmer_per_seq_scale
    type:
      - 'null'
      - string
    doc: Scale k-mer per sequence based on sequence length as kmer-per-seq val +
      scale x seqlen [aa:0.000,nucl:0.200]
    inputBinding:
      position: 103
      prefix: --kmer-per-seq-scale
  - id: kmer_score
    type:
      - 'null'
      - string
    doc: k-mer threshold for generating similar k-mer lists 
      [seq:2147483647,prof:2147483647]
    inputBinding:
      position: 103
      prefix: --k-score
  - id: local_tmp
    type:
      - 'null'
      - string
    doc: Path where some of the temporary files will be created []
    inputBinding:
      position: 103
      prefix: --local-tmp
  - id: mask
    type:
      - 'null'
      - int
    doc: 'Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low
      complexity masking [1]'
    inputBinding:
      position: 103
      prefix: --mask
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: 'Lowercase letters will be excluded from k-mer search 0: include region,
      1: exclude region [0]'
    inputBinding:
      position: 103
      prefix: --mask-lower-case
  - id: mask_prob
    type:
      - 'null'
      - float
    doc: Mask sequences is probablity is above threshold [0.900]
    inputBinding:
      position: 103
      prefix: --mask-prob
  - id: max_accept
    type:
      - 'null'
      - int
    doc: Maximum accepted alignments before alignment calculation for a query is
      stopped [2147483647]
    inputBinding:
      position: 103
      prefix: --max-accept
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum depth of breadth first search in connected component clustering
      [1000]
    inputBinding:
      position: 103
      prefix: --max-iterations
  - id: max_rejected
    type:
      - 'null'
      - int
    doc: Maximum rejected alignments before alignment calculation for a query is
      stopped [2147483647]
    inputBinding:
      position: 103
      prefix: --max-rejected
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length [65535]
    inputBinding:
      position: 103
      prefix: --max-seq-len
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: Maximum results per query sequence allowed to pass the prefilter 
      (affects sensitivity) [300]
    inputBinding:
      position: 103
      prefix: --max-seqs
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length (range 0-INT_MAX) [0]
    inputBinding:
      position: 103
      prefix: --min-aln-len
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity (for clustering) (range 
      0.0-1.0) [0.700]
    inputBinding:
      position: 103
      prefix: --min-seq-id
  - id: min_ungapped_score
    type:
      - 'null'
      - int
    doc: Accept only matches with ungapped alignment score above threshold
    inputBinding:
      position: 103
      prefix: --min-ungapped-score
  - id: mpi_runner
    type:
      - 'null'
      - string
    doc: Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42")
      []
    inputBinding:
      position: 103
      prefix: --mpi-runner
  - id: pca
    type:
      - 'null'
      - boolean
    doc: Pseudo count admixture strength []
    inputBinding:
      position: 103
      prefix: --pca
  - id: pcb
    type:
      - 'null'
      - boolean
    doc: 'Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []'
    inputBinding:
      position: 103
      prefix: --pcb
  - id: realign
    type:
      - 'null'
      - boolean
    doc: Compute more conservative, shorter alignments (scores and E-values not 
      changed) [0]
    inputBinding:
      position: 103
      prefix: --realign
  - id: realign_max_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of results to return in realignment [2147483647]
    inputBinding:
      position: 103
      prefix: --realign-max-seqs
  - id: realign_score_bias
    type:
      - 'null'
      - float
    doc: Additional bias when computing realignment [-0.200]
    inputBinding:
      position: 103
      prefix: --realign-score-bias
  - id: remove_tmp_files
    type:
      - 'null'
      - boolean
    doc: Delete temporary files [0]
    inputBinding:
      position: 103
      prefix: --remove-tmp-files
  - id: rescore_mode
    type:
      - 'null'
      - int
    doc: "Rescore diagonals with:\n                                  0: Hamming distance\n\
      \                                  1: local alignment (score only)\n       \
      \                           2: local alignment\n                           \
      \       3: global alignment\n                                  4: longest alignment
      fulfilling window quality criterion [0]"
    inputBinding:
      position: 103
      prefix: --rescore-mode
  - id: score_bias
    type:
      - 'null'
      - float
    doc: Score bias when computing SW alignment (in bits) [0.000]
    inputBinding:
      position: 103
      prefix: --score-bias
  - id: search_mode
    type:
      - 'null'
      - int
    doc: '0: sequence search with MMseqs2, 1: structure comparison with Foldseek,
      2: Foldseek + ProstT5 [0]'
    inputBinding:
      position: 103
      prefix: --search-mode
  - id: seed_sub_mat
    type:
      - 'null'
      - File
    doc: Substitution matrix file for k-mer generation 
      [aa:VTML80.out,nucl:nucleotide.out]
    inputBinding:
      position: 103
      prefix: --seed-sub-mat
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: 'Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [4.000]'
    inputBinding:
      position: 103
      prefix: -s
  - id: seq_id_mode
    type:
      - 'null'
      - int
    doc: '0: alignment length 1: shorter, 2: longer sequence [0]'
    inputBinding:
      position: 103
      prefix: --seq-id-mode
  - id: similarity_type
    type:
      - 'null'
      - int
    doc: 'Type of score used for clustering. 1: alignment score 2: sequence identity
      [2]'
    inputBinding:
      position: 103
      prefix: --similarity-type
  - id: single_step_clustering
    type:
      - 'null'
      - boolean
    doc: Switch from cascaded to simple clustering workflow [0]
    inputBinding:
      position: 103
      prefix: --single-step-clustering
  - id: sort_results
    type:
      - 'null'
      - int
    doc: 'Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming)
      [0]'
    inputBinding:
      position: 103
      prefix: --sort-results
  - id: spaced_kmer_mode
    type:
      - 'null'
      - int
    doc: '0: use consecutive positions in k-mers; 1: use spaced k-mers [1]'
    inputBinding:
      position: 103
      prefix: --spaced-kmer-mode
  - id: spaced_kmer_pattern
    type:
      - 'null'
      - string
    doc: User-specified spaced k-mer pattern []
    inputBinding:
      position: 103
      prefix: --spaced-kmer-pattern
  - id: split
    type:
      - 'null'
      - int
    doc: 'Split input into N equally distributed chunks. 0: set the best split automatically
      [0]'
    inputBinding:
      position: 103
      prefix: --split
  - id: split_memory_limit
    type:
      - 'null'
      - string
    doc: Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all 
      available system memory [0]
    inputBinding:
      position: 103
      prefix: --split-memory-limit
  - id: split_mode
    type:
      - 'null'
      - int
    doc: '0: split target db; 1: split query db; 2: auto, depending on main memory
      [2]'
    inputBinding:
      position: 103
      prefix: --split-mode
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
    inputBinding:
      position: 103
      prefix: --sub-mat
  - id: taxon_list
    type:
      - 'null'
      - string
    doc: Taxonomy ID, possibly multiple values separated by ',' []
    inputBinding:
      position: 103
      prefix: --taxon-list
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default) [20]
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]'
    inputBinding:
      position: 103
      prefix: -v
  - id: weights
    type:
      - 'null'
      - string
    doc: Weights used for cluster priorization []
    inputBinding:
      position: 103
      prefix: --weights
  - id: wrapped_scoring
    type:
      - 'null'
      - boolean
    doc: Double the (nucleotide) query sequence during the scoring process to 
      allow wrapped diagonal scoring around end and start [0]
    inputBinding:
      position: 103
      prefix: --wrapped-scoring
  - id: zdrop
    type:
      - 'null'
      - int
    doc: Maximal allowed difference between score values before alignment is 
      truncated  (nucleotide alignment only) [40]
    inputBinding:
      position: 103
      prefix: --zdrop
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacedust:2.e56c505--hd6d6fdc_0
stdout: spacedust_clusterdb.out
