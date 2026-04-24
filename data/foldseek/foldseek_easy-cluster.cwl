cwlVersion: v1.2
class: CommandLineTool
baseCommand: foldseek easy-cluster
label: foldseek_easy-cluster
doc: "By Martin Steinegger <martin.steinegger@snu.ac.kr>\n\nTool homepage: https://github.com/steineggerlab/foldseek"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input PDB or mmCIF files
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Prefix for cluster output files
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
      - boolean
    doc: Add backtrace string (convert to alignments with mmseqs convertalis 
      module) [0]
    inputBinding:
      position: 104
      prefix: -a
  - id: adjust_kmer_len
    type:
      - 'null'
      - boolean
    doc: Adjust k-mer length based on specificity (only for nucleotides) [0]
    inputBinding:
      position: 104
      prefix: --adjust-kmer-len
  - id: alignment_mode
    type:
      - 'null'
      - int
    doc: "How to compute the alignment:\n                                  0: automatic\n\
      \                                  1: only score and end_pos\n             \
      \                     2: also start_pos and cov\n                          \
      \        3: also seq.id [0]"
    inputBinding:
      position: 104
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
      position: 104
      prefix: --alignment-output-mode
  - id: alignment_type
    type:
      - 'null'
      - int
    doc: "How to compute the alignment:\n                                  0: 3di
      alignment\n                                  1: TM alignment\n             \
      \                     2: 3Di+AA [2]"
    inputBinding:
      position: 104
      prefix: --alignment-type
  - id: alt_ali
    type:
      - 'null'
      - int
    doc: Show up to this many alternative alignments [0]
    inputBinding:
      position: 104
      prefix: --alt-ali
  - id: chain_name_mode
    type:
      - 'null'
      - int
    doc: "Add chain to name:\n                                  0: auto\n        \
      \                          1: always add\n                                 \
      \  [0]"
    inputBinding:
      position: 104
      prefix: --chain-name-mode
  - id: cluster_mode
    type:
      - 'null'
      - int
    doc: "0: Set-Cover (greedy)\n                                  1: Connected component
      (BLASTclust)\n                                  2,3: Greedy clustering by sequence
      length (CDHIT) [0]"
    inputBinding:
      position: 104
      prefix: --cluster-mode
  - id: cluster_reassign
    type:
      - 'null'
      - boolean
    doc: "Cascaded clustering can cluster sequence that do not fulfill the clustering
      criteria.\n                                  Cluster reassignment corrects these
      errors [0]"
    inputBinding:
      position: 104
      prefix: --cluster-reassign
  - id: cluster_steps
    type:
      - 'null'
      - int
    doc: Cascaded clustering steps from 1 to -s [3]
    inputBinding:
      position: 104
      prefix: --cluster-steps
  - id: cluster_weight_threshold
    type:
      - 'null'
      - float
    doc: Weight threshold used for cluster priorization [0.900]
    inputBinding:
      position: 104
      prefix: --cluster-weight-threshold
  - id: comp_bias_corr
    type:
      - 'null'
      - int
    doc: Correct for locally biased amino acid composition (range 0-1) [1]
    inputBinding:
      position: 104
      prefix: --comp-bias-corr
  - id: comp_bias_corr_scale
    type:
      - 'null'
      - float
    doc: Correct for locally biased amino acid composition (range 0-1) [1.000]
    inputBinding:
      position: 104
      prefix: --comp-bias-corr-scale
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: Write compressed output [0]
    inputBinding:
      position: 104
      prefix: --compressed
  - id: coord_store_mode
    type:
      - 'null'
      - int
    doc: "Coordinate storage mode: \n                                  1: C-alpha
      as float\n                                  2: C-alpha as difference (uint16_t)
      [2]"
    inputBinding:
      position: 104
      prefix: --coord-store-mode
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
      position: 104
      prefix: --cov-mode
  - id: coverage_fraction
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see 
      --cov-mode) [0.000]
    inputBinding:
      position: 104
      prefix: -c
  - id: db_extraction_mode
    type:
      - 'null'
      - int
    doc: 'createdb extraction mode: 0: chain 1: interface [0]'
    inputBinding:
      position: 104
      prefix: --db-extraction-mode
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]'
    inputBinding:
      position: 104
      prefix: --db-load-mode
  - id: diag_score
    type:
      - 'null'
      - boolean
    doc: Use ungapped diagonal scoring during prefilter [1]
    inputBinding:
      position: 104
      prefix: --diag-score
  - id: distance_threshold
    type:
      - 'null'
      - float
    doc: Residues with C-beta below this threshold will be part of interface 
      [8.000]
    inputBinding:
      position: 104
      prefix: --distance-threshold
  - id: e_value
    type:
      - 'null'
      - float
    doc: List matches below this E-value (range 0.0-inf) [1.000E+01]
    inputBinding:
      position: 104
      prefix: -e
  - id: exact_kmer_matching
    type:
      - 'null'
      - int
    doc: Extract only exact k-mers for matching (range 0-1) [0]
    inputBinding:
      position: 104
      prefix: --exact-kmer-matching
  - id: exact_tmscore
    type:
      - 'null'
      - boolean
    doc: turn on fast exact TMscore (slow), default is approximate [0]
    inputBinding:
      position: 104
      prefix: --exact-tmscore
  - id: file_exclude
    type:
      - 'null'
      - string
    doc: Exclude file names based on this regex [^$]
    inputBinding:
      position: 104
      prefix: --file-exclude
  - id: file_include
    type:
      - 'null'
      - string
    doc: Include file names based on this regex [.*]
    inputBinding:
      position: 104
      prefix: --file-include
  - id: filter_hits
    type:
      - 'null'
      - boolean
    doc: Filter hits by seq.id. and coverage [0]
    inputBinding:
      position: 104
      prefix: --filter-hits
  - id: force_reuse
    type:
      - 'null'
      - boolean
    doc: Reuse tmp filse in tmp/latest folder ignoring parameters and version 
      changes [0]
    inputBinding:
      position: 104
      prefix: --force-reuse
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: Gap extension cost [aa:1,nucl:1]
    inputBinding:
      position: 104
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - string
    doc: Gap open cost [aa:10,nucl:10]
    inputBinding:
      position: 104
      prefix: --gap-open
  - id: gpu
    type:
      - 'null'
      - int
    doc: Use GPU (CUDA) if possible [0]
    inputBinding:
      position: 104
      prefix: --gpu
  - id: hash_shift
    type:
      - 'null'
      - int
    doc: Shift k-mer hash initialization [67]
    inputBinding:
      position: 104
      prefix: --hash-shift
  - id: ignore_multi_kmer
    type:
      - 'null'
      - boolean
    doc: Skip k-mers occurring multiple times (>=2) [0]
    inputBinding:
      position: 104
      prefix: --ignore-multi-kmer
  - id: include_only_extendable
    type:
      - 'null'
      - boolean
    doc: Include only extendable [0]
    inputBinding:
      position: 104
      prefix: --include-only-extendable
  - id: input_format
    type:
      - 'null'
      - int
    doc: "Format of input structures:\n                                  0: Auto-detect
      by extension\n                                  1: PDB\n                   \
      \               2: mmCIF\n                                  3: mmJSON\n    \
      \                              4: ChemComp\n                               \
      \   5: Foldcomp [0]"
    inputBinding:
      position: 104
      prefix: --input-format
  - id: k_score
    type:
      - 'null'
      - string
    doc: k-mer threshold for generating similar k-mer lists 
      [seq:2147483647,prof:2147483647]
    inputBinding:
      position: 104
      prefix: --k-score
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'k-mer length (0: automatically set to optimum) [0]'
    inputBinding:
      position: 104
      prefix: -k
  - id: kmer_per_seq
    type:
      - 'null'
      - int
    doc: k-mers per sequence [21]
    inputBinding:
      position: 104
      prefix: --kmer-per-seq
  - id: kmer_per_seq_scale
    type:
      - 'null'
      - string
    doc: Scale k-mer per sequence based on sequence length as kmer-per-seq val +
      scale x seqlen [aa:0.000,nucl:0.200]
    inputBinding:
      position: 104
      prefix: --kmer-per-seq-scale
  - id: lddt_threshold
    type:
      - 'null'
      - float
    doc: accept alignments with a lddt > thr [0.0,1.0] [0.000]
    inputBinding:
      position: 104
      prefix: --lddt-threshold
  - id: local_tmp
    type:
      - 'null'
      - string
    doc: Path where some of the temporary files will be created []
    inputBinding:
      position: 104
      prefix: --local-tmp
  - id: mask
    type:
      - 'null'
      - int
    doc: 'Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking,
      1: with low complexity masking [0]'
    inputBinding:
      position: 104
      prefix: --mask
  - id: mask_bfactor_threshold
    type:
      - 'null'
      - float
    doc: mask residues for seeding if b-factor < thr [0,100] [0.000]
    inputBinding:
      position: 104
      prefix: --mask-bfactor-threshold
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: 'Lowercase letters will be excluded from k-mer search 0: include region,
      1: exclude region [1]'
    inputBinding:
      position: 104
      prefix: --mask-lower-case
  - id: mask_n_repeat
    type:
      - 'null'
      - int
    doc: Repeat letters that occure > threshold in a rwo [6]
    inputBinding:
      position: 104
      prefix: --mask-n-repeat
  - id: mask_prob
    type:
      - 'null'
      - float
    doc: Mask sequences is probablity is above threshold [1.000]
    inputBinding:
      position: 104
      prefix: --mask-prob
  - id: max_accept
    type:
      - 'null'
      - int
    doc: Maximum accepted alignments before alignment calculation for a query is
      stopped [2147483647]
    inputBinding:
      position: 104
      prefix: --max-accept
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum depth of breadth first search in connected component clustering
      [1000]
    inputBinding:
      position: 104
      prefix: --max-iterations
  - id: max_rejected
    type:
      - 'null'
      - int
    doc: Maximum rejected alignments before alignment calculation for a query is
      stopped [2147483647]
    inputBinding:
      position: 104
      prefix: --max-rejected
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length [65535]
    inputBinding:
      position: 104
      prefix: --max-seq-len
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: Maximum results per query sequence allowed to pass the prefilter 
      (affects sensitivity) [300]
    inputBinding:
      position: 104
      prefix: --max-seqs
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length (range 0-INT_MAX) [0]
    inputBinding:
      position: 104
      prefix: --min-aln-len
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity (for clustering) (range 
      0.0-1.0) [0.000]
    inputBinding:
      position: 104
      prefix: --min-seq-id
  - id: min_ungapped_score
    type:
      - 'null'
      - int
    doc: Accept only matches with ungapped alignment score above threshold [30]
    inputBinding:
      position: 104
      prefix: --min-ungapped-score
  - id: mpi_runner
    type:
      - 'null'
      - string
    doc: Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42")
      []
    inputBinding:
      position: 104
      prefix: --mpi-runner
  - id: prostt5_model
    type:
      - 'null'
      - string
    doc: Path to ProstT5 model []
    inputBinding:
      position: 104
      prefix: --prostt5-model
  - id: remove_tmp_files
    type:
      - 'null'
      - boolean
    doc: Delete temporary files [1]
    inputBinding:
      position: 104
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
      position: 104
      prefix: --rescore-mode
  - id: seed_sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file for k-mer generation [aa:3di.out,nucl:3di.out]
    inputBinding:
      position: 104
      prefix: --seed-sub-mat
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: 'Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [4.000]'
    inputBinding:
      position: 104
      prefix: -s
  - id: seq_id_mode
    type:
      - 'null'
      - int
    doc: '0: alignment length 1: shorter, 2: longer sequence [0]'
    inputBinding:
      position: 104
      prefix: --seq-id-mode
  - id: similarity_type
    type:
      - 'null'
      - int
    doc: 'Type of score used for clustering. 1: alignment score 2: sequence identity
      [2]'
    inputBinding:
      position: 104
      prefix: --similarity-type
  - id: single_step_clustering
    type:
      - 'null'
      - boolean
    doc: Switch from cascaded to simple clustering workflow [0]
    inputBinding:
      position: 104
      prefix: --single-step-clustering
  - id: sort_by_structure_bits
    type:
      - 'null'
      - int
    doc: sort by bits*sqrt(alnlddt*alntmscore) [1]
    inputBinding:
      position: 104
      prefix: --sort-by-structure-bits
  - id: sort_results
    type:
      - 'null'
      - int
    doc: 'Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming)
      [0]'
    inputBinding:
      position: 104
      prefix: --sort-results
  - id: spaced_kmer_mode
    type:
      - 'null'
      - int
    doc: '0: use consecutive positions in k-mers; 1: use spaced k-mers [1]'
    inputBinding:
      position: 104
      prefix: --spaced-kmer-mode
  - id: spaced_kmer_pattern
    type:
      - 'null'
      - string
    doc: User-specified spaced k-mer pattern []
    inputBinding:
      position: 104
      prefix: --spaced-kmer-pattern
  - id: split
    type:
      - 'null'
      - int
    doc: 'Split input into N equally distributed chunks. 0: set the best split automatically
      [0]'
    inputBinding:
      position: 104
      prefix: --split
  - id: split_memory_limit
    type:
      - 'null'
      - string
    doc: Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all 
      available system memory [0]
    inputBinding:
      position: 104
      prefix: --split-memory-limit
  - id: split_mode
    type:
      - 'null'
      - int
    doc: '0: split target db; 1: split query db; 2: auto, depending on main memory
      [2]'
    inputBinding:
      position: 104
      prefix: --split-mode
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file [aa:3di.out,nucl:3di.out]
    inputBinding:
      position: 104
      prefix: --sub-mat
  - id: target_search_mode
    type:
      - 'null'
      - int
    doc: 'target search mode (0: regular k-mer, 1: similar k-mer) [0]'
    inputBinding:
      position: 104
      prefix: --target-search-mode
  - id: taxon_list
    type:
      - 'null'
      - string
    doc: Taxonomy ID, possibly multiple values separated by ',' []
    inputBinding:
      position: 104
      prefix: --taxon-list
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default) [20]
    inputBinding:
      position: 104
      prefix: --threads
  - id: tmalign_fast
    type:
      - 'null'
      - boolean
    doc: turn on fast search in TM-align [1]
    inputBinding:
      position: 104
      prefix: --tmalign-fast
  - id: tmalign_hit_order
    type:
      - 'null'
      - int
    doc: 'order hits by 0: (qTM+tTM)/2, 1: qTM, 2: tTM, 3: min(qTM,tTM) 4: max(qTM,tTM)
      [0]'
    inputBinding:
      position: 104
      prefix: --tmalign-hit-order
  - id: tmscore_threshold
    type:
      - 'null'
      - float
    doc: accept alignments with a tmsore > thr [0.0,1.0] [0.000]
    inputBinding:
      position: 104
      prefix: --tmscore-threshold
  - id: tmscore_threshold_mode
    type:
      - 'null'
      - int
    doc: '0: alignment, 1: query 2: target length [0]'
    inputBinding:
      position: 104
      prefix: --tmscore-threshold-mode
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]'
    inputBinding:
      position: 104
      prefix: -v
  - id: weights
    type:
      - 'null'
      - string
    doc: Weights used for cluster priorization []
    inputBinding:
      position: 104
      prefix: --weights
  - id: write_lookup
    type:
      - 'null'
      - boolean
    doc: write .lookup file containing mapping from internal id, fasta id and 
      file number [1]
    inputBinding:
      position: 104
      prefix: --write-lookup
  - id: write_mapping
    type:
      - 'null'
      - boolean
    doc: write _mapping file containing mapping from internal id to taxonomic 
      identifier [0]
    inputBinding:
      position: 104
      prefix: --write-mapping
  - id: zdrop
    type:
      - 'null'
      - int
    doc: Maximal allowed difference between score values before alignment is 
      truncated  (nucleotide alignment only) [40]
    inputBinding:
      position: 104
      prefix: --zdrop
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
stdout: foldseek_easy-cluster.out
