cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spacedust
  - clustersearch
label: spacedust_clustersearch
doc: "By Ruoshi Zhang <ruoshi.zhang@mpinat.mpg.de> & Milot Mirdita <milot@mirdita.de>\n\
  \nTool homepage: https://github.com/soedinglab/spacedust"
inputs:
  - id: query_set_db
    type: File
    doc: Input query set database
    inputBinding:
      position: 1
  - id: target_set_db
    type: File
    doc: Input target set database
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
    inputBinding:
      position: 104
      prefix: -a
  - id: add_orf_stop
    type:
      - 'null'
      - boolean
    doc: Add stop codon '*' at complete start and end
    inputBinding:
      position: 104
      prefix: --add-orf-stop
  - id: add_self_matches
    type:
      - 'null'
      - boolean
    doc: Artificially add entries of queries with themselves (for clustering)
    inputBinding:
      position: 104
      prefix: --add-self-matches
  - id: aggregation_mode
    type:
      - 'null'
      - int
    doc: 'Combined P-values computed from 0: multi-hit, 1: minimum of all P-values,
      2: product-of-P-values, 3: truncated product'
    inputBinding:
      position: 104
      prefix: --aggregation-mode
  - id: alignment_mode
    type:
      - 'null'
      - int
    doc: 'How to compute the alignment: 0: automatic, 1: only score and end_pos, 2:
      also start_pos and cov, 3: also seq.id, 4: only ungapped alignment'
    inputBinding:
      position: 104
      prefix: --alignment-mode
  - id: alignment_output_mode
    type:
      - 'null'
      - int
    doc: 'How to compute the alignment: 0: automatic, 1: only score and end_pos, 2:
      also start_pos and cov, 3: also seq.id, 4: only ungapped alignment, 5: score
      only (output) cluster format'
    inputBinding:
      position: 104
      prefix: --alignment-output-mode
  - id: allow_deletion
    type:
      - 'null'
      - boolean
    doc: Allow deletions in a MSA
    inputBinding:
      position: 104
      prefix: --allow-deletion
  - id: alph_size
    type:
      - 'null'
      - string
    doc: Alphabet size (range 2-21)
    inputBinding:
      position: 104
      prefix: --alph-size
  - id: alpha
    type:
      - 'null'
      - float
    doc: Set alpha for combining p-values during aggregation
    inputBinding:
      position: 104
      prefix: --alpha
  - id: alt_ali
    type:
      - 'null'
      - int
    doc: Show up to this many alternative alignments
    inputBinding:
      position: 104
      prefix: --alt-ali
  - id: chain_alignments
    type:
      - 'null'
      - int
    doc: Chain overlapping alignments
    inputBinding:
      position: 104
      prefix: --chain-alignments
  - id: cluster_pval
    type:
      - 'null'
      - float
    doc: Clustering and Ordering P-value threshold for cluster match output
    inputBinding:
      position: 104
      prefix: --cluster-pval
  - id: cluster_size
    type:
      - 'null'
      - int
    doc: Minimum number of genes to define cluster
    inputBinding:
      position: 104
      prefix: --cluster-size
  - id: cluster_use_weight
    type:
      - 'null'
      - boolean
    doc: Use weighting factor to calculate cluster match score
    inputBinding:
      position: 104
      prefix: --cluster-use-weight
  - id: comp_bias_corr
    type:
      - 'null'
      - int
    doc: Correct for locally biased amino acid composition (range 0-1)
    inputBinding:
      position: 104
      prefix: --comp-bias-corr
  - id: comp_bias_corr_scale
    type:
      - 'null'
      - float
    doc: Correct for locally biased amino acid composition (range 0-1)
    inputBinding:
      position: 104
      prefix: --comp-bias-corr-scale
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
  - id: contig_end_mode
    type:
      - 'null'
      - int
    doc: 'Contig end can be 0: incomplete, 1: complete, 2: both'
    inputBinding:
      position: 104
      prefix: --contig-end-mode
  - id: contig_start_mode
    type:
      - 'null'
      - int
    doc: 'Contig start can be 0: incomplete, 1: complete, 2: both'
    inputBinding:
      position: 104
      prefix: --contig-start-mode
  - id: corr_score_weight
    type:
      - 'null'
      - float
    doc: Weight of backtrace correlation score that is added to the alignment 
      score
    inputBinding:
      position: 104
      prefix: --corr-score-weight
  - id: cov
    type:
      - 'null'
      - float
    doc: Filter output MSAs using min. fraction of query residues covered by 
      matched sequences [0.0,1.0]
    inputBinding:
      position: 104
      prefix: --cov
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: '0: coverage of query and target, 1: coverage of target, 2: coverage of query,
      3: target seq. length has to be at least x% of query length, 4: query seq. length
      has to be at least x% of target length, 5: short seq. needs to be at least x%
      of the other seq. length'
    inputBinding:
      position: 104
      prefix: --cov-mode
  - id: coverage_fraction
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see 
      --cov-mode)
    inputBinding:
      position: 104
      prefix: -c
  - id: create_lookup
    type:
      - 'null'
      - int
    doc: Create database lookup file (can be very large)
    inputBinding:
      position: 104
      prefix: --create-lookup
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch'
    inputBinding:
      position: 104
      prefix: --db-load-mode
  - id: db_output
    type:
      - 'null'
      - boolean
    doc: Return a result DB instead of a text file
    inputBinding:
      position: 104
      prefix: --db-output
  - id: diag_score
    type:
      - 'null'
      - boolean
    doc: Use ungapped diagonal scoring during prefilter
    inputBinding:
      position: 104
      prefix: --diag-score
  - id: diff
    type:
      - 'null'
      - int
    doc: Filter MSAs by selecting most diverse set of sequences, keeping at 
      least this many seqs in each MSA block of length 50
    inputBinding:
      position: 104
      prefix: --diff
  - id: disk_space_limit
    type:
      - 'null'
      - string
    doc: Set max disk space to use for reverse profile searches. E.g. 800B, 5K, 
      10M, 1G. Default (0) to all available disk space in the temp folder
    inputBinding:
      position: 104
      prefix: --disk-space-limit
  - id: e_profile
    type:
      - 'null'
      - double
    doc: Include sequences matches with < E-value thr. into the profile (>=0.0)
    inputBinding:
      position: 104
      prefix: --e-profile
  - id: evalue
    type:
      - 'null'
      - double
    doc: List matches below this E-value (range 0.0-inf)
    inputBinding:
      position: 104
      prefix: -e
  - id: exact_kmer_matching
    type:
      - 'null'
      - int
    doc: Extract only exact k-mers for matching (range 0-1)
    inputBinding:
      position: 104
      prefix: --exact-kmer-matching
  - id: exhaustive_search
    type:
      - 'null'
      - boolean
    doc: For bigger profile DB, run iteratively the search by greedily swapping 
      the search results
    inputBinding:
      position: 104
      prefix: --exhaustive-search
  - id: exhaustive_search_filter
    type:
      - 'null'
      - int
    doc: 'Filter result during search: 0: do not filter, 1: filter'
    inputBinding:
      position: 104
      prefix: --exhaustive-search-filter
  - id: filter_hits
    type:
      - 'null'
      - boolean
    doc: Filter hits by seq.id. and coverage
    inputBinding:
      position: 104
      prefix: --filter-hits
  - id: filter_min_enable
    type:
      - 'null'
      - int
    doc: Only filter MSAs with more than N sequences, 0 always filters
    inputBinding:
      position: 104
      prefix: --filter-min-enable
  - id: filter_msa
    type:
      - 'null'
      - int
    doc: 'Filter msa: 0: do not filter, 1: filter'
    inputBinding:
      position: 104
      prefix: --filter-msa
  - id: filter_self_match
    type:
      - 'null'
      - boolean
    doc: 'Remove hits between the same set. 0: do not filter, 1: filter'
    inputBinding:
      position: 104
      prefix: --filter-self-match
  - id: foldseek_path
    type:
      - 'null'
      - string
    doc: Path to Foldseek binary
    inputBinding:
      position: 104
      prefix: --foldseek-path
  - id: force_reuse
    type:
      - 'null'
      - boolean
    doc: Reuse tmp filse in tmp/latest folder ignoring parameters and version 
      changes
    inputBinding:
      position: 104
      prefix: --force-reuse
  - id: forward_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the forward strand to be extracted
    inputBinding:
      position: 104
      prefix: --forward-frames
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: Gap extension cost
    inputBinding:
      position: 104
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - string
    doc: Gap open cost
    inputBinding:
      position: 104
      prefix: --gap-open
  - id: gap_pc
    type:
      - 'null'
      - int
    doc: Pseudo count for calculating position-specific gap opening penalties
    inputBinding:
      position: 104
      prefix: --gap-pc
  - id: headers_split_mode
    type:
      - 'null'
      - int
    doc: 'Header split mode: 0: split position, 1: original header'
    inputBinding:
      position: 104
      prefix: --headers-split-mode
  - id: id_offset
    type:
      - 'null'
      - int
    doc: Numeric ids in index file are offset by this value
    inputBinding:
      position: 104
      prefix: --id-offset
  - id: k_score
    type:
      - 'null'
      - string
    doc: k-mer threshold for generating similar k-mer lists
    inputBinding:
      position: 104
      prefix: --k-score
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'k-mer length (0: automatically set to optimum)'
    inputBinding:
      position: 104
      prefix: -k
  - id: lca_search
    type:
      - 'null'
      - boolean
    doc: Efficient search for LCA candidates
    inputBinding:
      position: 104
      prefix: --lca-search
  - id: local_tmp
    type:
      - 'null'
      - string
    doc: Path where some of the temporary files will be created
    inputBinding:
      position: 104
      prefix: --local-tmp
  - id: mask
    type:
      - 'null'
      - int
    doc: 'Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low
      complexity masking'
    inputBinding:
      position: 104
      prefix: --mask
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: 'Lowercase letters will be excluded from k-mer search 0: include region,
      1: exclude region'
    inputBinding:
      position: 104
      prefix: --mask-lower-case
  - id: mask_prob
    type:
      - 'null'
      - float
    doc: Mask sequences is probablity is above threshold
    inputBinding:
      position: 104
      prefix: --mask-prob
  - id: mask_profile
    type:
      - 'null'
      - int
    doc: Mask query sequence of profile using tantan [0,1]
    inputBinding:
      position: 104
      prefix: --mask-profile
  - id: max_accept
    type:
      - 'null'
      - int
    doc: Maximum accepted alignments before alignment calculation for a query is
      stopped
    inputBinding:
      position: 104
      prefix: --max-accept
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: Maximum number of codons with gaps or unknown residues before an open 
      reading frame is rejected
    inputBinding:
      position: 104
      prefix: --max-gaps
  - id: max_gene_gap
    type:
      - 'null'
      - int
    doc: Maximum number of genes allowed between two clusters to merge
    inputBinding:
      position: 104
      prefix: --max-gene-gap
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum codon number in open reading frames
    inputBinding:
      position: 104
      prefix: --max-length
  - id: max_rejected
    type:
      - 'null'
      - int
    doc: Maximum rejected alignments before alignment calculation for a query is
      stopped
    inputBinding:
      position: 104
      prefix: --max-rejected
  - id: max_seq_id
    type:
      - 'null'
      - float
    doc: Reduce redundancy of output MSA using max. pairwise sequence identity 
      [0.0,1.0]
    inputBinding:
      position: 104
      prefix: --max-seq-id
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    inputBinding:
      position: 104
      prefix: --max-seq-len
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: Maximum results per query sequence allowed to pass the prefilter 
      (affects sensitivity)
    inputBinding:
      position: 104
      prefix: --max-seqs
  - id: merge_query
    type:
      - 'null'
      - int
    doc: Combine ORFs/split sequences to a single entry
    inputBinding:
      position: 104
      prefix: --merge-query
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length (range 0-INT_MAX)
    inputBinding:
      position: 104
      prefix: --min-aln-len
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum codon number in open reading frames
    inputBinding:
      position: 104
      prefix: --min-length
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity (for clustering) (range 
      0.0-1.0)
    inputBinding:
      position: 104
      prefix: --min-seq-id
  - id: min_ungapped_score
    type:
      - 'null'
      - int
    doc: Accept only matches with ungapped alignment score above threshold
    inputBinding:
      position: 104
      prefix: --min-ungapped-score
  - id: mpi_runner
    type:
      - 'null'
      - string
    doc: Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42")
    inputBinding:
      position: 104
      prefix: --mpi-runner
  - id: multihit_pval
    type:
      - 'null'
      - float
    doc: Multihit P-value threshold for cluster match output
    inputBinding:
      position: 104
      prefix: --multihit-pval
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: Number of iterative profile search iterations
    inputBinding:
      position: 104
      prefix: --num-iterations
  - id: orf_start_mode
    type:
      - 'null'
      - int
    doc: 'Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from
      last encountered start to stop (no start in the middle)'
    inputBinding:
      position: 104
      prefix: --orf-start-mode
  - id: pca
    type:
      - 'null'
      - boolean
    doc: Pseudo count admixture strength
    inputBinding:
      position: 104
      prefix: --pca
  - id: pcb
    type:
      - 'null'
      - boolean
    doc: 'Pseudo counts: Neff at half of maximum admixture (range 0.0-inf)'
    inputBinding:
      position: 104
      prefix: --pcb
  - id: profile_cluster_search
    type:
      - 'null'
      - boolean
    doc: Perform profile(target)-sequence searches in clustersearch
    inputBinding:
      position: 104
      prefix: --profile-cluster-search
  - id: pseudo_cnt_mode
    type:
      - 'null'
      - int
    doc: 'use 0: substitution-matrix or 1: context-specific pseudocounts'
    inputBinding:
      position: 104
      prefix: --pseudo-cnt-mode
  - id: qid
    type:
      - 'null'
      - string
    doc: "Reduce diversity of output MSAs using min.seq. identity with query sequences
      [0.0,1.0]\n                                  Alternatively, can be a list of
      multiple thresholds:\n                                  E.g.: 0.15,0.30,0.50
      to defines filter buckets of ]0.15-0.30] and ]0.30-0.50]"
    inputBinding:
      position: 104
      prefix: --qid
  - id: qsc
    type:
      - 'null'
      - float
    doc: Reduce diversity of output MSAs using min. score per aligned residue 
      with query sequences [-50.0,100.0]
    inputBinding:
      position: 104
      prefix: --qsc
  - id: realign
    type:
      - 'null'
      - boolean
    doc: Compute more conservative, shorter alignments (scores and E-values not 
      changed)
    inputBinding:
      position: 104
      prefix: --realign
  - id: realign_max_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of results to return in realignment
    inputBinding:
      position: 104
      prefix: --realign-max-seqs
  - id: realign_score_bias
    type:
      - 'null'
      - float
    doc: Additional bias when computing realignment
    inputBinding:
      position: 104
      prefix: --realign-score-bias
  - id: remove_tmp_files
    type:
      - 'null'
      - boolean
    doc: Delete temporary files
    inputBinding:
      position: 104
      prefix: --remove-tmp-files
  - id: rescore_mode
    type:
      - 'null'
      - int
    doc: 'Rescore diagonals with: 0: Hamming distance, 1: local alignment (score only),
      2: local alignment, 3: global alignment, 4: longest alignment fulfilling window
      quality criterion'
    inputBinding:
      position: 104
      prefix: --rescore-mode
  - id: reverse_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the reverse strand to be extracted
    inputBinding:
      position: 104
      prefix: --reverse-frames
  - id: score_bias
    type:
      - 'null'
      - float
    doc: Score bias when computing SW alignment (in bits)
    inputBinding:
      position: 104
      prefix: --score-bias
  - id: search_mode
    type:
      - 'null'
      - int
    doc: '0: sequence search with MMseqs2, 1: structure comparison with Foldseek,
      2: Foldseek + ProstT5'
    inputBinding:
      position: 104
      prefix: --search-mode
  - id: search_type
    type:
      - 'null'
      - int
    doc: 'Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated
      nucleotide alignment'
    inputBinding:
      position: 104
      prefix: --search-type
  - id: seed_sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file for k-mer generation
    inputBinding:
      position: 104
      prefix: --seed-sub-mat
  - id: sens_steps
    type:
      - 'null'
      - int
    doc: Number of search steps performed from --start-sens to -s
    inputBinding:
      position: 104
      prefix: --sens-steps
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: 'Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive'
    inputBinding:
      position: 104
      prefix: -s
  - id: seq_id_mode
    type:
      - 'null'
      - int
    doc: '0: alignment length 1: shorter, 2: longer sequence'
    inputBinding:
      position: 104
      prefix: --seq-id-mode
  - id: sequence_overlap
    type:
      - 'null'
      - int
    doc: Overlap between sequences
    inputBinding:
      position: 104
      prefix: --sequence-overlap
  - id: sequence_split_mode
    type:
      - 'null'
      - int
    doc: 'Sequence split mode 0: copy data, 1: soft link data and write new index'
    inputBinding:
      position: 104
      prefix: --sequence-split-mode
  - id: simple_best_hit
    type:
      - 'null'
      - boolean
    doc: Update the p-value by a single best hit, or by best and second best 
      hits
    inputBinding:
      position: 104
      prefix: --simple-best-hit
  - id: sort_results
    type:
      - 'null'
      - int
    doc: 'Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming)'
    inputBinding:
      position: 104
      prefix: --sort-results
  - id: spaced_kmer_mode
    type:
      - 'null'
      - int
    doc: '0: use consecutive positions in k-mers; 1: use spaced k-mers'
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
    doc: 'Split input into N equally distributed chunks. 0: set the best split automatically'
    inputBinding:
      position: 104
      prefix: --split
  - id: split_memory_limit
    type:
      - 'null'
      - string
    doc: Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all 
      available system memory
    inputBinding:
      position: 104
      prefix: --split-memory-limit
  - id: split_mode
    type:
      - 'null'
      - int
    doc: '0: split target db; 1: split query db; 2: auto, depending on main memory'
    inputBinding:
      position: 104
      prefix: --split-mode
  - id: start_sens
    type:
      - 'null'
      - float
    doc: Start sensitivity
    inputBinding:
      position: 104
      prefix: --start-sens
  - id: strand
    type:
      - 'null'
      - int
    doc: 'Strand selection only works for DNA/DNA search 0: reverse, 1: forward, 2:
      both'
    inputBinding:
      position: 104
      prefix: --strand
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    inputBinding:
      position: 104
      prefix: --sub-mat
  - id: suboptimal_hits
    type:
      - 'null'
      - int
    doc: 'Include sub-optimal hits of query sequence up to a factor of its E-value.
      0: only include one best hit'
    inputBinding:
      position: 104
      prefix: --suboptimal-hits
  - id: taxon_list
    type:
      - 'null'
      - string
    doc: Taxonomy ID, possibly multiple values separated by ','
    inputBinding:
      position: 104
      prefix: --taxon-list
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: translate
    type:
      - 'null'
      - int
    doc: Translate ORF to amino acid
    inputBinding:
      position: 104
      prefix: --translate
  - id: translation_table
    type:
      - 'null'
      - int
    doc: "1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL,
      5) INVERT_MITOCHONDRIAL, 6) CILIATE\n                                  9) FLATWORM_MITOCHONDRIAL,
      10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14)
      ALT_FLATWORM_MITOCHONDRIAL\n                                  15) BLEPHARISMA,
      16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL\n\
      \                                  23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL,
      25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA\n   \
      \                                29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA"
    inputBinding:
      position: 104
      prefix: --translation-table
  - id: use_all_table_starts
    type:
      - 'null'
      - boolean
    doc: Use all alternatives for a start codon in the genetic table, if false -
      only ATG (AUG)
    inputBinding:
      position: 104
      prefix: --use-all-table-starts
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
  - id: wg
    type:
      - 'null'
      - boolean
    doc: Use global sequence weighting for profile calculation
    inputBinding:
      position: 104
      prefix: --wg
  - id: wrapped_scoring
    type:
      - 'null'
      - boolean
    doc: Double the (nucleotide) query sequence during the scoring process to 
      allow wrapped diagonal scoring around end and start
    inputBinding:
      position: 104
      prefix: --wrapped-scoring
  - id: zdrop
    type:
      - 'null'
      - int
    doc: Maximal allowed difference between score values before alignment is 
      truncated  (nucleotide alignment only)
    inputBinding:
      position: 104
      prefix: --zdrop
outputs:
  - id: output_tsv
    type: File
    doc: Output file in TSV format
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacedust:2.e56c505--hd6d6fdc_0
