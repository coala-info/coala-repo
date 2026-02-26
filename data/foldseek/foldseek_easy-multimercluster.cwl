cwlVersion: v1.2
class: CommandLineTool
baseCommand: foldseek easy-multimercluster
label: foldseek_easy-multimercluster
doc: "By Seongeun Kim <seamustard52@gmail.com> & Sooyoung Cha <ellen2g77@gmail.com>\n\
  \nTool homepage: https://github.com/steineggerlab/foldseek"
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
    doc: Prefix for output cluster files
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
      module)
    default: false
    inputBinding:
      position: 104
      prefix: -a
  - id: alignment_mode
    type:
      - 'null'
      - int
    doc: "How to compute the alignment:\n                                   0: automatic\n\
      \                                   1: only score and end_pos\n            \
      \                       2: also start_pos and cov\n                        \
      \           3: also seq.id"
    default: 0
    inputBinding:
      position: 104
      prefix: --alignment-mode
  - id: alignment_output_mode
    type:
      - 'null'
      - int
    doc: "How to compute the alignment:\n                                   0: automatic\n\
      \                                   1: only score and end_pos\n            \
      \                       2: also start_pos and cov\n                        \
      \           3: also seq.id\n                                   4: only ungapped
      alignment\n                                   5: score only (output) cluster
      format"
    default: 0
    inputBinding:
      position: 104
      prefix: --alignment-output-mode
  - id: alignment_type
    type:
      - 'null'
      - int
    doc: "How to compute the alignment:\n                                   0: 3di
      alignment\n                                   1: TM alignment\n            \
      \                       2: 3Di+AA"
    default: 2
    inputBinding:
      position: 104
      prefix: --alignment-type
  - id: alt_ali
    type:
      - 'null'
      - int
    doc: Show up to this many alternative alignments
    default: 0
    inputBinding:
      position: 104
      prefix: --alt-ali
  - id: chain_name_mode
    type:
      - 'null'
      - int
    doc: "Add chain to name:\n                                   0: auto\n       \
      \                            1: always add"
    default: 0
    inputBinding:
      position: 104
      prefix: --chain-name-mode
  - id: chain_tm_threshold
    type:
      - 'null'
      - float
    doc: accept alignments with a tmsore > thr [0.0,1.0]
    default: 0.0
    inputBinding:
      position: 104
      prefix: --chain-tm-threshold
  - id: cluster_mode
    type:
      - 'null'
      - int
    doc: "0: Set-Cover (greedy)\n                                   1: Connected component
      (BLASTclust)\n                                   2,3: Greedy clustering by sequence
      length (CDHIT)"
    default: 0
    inputBinding:
      position: 104
      prefix: --cluster-mode
  - id: cluster_search
    type:
      - 'null'
      - int
    doc: first find representative then align all cluster members
    default: 0
    inputBinding:
      position: 104
      prefix: --cluster-search
  - id: cluster_weight_threshold
    type:
      - 'null'
      - float
    doc: Weight threshold used for cluster priorization
    default: 0.9
    inputBinding:
      position: 104
      prefix: --cluster-weight-threshold
  - id: comp_bias_corr
    type:
      - 'null'
      - int
    doc: Correct for locally biased amino acid composition (range 0-1)
    default: 1
    inputBinding:
      position: 104
      prefix: --comp-bias-corr
  - id: comp_bias_corr_scale
    type:
      - 'null'
      - float
    doc: Correct for locally biased amino acid composition (range 0-1)
    default: 1.0
    inputBinding:
      position: 104
      prefix: --comp-bias-corr-scale
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    default: 0
    inputBinding:
      position: 104
      prefix: --compressed
  - id: coord_store_mode
    type:
      - 'null'
      - int
    doc: "Coordinate storage mode: \n                                   1: C-alpha
      as float\n                                   2: C-alpha as difference (uint16_t)"
    default: 2
    inputBinding:
      position: 104
      prefix: --coord-store-mode
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: "0: coverage of query and target\n                                   1: coverage
      of target\n                                   2: coverage of query\n       \
      \                            3: target seq. length has to be at least x% of
      query length\n                                   4: query seq. length has to
      be at least x% of target length\n                                   5: short
      seq. needs to be at least x% of the other seq. length"
    default: 0
    inputBinding:
      position: 104
      prefix: --cov-mode
  - id: coverage
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see 
      --cov-mode)
    default: 0.0
    inputBinding:
      position: 104
      prefix: -c
  - id: db_extraction_mode
    type:
      - 'null'
      - int
    doc: 'createdb extraction mode: 0: chain 1: interface'
    default: 0
    inputBinding:
      position: 104
      prefix: --db-extraction-mode
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch'
    default: 0
    inputBinding:
      position: 104
      prefix: --db-load-mode
  - id: diag_score
    type:
      - 'null'
      - boolean
    doc: Use ungapped diagonal scoring during prefilter
    default: true
    inputBinding:
      position: 104
      prefix: --diag-score
  - id: distance_threshold
    type:
      - 'null'
      - float
    doc: Residues with C-beta below this threshold will be part of interface
    default: 8.0
    inputBinding:
      position: 104
      prefix: --distance-threshold
  - id: evalue
    type:
      - 'null'
      - float
    doc: List matches below this E-value (range 0.0-inf)
    default: 10.0
    inputBinding:
      position: 104
      prefix: -e
  - id: exact_kmer_matching
    type:
      - 'null'
      - int
    doc: Extract only exact k-mers for matching (range 0-1)
    default: 0
    inputBinding:
      position: 104
      prefix: --exact-kmer-matching
  - id: exact_tmscore
    type:
      - 'null'
      - int
    doc: turn on fast exact TMscore (slow), default is approximate
    default: 0
    inputBinding:
      position: 104
      prefix: --exact-tmscore
  - id: exhaustive_search
    type:
      - 'null'
      - boolean
    doc: Turns on an exhaustive all vs all search by by passing the prefilter 
      step
    default: false
    inputBinding:
      position: 104
      prefix: --exhaustive-search
  - id: expand_multimer_evalue
    type:
      - 'null'
      - float
    doc: E-value threshold for multimer chain expansion (range 0.0-inf)
    default: 10000.0
    inputBinding:
      position: 104
      prefix: --expand-multimer-evalue
  - id: file_exclude
    type:
      - 'null'
      - string
    doc: Exclude file names based on this regex
    default: ^$
    inputBinding:
      position: 104
      prefix: --file-exclude
  - id: file_include
    type:
      - 'null'
      - string
    doc: Include file names based on this regex
    default: .*
    inputBinding:
      position: 104
      prefix: --file-include
  - id: force_reuse
    type:
      - 'null'
      - boolean
    doc: Reuse tmp filse in tmp/latest folder ignoring parameters and version 
      changes
    default: false
    inputBinding:
      position: 104
      prefix: --force-reuse
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: Gap extension cost
    default: aa:1,nucl:1
    inputBinding:
      position: 104
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - string
    doc: Gap open cost
    default: aa:10,nucl:10
    inputBinding:
      position: 104
      prefix: --gap-open
  - id: gpu
    type:
      - 'null'
      - int
    doc: Use GPU (CUDA) if possible
    default: 0
    inputBinding:
      position: 104
      prefix: --gpu
  - id: gpu_server
    type:
      - 'null'
      - int
    doc: Use GPU server
    default: 0
    inputBinding:
      position: 104
      prefix: --gpu-server
  - id: gpu_server_wait_timeout
    type:
      - 'null'
      - int
    doc: "Wait for GPU server for 0: don't wait -1: no wait limit: >0 this many seconds"
    default: 600
    inputBinding:
      position: 104
      prefix: --gpu-server-wait-timeout
  - id: input_format
    type:
      - 'null'
      - int
    doc: "Format of input structures:\n                                   0: Auto-detect
      by extension\n                                   1: PDB\n                  \
      \                 2: mmCIF\n                                   3: mmJSON\n \
      \                                  4: ChemComp\n                           \
      \        5: Foldcomp"
    default: 0
    inputBinding:
      position: 104
      prefix: --input-format
  - id: interface_lddt_threshold
    type:
      - 'null'
      - float
    doc: accept alignments with a lddt > thr [0.0,1.0]
    default: 0.0
    inputBinding:
      position: 104
      prefix: --interface-lddt-threshold
  - id: k_score
    type:
      - 'null'
      - string
    doc: k-mer threshold for generating similar k-mer lists
    default: seq:2147483647,prof:2147483647
    inputBinding:
      position: 104
      prefix: --k-score
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'k-mer length (0: automatically set to optimum)'
    default: 0
    inputBinding:
      position: 104
      prefix: -k
  - id: lddt_threshold
    type:
      - 'null'
      - float
    doc: accept alignments with a lddt > thr [0.0,1.0]
    default: 0.0
    inputBinding:
      position: 104
      prefix: --lddt-threshold
  - id: local_tmp
    type:
      - 'null'
      - string
    doc: Path where some of the temporary files will be created
    default: ''
    inputBinding:
      position: 104
      prefix: --local-tmp
  - id: mask
    type:
      - 'null'
      - int
    doc: 'Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking,
      1: with low complexity masking'
    default: 0
    inputBinding:
      position: 104
      prefix: --mask
  - id: mask_bfactor_threshold
    type:
      - 'null'
      - float
    doc: mask residues for seeding if b-factor < thr [0,100]
    default: 0.0
    inputBinding:
      position: 104
      prefix: --mask-bfactor-threshold
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: 'Lowercase letters will be excluded from k-mer search 0: include region,
      1: exclude region'
    default: 1
    inputBinding:
      position: 104
      prefix: --mask-lower-case
  - id: mask_n_repeat
    type:
      - 'null'
      - int
    doc: Repeat letters that occure > threshold in a rwo
    default: 6
    inputBinding:
      position: 104
      prefix: --mask-n-repeat
  - id: mask_prob
    type:
      - 'null'
      - float
    doc: Mask sequences is probablity is above threshold
    default: 1.0
    inputBinding:
      position: 104
      prefix: --mask-prob
  - id: max_accept
    type:
      - 'null'
      - int
    doc: Maximum accepted alignments before alignment calculation for a query is
      stopped
    default: 2147483647
    inputBinding:
      position: 104
      prefix: --max-accept
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum depth of breadth first search in connected component clustering
    default: 1000
    inputBinding:
      position: 104
      prefix: --max-iterations
  - id: max_rejected
    type:
      - 'null'
      - int
    doc: Maximum rejected alignments before alignment calculation for a query is
      stopped
    default: 2147483647
    inputBinding:
      position: 104
      prefix: --max-rejected
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    default: 65535
    inputBinding:
      position: 104
      prefix: --max-seq-len
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: Maximum results per query sequence allowed to pass the prefilter 
      (affects sensitivity)
    default: 300
    inputBinding:
      position: 104
      prefix: --max-seqs
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length (range 0-INT_MAX)
    default: 0
    inputBinding:
      position: 104
      prefix: --min-aln-len
  - id: min_assigned_chains_ratio
    type:
      - 'null'
      - float
    doc: Minimum ratio of assigned chains out of all query chains > thr 
      [0.0,1.0]
    default: 0.0
    inputBinding:
      position: 104
      prefix: --min-assigned-chains-ratio
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity (for clustering) (range 
      0.0-1.0)
    default: 0.0
    inputBinding:
      position: 104
      prefix: --min-seq-id
  - id: min_ungapped_score
    type:
      - 'null'
      - int
    doc: Accept only matches with ungapped alignment score above threshold
    default: 30
    inputBinding:
      position: 104
      prefix: --min-ungapped-score
  - id: monomer_include_mode
    type:
      - 'null'
      - int
    doc: 'Monomer Complex Inclusion 0: include monomers, 1: NOT include monomers'
    default: 0
    inputBinding:
      position: 104
      prefix: --monomer-include-mode
  - id: mpi_runner
    type:
      - 'null'
      - string
    doc: Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42")
    default: ''
    inputBinding:
      position: 104
      prefix: --mpi-runner
  - id: multimer_report_mode
    type:
      - 'null'
      - int
    doc: "Complex report mode:\n                                   0: No report\n\
      \                                   1: Write complex report"
    default: 1
    inputBinding:
      position: 104
      prefix: --multimer-report-mode
  - id: multimer_tm_threshold
    type:
      - 'null'
      - float
    doc: accept alignments with a tmsore > thr [0.0,1.0]
    default: 0.0
    inputBinding:
      position: 104
      prefix: --multimer-tm-threshold
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: Number of iterative profile search iterations
    default: 1
    inputBinding:
      position: 104
      prefix: --num-iterations
  - id: prefilter_mode
    type:
      - 'null'
      - int
    doc: 'prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter, 3: ungapped&gapped'
    default: 0
    inputBinding:
      position: 104
      prefix: --prefilter-mode
  - id: prostt5_model
    type:
      - 'null'
      - string
    doc: Path to ProstT5 model
    default: ''
    inputBinding:
      position: 104
      prefix: --prostt5-model
  - id: remove_tmp_files
    type:
      - 'null'
      - boolean
    doc: Delete temporary files
    default: true
    inputBinding:
      position: 104
      prefix: --remove-tmp-files
  - id: seed_sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file for k-mer generation
    default: aa:3di.out,nucl:3di.out
    inputBinding:
      position: 104
      prefix: --seed-sub-mat
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: 'Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive'
    default: 4.0
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
  - id: similarity_type
    type:
      - 'null'
      - int
    doc: 'Type of score used for clustering. 1: alignment score 2: sequence identity'
    default: 2
    inputBinding:
      position: 104
      prefix: --similarity-type
  - id: sort_by_structure_bits
    type:
      - 'null'
      - int
    doc: sort by bits*sqrt(alnlddt*alntmscore)
    default: 1
    inputBinding:
      position: 104
      prefix: --sort-by-structure-bits
  - id: spaced_kmer_mode
    type:
      - 'null'
      - int
    doc: '0: use consecutive positions in k-mers; 1: use spaced k-mers'
    default: 1
    inputBinding:
      position: 104
      prefix: --spaced-kmer-mode
  - id: spaced_kmer_pattern
    type:
      - 'null'
      - string
    doc: User-specified spaced k-mer pattern
    default: ''
    inputBinding:
      position: 104
      prefix: --spaced-kmer-pattern
  - id: split
    type:
      - 'null'
      - int
    doc: 'Split input into N equally distributed chunks. 0: set the best split automatically'
    default: 0
    inputBinding:
      position: 104
      prefix: --split
  - id: split_memory_limit
    type:
      - 'null'
      - string
    doc: Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all 
      available system memory
    default: '0'
    inputBinding:
      position: 104
      prefix: --split-memory-limit
  - id: split_mode
    type:
      - 'null'
      - int
    doc: '0: split target db; 1: split query db; 2: auto, depending on main memory'
    default: 2
    inputBinding:
      position: 104
      prefix: --split-mode
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    default: aa:3di.out,nucl:3di.out
    inputBinding:
      position: 104
      prefix: --sub-mat
  - id: target_search_mode
    type:
      - 'null'
      - int
    doc: 'target search mode (0: regular k-mer, 1: similar k-mer)'
    default: 0
    inputBinding:
      position: 104
      prefix: --target-search-mode
  - id: taxon_list
    type:
      - 'null'
      - string
    doc: Taxonomy ID, possibly multiple values separated by ','
    default: ''
    inputBinding:
      position: 104
      prefix: --taxon-list
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    default: 20
    inputBinding:
      position: 104
      prefix: --threads
  - id: tmalign_fast
    type:
      - 'null'
      - int
    doc: turn on fast search in TM-align
    default: 1
    inputBinding:
      position: 104
      prefix: --tmalign-fast
  - id: tmalign_hit_order
    type:
      - 'null'
      - int
    doc: 'order hits by 0: (qTM+tTM)/2, 1: qTM, 2: tTM, 3: min(qTM,tTM) 4: max(qTM,tTM)'
    default: 0
    inputBinding:
      position: 104
      prefix: --tmalign-hit-order
  - id: tmscore_threshold
    type:
      - 'null'
      - float
    doc: accept alignments with a tmsore > thr [0.0,1.0]
    default: 0.0
    inputBinding:
      position: 104
      prefix: --tmscore-threshold
  - id: tmscore_threshold_mode
    type:
      - 'null'
      - int
    doc: '0: alignment, 1: query 2: target length'
    default: 0
    inputBinding:
      position: 104
      prefix: --tmscore-threshold-mode
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    default: 3
    inputBinding:
      position: 104
      prefix: -v
  - id: weights
    type:
      - 'null'
      - string
    doc: Weights used for cluster priorization
    default: ''
    inputBinding:
      position: 104
      prefix: --weights
  - id: write_lookup
    type:
      - 'null'
      - int
    doc: write .lookup file containing mapping from internal id, fasta id and 
      file number
    default: 1
    inputBinding:
      position: 104
      prefix: --write-lookup
  - id: write_mapping
    type:
      - 'null'
      - int
    doc: write _mapping file containing mapping from internal id to taxonomic 
      identifier
    default: 0
    inputBinding:
      position: 104
      prefix: --write-mapping
  - id: zdrop
    type:
      - 'null'
      - int
    doc: Maximal allowed difference between score values before alignment is 
      truncated  (nucleotide alignment only)
    default: 40
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
stdout: foldseek_easy-multimercluster.out
