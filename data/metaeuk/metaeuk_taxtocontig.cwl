cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaeuk taxtocontig
label: metaeuk_taxtocontig
doc: "By Eli Levy Karin <eli.levy.karin@gmail.com>\n\nTool homepage: https://github.com/soedinglab/metaeuk"
inputs:
  - id: contigs_db
    type: File
    doc: Input contigs database
    inputBinding:
      position: 1
  - id: predictions_fasta
    type: File
    doc: Input predictions FASTA file
    inputBinding:
      position: 2
  - id: predictions_fasta_headers_map
    type: File
    doc: Input predictions FASTA headers map TSV file
    inputBinding:
      position: 3
  - id: tax_annot_target_db
    type: File
    doc: Input tax annotation target database
    inputBinding:
      position: 4
  - id: tmp_dir
    type: Directory
    doc: Temporary directory
    inputBinding:
      position: 5
  - id: add_backtrace
    type:
      - 'null'
      - boolean
    doc: Add backtrace string (convert to alignments with mmseqs convertalis 
      module)
    default: 0
    inputBinding:
      position: 106
      prefix: -a
  - id: add_orf_stop
    type:
      - 'null'
      - boolean
    doc: Add stop codon '*' at complete start and end
    default: 0
    inputBinding:
      position: 106
      prefix: --add-orf-stop
  - id: add_self_matches
    type:
      - 'null'
      - boolean
    doc: Artificially add entries of queries with themselves (for clustering)
    default: 0
    inputBinding:
      position: 106
      prefix: --add-self-matches
  - id: alignment_mode
    type:
      - 'null'
      - int
    doc: 'How to compute the alignment: 0: automatic, 1: only score and end_pos, 2:
      also start_pos and cov, 3: also seq.id, 4: only ungapped alignment'
    default: 0
    inputBinding:
      position: 106
      prefix: --alignment-mode
  - id: alignment_output_mode
    type:
      - 'null'
      - int
    doc: 'How to compute the alignment: 0: automatic, 1: only score and end_pos, 2:
      also start_pos and cov, 3: also seq.id, 4: only ungapped alignment, 5: score
      only (output) cluster format'
    default: 0
    inputBinding:
      position: 106
      prefix: --alignment-output-mode
  - id: allow_deletion
    type:
      - 'null'
      - boolean
    doc: Allow deletions in a MSA
    default: 0
    inputBinding:
      position: 106
      prefix: --allow-deletion
  - id: alph_size
    type:
      - 'null'
      - string
    doc: Alphabet size (range 2-21)
    default: aa:21,nucl:5
    inputBinding:
      position: 106
      prefix: --alph-size
  - id: alt_ali
    type:
      - 'null'
      - int
    doc: Show up to this many alternative alignments
    default: 0
    inputBinding:
      position: 106
      prefix: --alt-ali
  - id: blacklist
    type:
      - 'null'
      - string
    doc: Comma separated list of ignored taxa in LCA computation
    default: 12908:unclassified sequences,28384:other sequences
    inputBinding:
      position: 106
      prefix: --blacklist
  - id: chain_alignments
    type:
      - 'null'
      - int
    doc: Chain overlapping alignments
    default: 0
    inputBinding:
      position: 106
      prefix: --chain-alignments
  - id: comp_bias_corr
    type:
      - 'null'
      - int
    doc: Correct for locally biased amino acid composition (range 0-1)
    default: 1
    inputBinding:
      position: 106
      prefix: --comp-bias-corr
  - id: comp_bias_corr_scale
    type:
      - 'null'
      - float
    doc: Correct for locally biased amino acid composition (range 0-1)
    default: 1.0
    inputBinding:
      position: 106
      prefix: --comp-bias-corr-scale
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    default: 0
    inputBinding:
      position: 106
      prefix: --compressed
  - id: contig_end_mode
    type:
      - 'null'
      - int
    doc: 'Contig end can be 0: incomplete, 1: complete, 2: both'
    default: 2
    inputBinding:
      position: 106
      prefix: --contig-end-mode
  - id: contig_start_mode
    type:
      - 'null'
      - int
    doc: 'Contig start can be 0: incomplete, 1: complete, 2: both'
    default: 2
    inputBinding:
      position: 106
      prefix: --contig-start-mode
  - id: corr_score_weight
    type:
      - 'null'
      - float
    doc: Weight of backtrace correlation score that is added to the alignment 
      score
    default: 0.0
    inputBinding:
      position: 106
      prefix: --corr-score-weight
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: '0: coverage of query and target, 1: coverage of target, 2: coverage of query,
      3: target seq. length has to be at least x% of query length, 4: query seq. length
      has to be at least x% of target length, 5: short seq. needs to be at least x%
      of the other seq. length'
    default: 0
    inputBinding:
      position: 106
      prefix: --cov-mode
  - id: cov_profile
    type:
      - 'null'
      - float
    doc: Filter output MSAs using min. fraction of query residues covered by 
      matched sequences [0.0,1.0]
    default: 0.0
    inputBinding:
      position: 106
      prefix: --cov
  - id: covered_residues_fraction
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see 
      --cov-mode)
    default: 0.0
    inputBinding:
      position: 106
      prefix: -c
  - id: create_lookup
    type:
      - 'null'
      - int
    doc: Create database lookup file (can be very large)
    default: 0
    inputBinding:
      position: 106
      prefix: --create-lookup
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch'
    default: 0
    inputBinding:
      position: 106
      prefix: --db-load-mode
  - id: diag_score
    type:
      - 'null'
      - boolean
    doc: Use ungapped diagonal scoring during prefilter
    default: 1
    inputBinding:
      position: 106
      prefix: --diag-score
  - id: diff
    type:
      - 'null'
      - int
    doc: Filter MSAs by selecting most diverse set of sequences, keeping at 
      least this many seqs in each MSA block of length 50
    default: 1000
    inputBinding:
      position: 106
      prefix: --diff
  - id: disk_space_limit
    type:
      - 'null'
      - string
    doc: Set max disk space to use for reverse profile searches. E.g. 800B, 5K, 
      10M, 1G. Default (0) to all available disk space in the temp folder
    default: '0'
    inputBinding:
      position: 106
      prefix: --disk-space-limit
  - id: e_profile
    type:
      - 'null'
      - double
    doc: Include sequences matches with < E-value thr. into the profile (>=0.0)
    default: '1.000E-03'
    inputBinding:
      position: 106
      prefix: --e-profile
  - id: exact_kmer_matching
    type:
      - 'null'
      - int
    doc: Extract only exact k-mers for matching (range 0-1)
    default: 0
    inputBinding:
      position: 106
      prefix: --exact-kmer-matching
  - id: exhaustive_search
    type:
      - 'null'
      - boolean
    doc: For bigger profile DB, run iteratively the search by greedily swapping 
      the search results
    default: 0
    inputBinding:
      position: 106
      prefix: --exhaustive-search
  - id: exhaustive_search_filter
    type:
      - 'null'
      - int
    doc: 'Filter result during search: 0: do not filter, 1: filter'
    default: 0
    inputBinding:
      position: 106
      prefix: --exhaustive-search-filter
  - id: filter_hits
    type:
      - 'null'
      - boolean
    doc: Filter hits by seq.id. and coverage
    default: 0
    inputBinding:
      position: 106
      prefix: --filter-hits
  - id: filter_min_enable
    type:
      - 'null'
      - int
    doc: Only filter MSAs with more than N sequences, 0 always filters
    default: 0
    inputBinding:
      position: 106
      prefix: --filter-min-enable
  - id: filter_msa
    type:
      - 'null'
      - int
    doc: 'Filter msa: 0: do not filter, 1: filter'
    default: 1
    inputBinding:
      position: 106
      prefix: --filter-msa
  - id: force_reuse
    type:
      - 'null'
      - boolean
    doc: Reuse tmp filse in tmp/latest folder ignoring parameters and version 
      changes
    default: 0
    inputBinding:
      position: 106
      prefix: --force-reuse
  - id: forward_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the forward strand to be extracted
    default: 1,2,3
    inputBinding:
      position: 106
      prefix: --forward-frames
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: Gap extension cost
    default: aa:1,nucl:2
    inputBinding:
      position: 106
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - string
    doc: Gap open cost
    default: aa:11,nucl:5
    inputBinding:
      position: 106
      prefix: --gap-open
  - id: headers_split_mode
    type:
      - 'null'
      - int
    doc: 'Header split mode: 0: split position, 1: original header'
    default: 0
    inputBinding:
      position: 106
      prefix: --headers-split-mode
  - id: id_offset
    type:
      - 'null'
      - int
    doc: Numeric ids in index file are offset by this value
    default: 0
    inputBinding:
      position: 106
      prefix: --id-offset
  - id: k_score
    type:
      - 'null'
      - string
    doc: k-mer threshold for generating similar k-mer lists
    default: seq:2147483647,prof:2147483647
    inputBinding:
      position: 106
      prefix: --k-score
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'k-mer length (0: automatically set to optimum)'
    default: 0
    inputBinding:
      position: 106
      prefix: -k
  - id: lca_mode
    type:
      - 'null'
      - int
    doc: 'LCA Mode 1: single search LCA , 2/3: approximate 2bLCA, 4: top hit'
    default: 3
    inputBinding:
      position: 106
      prefix: --lca-mode
  - id: lca_ranks
    type:
      - 'null'
      - string
    doc: Add column with specified ranks (',' separated)
    default: ''
    inputBinding:
      position: 106
      prefix: --lca-ranks
  - id: lca_search
    type:
      - 'null'
      - boolean
    doc: Efficient search for LCA candidates
    default: 0
    inputBinding:
      position: 106
      prefix: --lca-search
  - id: local_tmp
    type:
      - 'null'
      - string
    doc: Path where some of the temporary files will be created
    default: ''
    inputBinding:
      position: 106
      prefix: --local-tmp
  - id: majority
    type:
      - 'null'
      - float
    doc: minimal fraction of agreement among taxonomically assigned sequences of
      a set
    default: 0.5
    inputBinding:
      position: 106
      prefix: --majority
  - id: mask
    type:
      - 'null'
      - int
    doc: 'Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low
      complexity masking'
    default: 1
    inputBinding:
      position: 106
      prefix: --mask
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: 'Lowercase letters will be excluded from k-mer search 0: include region,
      1: exclude region'
    default: 0
    inputBinding:
      position: 106
      prefix: --mask-lower-case
  - id: mask_prob
    type:
      - 'null'
      - float
    doc: Mask sequences is probablity is above threshold
    default: 0.9
    inputBinding:
      position: 106
      prefix: --mask-prob
  - id: mask_profile
    type:
      - 'null'
      - int
    doc: Mask query sequence of profile using tantan [0,1]
    default: 1
    inputBinding:
      position: 106
      prefix: --mask-profile
  - id: max_accept
    type:
      - 'null'
      - int
    doc: Maximum accepted alignments before alignment calculation for a query is
      stopped
    default: 2147483647
    inputBinding:
      position: 106
      prefix: --max-accept
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: Maximum number of codons with gaps or unknown residues before an open 
      reading frame is rejected
    default: 2147483647
    inputBinding:
      position: 106
      prefix: --max-gaps
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum codon number in open reading frames
    default: 32734
    inputBinding:
      position: 106
      prefix: --max-length
  - id: max_rejected
    type:
      - 'null'
      - int
    doc: Maximum rejected alignments before alignment calculation for a query is
      stopped
    default: 2147483647
    inputBinding:
      position: 106
      prefix: --max-rejected
  - id: max_seq_id_profile
    type:
      - 'null'
      - float
    doc: Reduce redundancy of output MSA using max. pairwise sequence identity 
      [0.0,1.0]
    default: 0.9
    inputBinding:
      position: 106
      prefix: --max-seq-id
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    default: 65535
    inputBinding:
      position: 106
      prefix: --max-seq-len
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: Maximum results per query sequence allowed to pass the prefilter 
      (affects sensitivity)
    default: 300
    inputBinding:
      position: 106
      prefix: --max-seqs
  - id: merge_query
    type:
      - 'null'
      - int
    doc: Combine ORFs/split sequences to a single entry
    default: 1
    inputBinding:
      position: 106
      prefix: --merge-query
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length (range 0-INT_MAX)
    default: 0
    inputBinding:
      position: 106
      prefix: --min-aln-len
  - id: min_evalue
    type:
      - 'null'
      - double
    doc: List matches below this E-value (range 0.0-inf)
    default: '1.000E-03'
    inputBinding:
      position: 106
      prefix: -e
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum codon number in open reading frames
    default: 30
    inputBinding:
      position: 106
      prefix: --min-length
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity (for clustering) (range 
      0.0-1.0)
    default: 0.0
    inputBinding:
      position: 106
      prefix: --min-seq-id
  - id: min_ungapped_score
    type:
      - 'null'
      - int
    doc: Accept only matches with ungapped alignment score above threshold
    default: 15
    inputBinding:
      position: 106
      prefix: --min-ungapped-score
  - id: mpi_runner
    type:
      - 'null'
      - string
    doc: Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42")
    default: ''
    inputBinding:
      position: 106
      prefix: --mpi-runner
  - id: orf_filter
    type:
      - 'null'
      - int
    doc: "Prefilter query ORFs with non-selective search\n                       \
      \           Only used during nucleotide-vs-protein classification\n        \
      \                          NOTE: Consider disabling when classifying short reads"
    default: 0
    inputBinding:
      position: 106
      prefix: --orf-filter
  - id: orf_filter_e
    type:
      - 'null'
      - double
    doc: E-value threshold used for query ORF prefiltering
    default: '1.000E+02'
    inputBinding:
      position: 106
      prefix: --orf-filter-e
  - id: orf_filter_s
    type:
      - 'null'
      - float
    doc: Sensitivity used for query ORF prefiltering
    default: 2.0
    inputBinding:
      position: 106
      prefix: --orf-filter-s
  - id: orf_start_mode
    type:
      - 'null'
      - int
    doc: 'Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from
      last encountered start to stop (no start in the middle)'
    default: 1
    inputBinding:
      position: 106
      prefix: --orf-start-mode
  - id: pca
    type:
      - 'null'
      - boolean
    doc: Pseudo count admixture strength
    inputBinding:
      position: 106
      prefix: --pca
  - id: pcb
    type:
      - 'null'
      - string
    doc: 'Pseudo counts: Neff at half of maximum admixture (range 0.0-inf)'
    inputBinding:
      position: 106
      prefix: --pcb
  - id: prefilter_mode
    type:
      - 'null'
      - int
    doc: 'prefilter mode: 0: kmer/ungapped 1: ungapped, 2: nofilter'
    default: 0
    inputBinding:
      position: 106
      prefix: --prefilter-mode
  - id: pseudo_cnt_mode
    type:
      - 'null'
      - int
    doc: 'use 0: substitution-matrix or 1: context-specific pseudocounts'
    default: 0
    inputBinding:
      position: 106
      prefix: --pseudo-cnt-mode
  - id: qid
    type:
      - 'null'
      - string
    doc: "Reduce diversity of output MSAs using min.seq. identity with query sequences
      [0.0,1.0]\n                                  Alternatively, can be a list of
      multiple thresholds:\n                                  E.g.: 0.15,0.30,0.50
      to defines filter buckets of ]0.15-0.30] and ]0.30-0.50]"
    default: '0.0'
    inputBinding:
      position: 106
      prefix: --qid
  - id: qsc
    type:
      - 'null'
      - float
    doc: Reduce diversity of output MSAs using min. score per aligned residue 
      with query sequences [-50.0,100.0]
    default: -20.0
    inputBinding:
      position: 106
      prefix: --qsc
  - id: realign
    type:
      - 'null'
      - boolean
    doc: Compute more conservative, shorter alignments (scores and E-values not 
      changed)
    default: 0
    inputBinding:
      position: 106
      prefix: --realign
  - id: realign_max_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of results to return in realignment
    default: 2147483647
    inputBinding:
      position: 106
      prefix: --realign-max-seqs
  - id: realign_score_bias
    type:
      - 'null'
      - float
    doc: Additional bias when computing realignment
    default: -0.2
    inputBinding:
      position: 106
      prefix: --realign-score-bias
  - id: remove_tmp_files
    type:
      - 'null'
      - boolean
    doc: Delete temporary files
    default: 0
    inputBinding:
      position: 106
      prefix: --remove-tmp-files
  - id: rescore_mode
    type:
      - 'null'
      - int
    doc: 'Rescore diagonals with: 0: Hamming distance, 1: local alignment (score only),
      2: local alignment, 3: global alignment, 4: longest alignment fulfilling window
      quality criterion'
    default: 0
    inputBinding:
      position: 106
      prefix: --rescore-mode
  - id: reverse_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the reverse strand to be extracted
    default: 1,2,3
    inputBinding:
      position: 106
      prefix: --reverse-frames
  - id: score_bias
    type:
      - 'null'
      - float
    doc: Score bias when computing SW alignment (in bits)
    default: 0.0
    inputBinding:
      position: 106
      prefix: --score-bias
  - id: search_type
    type:
      - 'null'
      - int
    doc: 'Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated
      nucleotide alignment'
    default: 0
    inputBinding:
      position: 106
      prefix: --search-type
  - id: seed_sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file for k-mer generation
    default: aa:VTML80.out,nucl:nucleotide.out
    inputBinding:
      position: 106
      prefix: --seed-sub-mat
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: 'Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive'
    default: 4.0
    inputBinding:
      position: 106
      prefix: -s
  - id: seq_id_mode
    type:
      - 'null'
      - int
    doc: '0: alignment length 1: shorter, 2: longer sequence'
    default: 0
    inputBinding:
      position: 106
      prefix: --seq-id-mode
  - id: sequence_overlap
    type:
      - 'null'
      - int
    doc: Overlap between sequences
    default: 0
    inputBinding:
      position: 106
      prefix: --sequence-overlap
  - id: sequence_split_mode
    type:
      - 'null'
      - int
    doc: 'Sequence split mode 0: copy data, 1: soft link data and write new index'
    default: 1
    inputBinding:
      position: 106
      prefix: --sequence-split-mode
  - id: sort_results
    type:
      - 'null'
      - int
    doc: 'Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming)'
    default: 0
    inputBinding:
      position: 106
      prefix: --sort-results
  - id: spaced_kmer_mode
    type:
      - 'null'
      - int
    doc: '0: use consecutive positions in k-mers; 1: use spaced k-mers'
    default: 1
    inputBinding:
      position: 106
      prefix: --spaced-kmer-mode
  - id: spaced_kmer_pattern
    type:
      - 'null'
      - string
    doc: User-specified spaced k-mer pattern
    default: ''
    inputBinding:
      position: 106
      prefix: --spaced-kmer-pattern
  - id: split
    type:
      - 'null'
      - int
    doc: 'Split input into N equally distributed chunks. 0: set the best split automatically'
    default: 0
    inputBinding:
      position: 106
      prefix: --split
  - id: split_memory_limit
    type:
      - 'null'
      - string
    doc: Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all 
      available system memory
    default: '0'
    inputBinding:
      position: 106
      prefix: --split-memory-limit
  - id: split_mode
    type:
      - 'null'
      - int
    doc: '0: split target db; 1: split query db; 2: auto, depending on main memory'
    default: 2
    inputBinding:
      position: 106
      prefix: --split-mode
  - id: strand
    type:
      - 'null'
      - int
    doc: 'Strand selection only works for DNA/DNA search 0: reverse, 1: forward, 2:
      both'
    default: 1
    inputBinding:
      position: 106
      prefix: --strand
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    default: aa:blosum62.out,nucl:nucleotide.out
    inputBinding:
      position: 106
      prefix: --sub-mat
  - id: target_search_mode
    type:
      - 'null'
      - int
    doc: 'target search mode (0: regular k-mer, 1: similar k-mer)'
    default: 0
    inputBinding:
      position: 106
      prefix: --target-search-mode
  - id: tax_lineage
    type:
      - 'null'
      - int
    doc: "0: don't show, 1: add all lineage names, 2: add all lineage taxids"
    default: 0
    inputBinding:
      position: 106
      prefix: --tax-lineage
  - id: tax_output_mode
    type:
      - 'null'
      - int
    doc: '0: output LCA, 1: output alignment 2: output both'
    default: 2
    inputBinding:
      position: 106
      prefix: --tax-output-mode
  - id: taxon_list
    type:
      - 'null'
      - string
    doc: Taxonomy ID, possibly multiple values separated by ','
    default: ''
    inputBinding:
      position: 106
      prefix: --taxon-list
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    default: 20
    inputBinding:
      position: 106
      prefix: --threads
  - id: translate
    type:
      - 'null'
      - int
    doc: Translate ORF to amino acid
    default: 0
    inputBinding:
      position: 106
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
    default: 1
    inputBinding:
      position: 106
      prefix: --translation-table
  - id: use_all_table_starts
    type:
      - 'null'
      - boolean
    doc: Use all alternatives for a start codon in the genetic table, if false -
      only ATG (AUG)
    default: 0
    inputBinding:
      position: 106
      prefix: --use-all-table-starts
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    default: 3
    inputBinding:
      position: 106
      prefix: -v
  - id: vote_mode
    type:
      - 'null'
      - int
    doc: 'Mode of assigning weights to compute majority. 0: uniform, 1: minus log
      E-value, 2: score'
    default: 1
    inputBinding:
      position: 106
      prefix: --vote-mode
  - id: wg
    type:
      - 'null'
      - boolean
    doc: Use global sequence weighting for profile calculation
    default: 0
    inputBinding:
      position: 106
      prefix: --wg
  - id: wrapped_scoring
    type:
      - 'null'
      - boolean
    doc: Double the (nucleotide) query sequence during the scoring process to 
      allow wrapped diagonal scoring around end and start
    default: 0
    inputBinding:
      position: 106
      prefix: --wrapped-scoring
  - id: zdrop
    type:
      - 'null'
      - int
    doc: Maximal allowed difference between score values before alignment is 
      truncated  (nucleotide alignment only)
    default: 40
    inputBinding:
      position: 106
      prefix: --zdrop
outputs:
  - id: tax_result
    type: File
    doc: Output tax result file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2
