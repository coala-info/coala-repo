cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - search
label: mmseqs2_search
doc: 'Sensitive homology search of a query database against a target database; the result
  is an alignment database.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: query_db
    type: Directory
    doc: Query database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.query_db_name)
  - id: query_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: target_db
    type: Directory
    doc: Target database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.target_db_name)
  - id: target_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_alignment_db_name
    type: string
    doc: Name (prefix) of the output alignment database, written inside the output directory
    inputBinding:
      position: 3
      valueFrom: out_db/$(self)
  - id: tmp_dir
    type: string
    doc: Temporary directory (created by the tool)
    inputBinding:
      position: 4
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
  - id: add_self_matches
    type:
      - 'null'
      - int
    doc: Artificially add entries of queries with themselves (for clustering) (0 or 1)
    inputBinding:
      position: 104
      prefix: --add-self-matches
  - id: seed_sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file for k-mer generation
    inputBinding:
      position: 104
      prefix: --seed-sub-mat
  - id: s
    type:
      - 'null'
      - float
    doc: 'Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive'
    inputBinding:
      position: 104
      prefix: -s
  - id: k
    type:
      - 'null'
      - int
    doc: 'k-mer length (0: automatically set to optimum)'
    inputBinding:
      position: 104
      prefix: -k
  - id: target_search_mode
    type:
      - 'null'
      - int
    doc: 'target search mode (0: regular k-mer, 1: similar k-mer)'
    inputBinding:
      position: 104
      prefix: --target-search-mode
  - id: k_score
    type:
      - 'null'
      - string
    doc: k-mer threshold for generating similar k-mer lists
    inputBinding:
      position: 104
      prefix: --k-score
  - id: alph_size
    type:
      - 'null'
      - string
    doc: Alphabet size (range 2-21)
    inputBinding:
      position: 104
      prefix: --alph-size
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: Maximum results per query sequence allowed to pass the prefilter (affects sensitivity)
    inputBinding:
      position: 104
      prefix: --max-seqs
  - id: split
    type:
      - 'null'
      - int
    doc: 'Split input into N equally distributed chunks. 0: set the best split automatically'
    inputBinding:
      position: 104
      prefix: --split
  - id: split_mode
    type:
      - 'null'
      - int
    doc: '0: split target db; 1: split query db; 2: auto, depending on main memory'
    inputBinding:
      position: 104
      prefix: --split-mode
  - id: split_memory_limit
    type:
      - 'null'
      - string
    doc: Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system
      memory
    inputBinding:
      position: 104
      prefix: --split-memory-limit
  - id: diag_score
    type:
      - 'null'
      - int
    doc: Use ungapped diagonal scoring during prefilter (0 or 1)
    inputBinding:
      position: 104
      prefix: --diag-score
  - id: exact_kmer_matching
    type:
      - 'null'
      - int
    doc: Extract only exact k-mers for matching (range 0-1)
    inputBinding:
      position: 104
      prefix: --exact-kmer-matching
  - id: mask
    type:
      - 'null'
      - int
    doc: 'Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1:
      with low complexity masking'
    inputBinding:
      position: 104
      prefix: --mask
  - id: mask_prob
    type:
      - 'null'
      - float
    doc: Mask sequences is probablity is above threshold
    inputBinding:
      position: 104
      prefix: --mask-prob
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: 'Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude
      region'
    inputBinding:
      position: 104
      prefix: --mask-lower-case
  - id: mask_n_repeat
    type:
      - 'null'
      - int
    doc: Repeat letters that occure > threshold in a rwo
    inputBinding:
      position: 104
      prefix: --mask-n-repeat
  - id: min_ungapped_score
    type:
      - 'null'
      - int
    doc: Accept only matches with ungapped alignment score above threshold
    inputBinding:
      position: 104
      prefix: --min-ungapped-score
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
  - id: local_tmp
    type:
      - 'null'
      - string
    doc: Path where some of the temporary files will be created
    inputBinding:
      position: 104
      prefix: --local-tmp
  - id: disk_space_limit
    type:
      - 'null'
      - string
    doc: Set max disk space to use for reverse profile searches. E.g. 800B, 5K, 10M, 1G. Default
      (0) to all available disk space in the temp folder
    inputBinding:
      position: 104
      prefix: --disk-space-limit
  - id: a
    type:
      - 'null'
      - int
    doc: Add backtrace string (convert to alignments with mmseqs convertalis module) (0 or
      1)
    inputBinding:
      position: 104
      prefix: -a
  - id: alignment_mode
    type:
      - 'null'
      - int
    doc: 'How to compute the alignment: 0: automatic 1: only score and end_pos 2: also start_pos
      and cov 3: also seq.id 4: only ungapped alignment'
    inputBinding:
      position: 104
      prefix: --alignment-mode
  - id: alignment_output_mode
    type:
      - 'null'
      - int
    doc: 'How to compute the alignment: 0: automatic 1: only score and end_pos 2: also start_pos
      and cov 3: also seq.id 4: only ungapped alignment 5: score only (output) cluster format'
    inputBinding:
      position: 104
      prefix: --alignment-output-mode
  - id: wrapped_scoring
    type:
      - 'null'
      - int
    doc: Double the (nucleotide) query sequence during the scoring process to allow wrapped
      diagonal scoring around end and start (0 or 1)
    inputBinding:
      position: 104
      prefix: --wrapped-scoring
  - id: e
    type:
      - 'null'
      - float
    doc: List matches below this E-value (range 0.0-inf)
    inputBinding:
      position: 104
      prefix: -e
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity (for clustering) (range 0.0-1.0)
    inputBinding:
      position: 104
      prefix: --min-seq-id
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length (range 0-INT_MAX)
    inputBinding:
      position: 104
      prefix: --min-aln-len
  - id: seq_id_mode
    type:
      - 'null'
      - int
    doc: '0: alignment length 1: shorter, 2: longer sequence'
    inputBinding:
      position: 104
      prefix: --seq-id-mode
  - id: alt_ali
    type:
      - 'null'
      - int
    doc: Show up to this many alternative alignments
    inputBinding:
      position: 104
      prefix: --alt-ali
  - id: c
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see --cov-mode)
    inputBinding:
      position: 104
      prefix: -c
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: '0: coverage of query and target 1: coverage of target 2: coverage of query 3: target
      seq. length has to be at least x% of query length 4: query seq. length has to be at
      least x% of target length 5: short seq. needs to be at least x% of the other seq. length'
    inputBinding:
      position: 104
      prefix: --cov-mode
  - id: max_rejected
    type:
      - 'null'
      - int
    doc: Maximum rejected alignments before alignment calculation for a query is stopped
    inputBinding:
      position: 104
      prefix: --max-rejected
  - id: max_accept
    type:
      - 'null'
      - int
    doc: Maximum accepted alignments before alignment calculation for a query is stopped
    inputBinding:
      position: 104
      prefix: --max-accept
  - id: score_bias
    type:
      - 'null'
      - float
    doc: Score bias when computing SW alignment (in bits)
    inputBinding:
      position: 104
      prefix: --score-bias
  - id: realign
    type:
      - 'null'
      - int
    doc: Compute more conservative, shorter alignments (scores and E-values not changed) (0
      or 1)
    inputBinding:
      position: 104
      prefix: --realign
  - id: realign_score_bias
    type:
      - 'null'
      - float
    doc: Additional bias when computing realignment
    inputBinding:
      position: 104
      prefix: --realign-score-bias
  - id: realign_max_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of results to return in realignment
    inputBinding:
      position: 104
      prefix: --realign-max-seqs
  - id: corr_score_weight
    type:
      - 'null'
      - float
    doc: Weight of backtrace correlation score that is added to the alignment score
    inputBinding:
      position: 104
      prefix: --corr-score-weight
  - id: gap_open
    type:
      - 'null'
      - string
    doc: Gap open cost
    inputBinding:
      position: 104
      prefix: --gap-open
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: Gap extension cost
    inputBinding:
      position: 104
      prefix: --gap-extend
  - id: zdrop
    type:
      - 'null'
      - int
    doc: Maximal allowed difference between score values before alignment is truncated  (nucleotide
      alignment only)
    inputBinding:
      position: 104
      prefix: --zdrop
  - id: exhaustive_search_filter
    type:
      - 'null'
      - int
    doc: 'Filter result during search: 0: do not filter, 1: filter'
    inputBinding:
      position: 104
      prefix: --exhaustive-search-filter
  - id: pca
    type:
      - 'null'
      - float
    doc: Pseudo count admixture strength
    inputBinding:
      position: 104
      prefix: --pca
  - id: pcb
    type:
      - 'null'
      - float
    doc: 'Pseudo counts: Neff at half of maximum admixture (range 0.0-inf)'
    inputBinding:
      position: 104
      prefix: --pcb
  - id: mask_profile
    type:
      - 'null'
      - int
    doc: Mask query sequence of profile using tantan [0,1]
    inputBinding:
      position: 104
      prefix: --mask-profile
  - id: e_profile
    type:
      - 'null'
      - float
    doc: Include sequences matches with < E-value thr. into the profile (>=0.0)
    inputBinding:
      position: 104
      prefix: --e-profile
  - id: wg
    type:
      - 'null'
      - int
    doc: Use global sequence weighting for profile calculation (0 or 1)
    inputBinding:
      position: 104
      prefix: --wg
  - id: filter_msa
    type:
      - 'null'
      - int
    doc: 'Filter msa: 0: do not filter, 1: filter'
    inputBinding:
      position: 104
      prefix: --filter-msa
  - id: filter_min_enable
    type:
      - 'null'
      - int
    doc: Only filter MSAs with more than N sequences, 0 always filters
    inputBinding:
      position: 104
      prefix: --filter-min-enable
  - id: max_seq_id
    type:
      - 'null'
      - float
    doc: Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0]
    inputBinding:
      position: 104
      prefix: --max-seq-id
  - id: qid
    type:
      - 'null'
      - string
    doc: 'Reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0]
      Alternatively, can be a list of multiple thresholds: E.g.: 0.15,0.30,0.50 to defines
      filter buckets of ]0.15-0.30] and ]0.30-0.50]'
    inputBinding:
      position: 104
      prefix: --qid
  - id: qsc
    type:
      - 'null'
      - float
    doc: Reduce diversity of output MSAs using min. score per aligned residue with query sequences
      [-50.0,100.0]
    inputBinding:
      position: 104
      prefix: --qsc
  - id: cov
    type:
      - 'null'
      - float
    doc: Filter output MSAs using min. fraction of query residues covered by matched sequences
      [0.0,1.0]
    inputBinding:
      position: 104
      prefix: --cov
  - id: diff
    type:
      - 'null'
      - int
    doc: Filter MSAs by selecting most diverse set of sequences, keeping at least this many
      seqs in each MSA block of length 50
    inputBinding:
      position: 104
      prefix: --diff
  - id: pseudo_cnt_mode
    type:
      - 'null'
      - int
    doc: 'use 0: substitution-matrix or 1: context-specific pseudocounts'
    inputBinding:
      position: 104
      prefix: --pseudo-cnt-mode
  - id: profile_output_mode
    type:
      - 'null'
      - int
    doc: 'Profile output mode: 0: binary log-odds 1: human-readable frequencies'
    inputBinding:
      position: 104
      prefix: --profile-output-mode
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: Number of iterative profile search iterations
    inputBinding:
      position: 104
      prefix: --num-iterations
  - id: exhaustive_search
    type:
      - 'null'
      - int
    doc: For bigger profile DB, run iteratively the search by greedily swapping the search
      results (0 or 1)
    inputBinding:
      position: 104
      prefix: --exhaustive-search
  - id: lca_search
    type:
      - 'null'
      - int
    doc: Efficient search for LCA candidates (0 or 1)
    inputBinding:
      position: 104
      prefix: --lca-search
  - id: taxon_list
    type:
      - 'null'
      - string
    doc: Taxonomy ID, possibly multiple values separated by ','
    inputBinding:
      position: 104
      prefix: --taxon-list
  - id: prefilter_mode
    type:
      - 'null'
      - int
    doc: 'prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter, 3: ungapped&gapped'
    inputBinding:
      position: 104
      prefix: --prefilter-mode
  - id: rescore_mode
    type:
      - 'null'
      - int
    doc: 'Rescore diagonals with: 0: Hamming distance 1: local alignment (score only) 2: local
      alignment 3: global alignment 4: longest alignment fulfilling window quality criterion'
    inputBinding:
      position: 104
      prefix: --rescore-mode
  - id: allow_deletion
    type:
      - 'null'
      - int
    doc: Allow deletions in a MSA (0 or 1)
    inputBinding:
      position: 104
      prefix: --allow-deletion
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum codon number in open reading frames
    inputBinding:
      position: 104
      prefix: --min-length
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum codon number in open reading frames
    inputBinding:
      position: 104
      prefix: --max-length
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: Maximum number of codons with gaps or unknown residues before an open reading frame
      is rejected
    inputBinding:
      position: 104
      prefix: --max-gaps
  - id: contig_start_mode
    type:
      - 'null'
      - int
    doc: 'Contig start can be 0: incomplete, 1: complete, 2: both'
    inputBinding:
      position: 104
      prefix: --contig-start-mode
  - id: contig_end_mode
    type:
      - 'null'
      - int
    doc: 'Contig end can be 0: incomplete, 1: complete, 2: both'
    inputBinding:
      position: 104
      prefix: --contig-end-mode
  - id: orf_start_mode
    type:
      - 'null'
      - int
    doc: 'Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from last encountered
      start to stop (no start in the middle)'
    inputBinding:
      position: 104
      prefix: --orf-start-mode
  - id: forward_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the forward strand to be extracted
    inputBinding:
      position: 104
      prefix: --forward-frames
  - id: reverse_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the reverse strand to be extracted
    inputBinding:
      position: 104
      prefix: --reverse-frames
  - id: translation_table
    type:
      - 'null'
      - int
    doc: 1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL,
      5) INVERT_MITOCHONDRIAL, 6) CILIATE 9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE,
      12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL 15) BLEPHARISMA,
      16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL
      23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA,
      26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA 29) MESODINIUM, 30) PERTRICH, 31)
      BLASTOCRITHIDIA
    inputBinding:
      position: 104
      prefix: --translation-table
  - id: translate
    type:
      - 'null'
      - int
    doc: Translate ORF to amino acid
    inputBinding:
      position: 104
      prefix: --translate
  - id: use_all_table_starts
    type:
      - 'null'
      - int
    doc: Use all alternatives for a start codon in the genetic table, if false - only ATG
      (AUG) (0 or 1)
    inputBinding:
      position: 104
      prefix: --use-all-table-starts
  - id: id_offset
    type:
      - 'null'
      - int
    doc: Numeric ids in index file are offset by this value
    inputBinding:
      position: 104
      prefix: --id-offset
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
    doc: 'Sequence split mode 0: copy data, 1: soft link data and write new index,'
    inputBinding:
      position: 104
      prefix: --sequence-split-mode
  - id: headers_split_mode
    type:
      - 'null'
      - int
    doc: 'Header split mode: 0: split position, 1: original header'
    inputBinding:
      position: 104
      prefix: --headers-split-mode
  - id: search_type
    type:
      - 'null'
      - int
    doc: 'Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide
      alignment'
    inputBinding:
      position: 104
      prefix: --search-type
  - id: start_sens
    type:
      - 'null'
      - float
    doc: Start sensitivity
    inputBinding:
      position: 104
      prefix: --start-sens
  - id: sens_steps
    type:
      - 'null'
      - int
    doc: Number of search steps performed from --start-sens to -s
    inputBinding:
      position: 104
      prefix: --sens-steps
  - id: translation_mode
    type:
      - 'null'
      - int
    doc: 'Translation AA seq from nucleotide by 0: ORFs, 1: full reading frames'
    inputBinding:
      position: 104
      prefix: --translation-mode
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    inputBinding:
      position: 104
      prefix: --sub-mat
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    inputBinding:
      position: 104
      prefix: --max-seq-len
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch'
    inputBinding:
      position: 104
      prefix: --db-load-mode
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
  - id: gpu
    type:
      - 'null'
      - int
    doc: Use GPU (CUDA) if possible
    inputBinding:
      position: 104
      prefix: --gpu
  - id: gpu_server
    type:
      - 'null'
      - int
    doc: Use GPU server
    inputBinding:
      position: 104
      prefix: --gpu-server
  - id: gpu_server_wait_timeout
    type:
      - 'null'
      - int
    doc: 'Wait for GPU server for 0: don''t wait -1: no wait limit: >0 this many seconds'
    inputBinding:
      position: 104
      prefix: --gpu-server-wait-timeout
  - id: mpi_runner
    type:
      - 'null'
      - string
    doc: Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42")
    inputBinding:
      position: 104
      prefix: --mpi-runner
  - id: force_reuse
    type:
      - 'null'
      - int
    doc: Reuse tmp filse in tmp/latest folder ignoring parameters and version changes (0 or
      1)
    inputBinding:
      position: 104
      prefix: --force-reuse
  - id: remove_tmp_files
    type:
      - 'null'
      - int
    doc: Delete temporary files (0 or 1)
    inputBinding:
      position: 104
      prefix: --remove-tmp-files
  - id: filter_hits
    type:
      - 'null'
      - int
    doc: Filter hits by seq.id. and coverage (0 or 1)
    inputBinding:
      position: 104
      prefix: --filter-hits
  - id: sort_results
    type:
      - 'null'
      - int
    doc: 'Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming)'
    inputBinding:
      position: 104
      prefix: --sort-results
  - id: create_lookup
    type:
      - 'null'
      - int
    doc: Create database lookup file (can be very large)
    inputBinding:
      position: 104
      prefix: --create-lookup
  - id: chain_alignments
    type:
      - 'null'
      - int
    doc: Chain overlapping alignments
    inputBinding:
      position: 104
      prefix: --chain-alignments
  - id: merge_query
    type:
      - 'null'
      - int
    doc: Combine ORFs/split sequences to a single entry
    inputBinding:
      position: 104
      prefix: --merge-query
  - id: strand
    type:
      - 'null'
      - int
    doc: 'Strand selection only works for DNA/DNA search 0: reverse, 1: forward, 2: both'
    inputBinding:
      position: 104
      prefix: --strand
outputs:
  - id: output_alignment_db
    type: Directory
    doc: Directory holding the alignment database
    outputBinding:
      glob: out_db
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
