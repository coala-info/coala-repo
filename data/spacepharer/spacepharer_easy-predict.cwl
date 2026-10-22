cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spacepharer
  - easy-predict
label: spacepharer_easy-predict
doc: "Predict phage-host matches from common spacer files (PILER-CR, CRISPRDetect and CRT/MinCED)\n\nTool homepage: https://github.com/soedinglab/spacepharer"
inputs:
  - id: spacer_files
    type:
      type: array
      items: File
    doc: "Spacer files: multi-FASTA, or PILER-CR, CRISPRDetect or CRT/MinCED output"
    inputBinding:
      position: 1
  - id: target_db
    type: string
    doc: "Name (prefix) of the target set database; its files, and the control set database named <name>_rev, must be listed in db_files"
    inputBinding:
      position: 2
  - id: db_files
    type:
      type: array
      items: File
    doc: "All files of the target set database and of its control set database, staged into the working directory"
  - id: output
    type: string
    doc: "Output TSV file"
    inputBinding:
      position: 3
  - id: tmp_dir
    type: string
    doc: "Temporary directory"
    inputBinding:
      position: 4
  - id: comp_bias_corr
    type:
      - 'null'
      - int
    doc: "Correct for locally biased amino acid composition (range 0-1) [1]"
    inputBinding:
      position: 104
      prefix: --comp-bias-corr
  - id: add_self_matches
    type:
      - 'null'
      - boolean
    doc: "Artificially add entries of queries with themselves (for clustering) [0]"
    inputBinding:
      position: 104
      prefix: --add-self-matches
      valueFrom: '$(self ? 1 : 0)'
  - id: seed_sub_mat
    type:
      - 'null'
      - string
    doc: "Substitution matrix file for k-mer generation [nucl:nucleotide.out,aa:VTML80.out]"
    inputBinding:
      position: 104
      prefix: --seed-sub-mat
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: "Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive [5.700]"
    inputBinding:
      position: 104
      prefix: -s
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: "k-mer length (0: automatically set to optimum) [6]"
    inputBinding:
      position: 104
      prefix: -k
  - id: k_score
    type:
      - 'null'
      - int
    doc: "k-mer threshold for generating similar k-mer lists [2147483647]"
    inputBinding:
      position: 104
      prefix: --k-score
  - id: alph_size
    type:
      - 'null'
      - string
    doc: "Alphabet size (range 2-21) [nucl:5,aa:21]"
    inputBinding:
      position: 104
      prefix: --alph-size
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: "Maximum results per query sequence allowed to pass the prefilter (affects sensitivity) [0.000]"
    inputBinding:
      position: 104
      prefix: --max-seqs
  - id: split
    type:
      - 'null'
      - int
    doc: "Split input into N equally distributed chunks. 0: set the best split automatically [0]"
    inputBinding:
      position: 104
      prefix: --split
  - id: split_mode
    type:
      - 'null'
      - int
    doc: "0: split target db; 1: split query db; 2: auto, depending on main memory [2]"
    inputBinding:
      position: 104
      prefix: --split-mode
  - id: split_memory_limit
    type:
      - 'null'
      - string
    doc: "Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]"
    inputBinding:
      position: 104
      prefix: --split-memory-limit
  - id: diag_score
    type:
      - 'null'
      - boolean
    doc: "Use ungapped diagonal scoring during prefilter [1]"
    inputBinding:
      position: 104
      prefix: --diag-score
      valueFrom: '$(self ? 1 : 0)'
  - id: exact_kmer_matching
    type:
      - 'null'
      - int
    doc: "Extract only exact k-mers for matching (range 0-1) [0]"
    inputBinding:
      position: 104
      prefix: --exact-kmer-matching
  - id: mask
    type:
      - 'null'
      - int
    doc: "Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low complexity masking [1]"
    inputBinding:
      position: 104
      prefix: --mask
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: "Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]"
    inputBinding:
      position: 104
      prefix: --mask-lower-case
  - id: min_ungapped_score
    type:
      - 'null'
      - int
    doc: "Accept only matches with ungapped alignment score above threshold [15]"
    inputBinding:
      position: 104
      prefix: --min-ungapped-score
  - id: spaced_kmer_mode
    type:
      - 'null'
      - int
    doc: "0: use consecutive positions in k-mers; 1: use spaced k-mers [1]"
    inputBinding:
      position: 104
      prefix: --spaced-kmer-mode
  - id: spaced_kmer_pattern
    type:
      - 'null'
      - string
    doc: "User-specified spaced k-mer pattern [11011101]"
    inputBinding:
      position: 104
      prefix: --spaced-kmer-pattern
  - id: local_tmp
    type:
      - 'null'
      - string
    doc: "Path where some of the temporary files will be created []"
    inputBinding:
      position: 104
      prefix: --local-tmp
  - id: disk_space_limit
    type:
      - 'null'
      - string
    doc: "Set max disk space to use for reverse profile searches. E.g. 800B, 5K, 10M, 1G. Default (0) to all available disk space in the temp folder [0]"
    inputBinding:
      position: 104
      prefix: --disk-space-limit
  - id: add_backtrace
    type:
      - 'null'
      - boolean
    doc: "Add backtrace string (convert to alignments with mmseqs convertalis module) [1]"
    inputBinding:
      position: 104
      prefix: -a
      valueFrom: '$(self ? 1 : 0)'
  - id: alignment_mode
    type:
      - 'null'
      - int
    doc: "How to compute the alignment: 0: automatic 1: only score and end_pos 2: also start_pos and cov 3: also seq.id 4: only ungapped alignment [2]"
    inputBinding:
      position: 104
      prefix: --alignment-mode
  - id: alignment_output_mode
    type:
      - 'null'
      - int
    doc: "How to compute the alignment: 0: automatic 1: only score and end_pos 2: also start_pos and cov 3: also seq.id 4: only ungapped alignment 5: score only (output) cluster format [0]"
    inputBinding:
      position: 104
      prefix: --alignment-output-mode
  - id: wrapped_scoring
    type:
      - 'null'
      - boolean
    doc: "Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]"
    inputBinding:
      position: 104
      prefix: --wrapped-scoring
      valueFrom: '$(self ? 1 : 0)'
  - id: evalue
    type:
      - 'null'
      - double
    doc: "List matches below this E-value (range 0.0-inf) [2.000E+02]"
    inputBinding:
      position: 104
      prefix: -e
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: "List matches above this sequence identity (for clustering) (range 0.0-1.0) [0.000]"
    inputBinding:
      position: 104
      prefix: --min-seq-id
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: "Minimum alignment length (range 0-INT_MAX) [0]"
    inputBinding:
      position: 104
      prefix: --min-aln-len
  - id: seq_id_mode
    type:
      - 'null'
      - int
    doc: "0: alignment length 1: shorter, 2: longer sequence [0]"
    inputBinding:
      position: 104
      prefix: --seq-id-mode
  - id: alt_ali
    type:
      - 'null'
      - int
    doc: "Show up to this many alternative alignments [0]"
    inputBinding:
      position: 104
      prefix: --alt-ali
  - id: coverage_fraction
    type:
      - 'null'
      - float
    doc: "List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]"
    inputBinding:
      position: 104
      prefix: -c
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: "0: coverage of query and target 1: coverage of target 2: coverage of query 3: target seq. length has to be at least x% of query length 4: query seq. length has to be at least x% of target length 5: short seq. needs to be at least x% of the other seq. length [0]"
    inputBinding:
      position: 104
      prefix: --cov-mode
  - id: max_rejected
    type:
      - 'null'
      - int
    doc: "Maximum rejected alignments before alignment calculation for a query is stopped [2147483647]"
    inputBinding:
      position: 104
      prefix: --max-rejected
  - id: max_accept
    type:
      - 'null'
      - int
    doc: "Maximum accepted alignments before alignment calculation for a query is stopped [2147483647]"
    inputBinding:
      position: 104
      prefix: --max-accept
  - id: score_bias
    type:
      - 'null'
      - float
    doc: "Score bias when computing SW alignment (in bits) [0.000]"
    inputBinding:
      position: 104
      prefix: --score-bias
  - id: realign
    type:
      - 'null'
      - boolean
    doc: "Compute more conservative, shorter alignments (scores and E-values not changed) [0]"
    inputBinding:
      position: 104
      prefix: --realign
      valueFrom: '$(self ? 1 : 0)'
  - id: realign_score_bias
    type:
      - 'null'
      - float
    doc: "Additional bias when computing realignment [-0.200]"
    inputBinding:
      position: 104
      prefix: --realign-score-bias
  - id: realign_max_seqs
    type:
      - 'null'
      - int
    doc: "Maximum number of results to return in realignment [2147483647]"
    inputBinding:
      position: 104
      prefix: --realign-max-seqs
  - id: gap_open
    type:
      - 'null'
      - string
    doc: "Gap open cost [nucl:10,aa:16]"
    inputBinding:
      position: 104
      prefix: --gap-open
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: "Gap extension cost [2]"
    inputBinding:
      position: 104
      prefix: --gap-extend
  - id: zdrop
    type:
      - 'null'
      - int
    doc: "Maximal allowed difference between score values before alignment is truncated  (nucleotide alignment only) [40]"
    inputBinding:
      position: 104
      prefix: --zdrop
  - id: exhaustive_search_filter
    type:
      - 'null'
      - int
    doc: "Filter result during search: 0: do not filter, 1: filter [0]"
    inputBinding:
      position: 104
      prefix: --exhaustive-search-filter
  - id: pca
    type:
      - 'null'
      - float
    doc: "Pseudo count admixture strength [1.000]"
    inputBinding:
      position: 104
      prefix: --pca
  - id: pcb
    type:
      - 'null'
      - float
    doc: "Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) [1.500]"
    inputBinding:
      position: 104
      prefix: --pcb
  - id: mask_profile
    type:
      - 'null'
      - int
    doc: "Mask query sequence of profile using tantan [0,1] [1]"
    inputBinding:
      position: 104
      prefix: --mask-profile
  - id: e_profile
    type:
      - 'null'
      - double
    doc: "Include sequences matches with < E-value thr. into the profile (>=0.0) [1.000E-03]"
    inputBinding:
      position: 104
      prefix: --e-profile
  - id: wg
    type:
      - 'null'
      - boolean
    doc: "Use global sequence weighting for profile calculation [0]"
    inputBinding:
      position: 104
      prefix: --wg
      valueFrom: '$(self ? 1 : 0)'
  - id: filter_msa
    type:
      - 'null'
      - int
    doc: "Filter msa: 0: do not filter, 1: filter [1]"
    inputBinding:
      position: 104
      prefix: --filter-msa
  - id: max_seq_id
    type:
      - 'null'
      - float
    doc: "Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0] [0.900]"
    inputBinding:
      position: 104
      prefix: --max-seq-id
  - id: qid
    type:
      - 'null'
      - float
    doc: "Reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0] [0.000]"
    inputBinding:
      position: 104
      prefix: --qid
  - id: qsc
    type:
      - 'null'
      - float
    doc: "Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]"
    inputBinding:
      position: 104
      prefix: --qsc
  - id: cov
    type:
      - 'null'
      - float
    doc: "Filter output MSAs using min. fraction of query residues covered by matched sequences [0.0,1.0] [0.000]"
    inputBinding:
      position: 104
      prefix: --cov
  - id: diff
    type:
      - 'null'
      - int
    doc: "Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [1000]"
    inputBinding:
      position: 104
      prefix: --diff
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: "Number of iterative profile search iterations [1]"
    inputBinding:
      position: 104
      prefix: --num-iterations
  - id: exhaustive_search
    type:
      - 'null'
      - boolean
    doc: "For bigger profile DB, run iteratively the search by greedily swapping the search results [0]"
    inputBinding:
      position: 104
      prefix: --exhaustive-search
      valueFrom: '$(self ? 1 : 0)'
  - id: lca_search
    type:
      - 'null'
      - boolean
    doc: "Efficient search for LCA candidates [0]"
    inputBinding:
      position: 104
      prefix: --lca-search
      valueFrom: '$(self ? 1 : 0)'
  - id: tax_mapping_file
    type:
      - 'null'
      - string
    doc: "File to map sequence identifier to taxonomical identifier []"
    inputBinding:
      position: 104
      prefix: --tax-mapping-file
  - id: ncbi_tax_dump
    type:
      - 'null'
      - string
    doc: "NCBI tax dump directory. The tax dump can be downloaded here \"ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz\" []"
    inputBinding:
      position: 104
      prefix: --ncbi-tax-dump
  - id: rescore_mode
    type:
      - 'null'
      - int
    doc: "Rescore diagonals with: 0: Hamming distance 1: local alignment (score only) 2: local alignment 3: global alignment 4: longest alignment fulfilling window quality criterion [0]"
    inputBinding:
      position: 104
      prefix: --rescore-mode
  - id: allow_deletion
    type:
      - 'null'
      - boolean
    doc: "Allow deletions in a MSA [0]"
    inputBinding:
      position: 104
      prefix: --allow-deletion
      valueFrom: '$(self ? 1 : 0)'
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum codon number in open reading frames [9]"
    inputBinding:
      position: 104
      prefix: --min-length
  - id: max_length
    type:
      - 'null'
      - int
    doc: "Maximum codon number in open reading frames [32734]"
    inputBinding:
      position: 104
      prefix: --max-length
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: "Maximum number of codons with gaps or unknown residues before an open reading frame is rejected [2147483647]"
    inputBinding:
      position: 104
      prefix: --max-gaps
  - id: contig_start_mode
    type:
      - 'null'
      - int
    doc: "Contig start can be 0: incomplete, 1: complete, 2: both [2]"
    inputBinding:
      position: 104
      prefix: --contig-start-mode
  - id: contig_end_mode
    type:
      - 'null'
      - int
    doc: "Contig end can be 0: incomplete, 1: complete, 2: both [2]"
    inputBinding:
      position: 104
      prefix: --contig-end-mode
  - id: orf_start_mode
    type:
      - 'null'
      - int
    doc: "Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from last encountered start to stop (no start in the middle) [1]"
    inputBinding:
      position: 104
      prefix: --orf-start-mode
  - id: forward_frames
    type:
      - 'null'
      - string
    doc: "Comma-separated list of frames on the forward strand to be extracted [1,2,3]"
    inputBinding:
      position: 104
      prefix: --forward-frames
  - id: reverse_frames
    type:
      - 'null'
      - string
    doc: "Comma-separated list of frames on the reverse strand to be extracted [1,2,3]"
    inputBinding:
      position: 104
      prefix: --reverse-frames
  - id: translation_table
    type:
      - 'null'
      - int
    doc: "1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE 9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL 15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL 23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA 29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]"
    inputBinding:
      position: 104
      prefix: --translation-table
  - id: translate
    type:
      - 'null'
      - int
    doc: "Translate ORF to amino acid [0]"
    inputBinding:
      position: 104
      prefix: --translate
  - id: use_all_table_starts
    type:
      - 'null'
      - boolean
    doc: "Use all alternatives for a start codon in the genetic table, if false - only ATG (AUG) [0]"
    inputBinding:
      position: 104
      prefix: --use-all-table-starts
      valueFrom: '$(self ? 1 : 0)'
  - id: id_offset
    type:
      - 'null'
      - int
    doc: "Numeric ids in index file are offset by this value [0]"
    inputBinding:
      position: 104
      prefix: --id-offset
  - id: add_orf_stop
    type:
      - 'null'
      - boolean
    doc: "Add stop codon '*' at complete start and end [0]"
    inputBinding:
      position: 104
      prefix: --add-orf-stop
      valueFrom: '$(self ? 1 : 0)'
  - id: sequence_overlap
    type:
      - 'null'
      - int
    doc: "Overlap between sequences [0]"
    inputBinding:
      position: 104
      prefix: --sequence-overlap
  - id: sequence_split_mode
    type:
      - 'null'
      - int
    doc: "Sequence split mode 0: copy data, 1: soft link data and write new index, [1]"
    inputBinding:
      position: 104
      prefix: --sequence-split-mode
  - id: headers_split_mode
    type:
      - 'null'
      - int
    doc: "Header split mode: 0: split position, 1: original header [0]"
    inputBinding:
      position: 104
      prefix: --headers-split-mode
  - id: search_type
    type:
      - 'null'
      - int
    doc: "Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide alignment [0]"
    inputBinding:
      position: 104
      prefix: --search-type
  - id: start_sens
    type:
      - 'null'
      - float
    doc: "Start sensitivity [4.000]"
    inputBinding:
      position: 104
      prefix: --start-sens
  - id: sens_steps
    type:
      - 'null'
      - int
    doc: "Number of search steps performed from --start-sens to -s [1]"
    inputBinding:
      position: 104
      prefix: --sens-steps
  - id: fdr
    type:
      - 'null'
      - float
    doc: "FDR cutoff for filtering matches [0.0, 1.0] [0.050]"
    inputBinding:
      position: 104
      prefix: --fdr
  - id: fmt
    type:
      - 'null'
      - int
    doc: "0: short (only matches) 1: long (matches and hits) 2: long with nucleotide alignment [1]"
    inputBinding:
      position: 104
      prefix: --fmt
  - id: lca_ranks
    type:
      - 'null'
      - string
    doc: "Add column with specified ranks (',' separated) [superkingdom,phylum,class,order,family,genus,species]"
    inputBinding:
      position: 104
      prefix: --lca-ranks
  - id: tax_lineage
    type:
      - 'null'
      - int
    doc: "0: don't show, 1: add all lineage names, 2: add all lineage taxids [0]"
    inputBinding:
      position: 104
      prefix: --tax-lineage
  - id: flanking_seq_len
    type:
      - 'null'
      - int
    doc: "Length of protospacer flanking sequence to extract for possible PAMs scanning [10]"
    inputBinding:
      position: 104
      prefix: --flanking-seq-len
  - id: tax_fdr
    type:
      - 'null'
      - float
    doc: "FDR cutoff for taxonomy report [0.0, 1.0] [0.020]"
    inputBinding:
      position: 104
      prefix: --tax-fdr
  - id: restrict_ranks_mode
    type:
      - 'null'
      - int
    doc: "0: disabled, 1: restrict taxonomic rank on target prediction by sequence identity [1]"
    inputBinding:
      position: 104
      prefix: --restrict-ranks-mode
  - id: rank_min_seq_ids
    type:
      - 'null'
      - string
    doc: "Comma-separated sequence identity thresholds to restrict ranks to: species, genus, family, order, class, phylum, kingdom, superkingdom [0.86,0.84,0.82,0.80,0.78,0.76,0.74,0.72]"
    inputBinding:
      position: 104
      prefix: --rank-min-seq-ids
  - id: report_pam
    type:
      - 'null'
      - int
    doc: "Report protospacer adjacent motifs up and downstream of hits [1]"
    inputBinding:
      position: 104
      prefix: --report-pam
  - id: perform_nucl_aln
    type:
      - 'null'
      - int
    doc: "0: perform only 6-frame translated search, 1:perform additional nucl-nucl alignment to the hits reported in 6-frame translated search, and update the E-value [1]"
    inputBinding:
      position: 104
      prefix: --perform-nucl-aln
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: "Substitution matrix file [nucl:nucleotide.out,aa:VTML40.out]"
    inputBinding:
      position: 104
      prefix: --sub-mat
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: "Maximum sequence length [0.000]"
    inputBinding:
      position: 104
      prefix: --max-seq-len
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: "Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]"
    inputBinding:
      position: 104
      prefix: --db-load-mode
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of CPU-cores used (all by default) [20]"
    inputBinding:
      position: 104
      prefix: --threads
  - id: compressed
    type:
      - 'null'
      - int
    doc: "Write compressed output [0]"
    inputBinding:
      position: 104
      prefix: --compressed
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]"
    inputBinding:
      position: 104
      prefix: -v
  - id: mpi_runner
    type:
      - 'null'
      - string
    doc: "Use MPI on compute cluster with this MPI command (e.g. \"mpirun -np 42\") []"
    inputBinding:
      position: 104
      prefix: --mpi-runner
  - id: force_reuse
    type:
      - 'null'
      - boolean
    doc: "Reuse tmp filse in tmp/latest folder ignoring parameters and version changes [0]"
    inputBinding:
      position: 104
      prefix: --force-reuse
      valueFrom: '$(self ? 1 : 0)'
  - id: remove_tmp_files
    type:
      - 'null'
      - boolean
    doc: "Delete temporary files [0]"
    inputBinding:
      position: 104
      prefix: --remove-tmp-files
      valueFrom: '$(self ? 1 : 0)'
  - id: filter_hits
    type:
      - 'null'
      - boolean
    doc: "Filter hits by seq.id. and coverage [0]"
    inputBinding:
      position: 104
      prefix: --filter-hits
      valueFrom: '$(self ? 1 : 0)'
  - id: sort_results
    type:
      - 'null'
      - int
    doc: "Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]"
    inputBinding:
      position: 104
      prefix: --sort-results
  - id: create_lookup
    type:
      - 'null'
      - int
    doc: "Create database lookup file (can be very large) [0]"
    inputBinding:
      position: 104
      prefix: --create-lookup
  - id: chain_alignments
    type:
      - 'null'
      - int
    doc: "Chain overlapping alignments [0]"
    inputBinding:
      position: 104
      prefix: --chain-alignments
  - id: merge_query
    type:
      - 'null'
      - int
    doc: "Combine ORFs/split sequences to a single entry [1]"
    inputBinding:
      position: 104
      prefix: --merge-query
  - id: strand
    type:
      - 'null'
      - int
    doc: "Strand selection only works for DNA/DNA search 0: reverse, 1: forward, 2: both [1]"
    inputBinding:
      position: 104
      prefix: --strand
  - id: db_output
    type:
      - 'null'
      - boolean
    doc: "Return a result DB instead of a text file [0]"
    inputBinding:
      position: 104
      prefix: --db-output
      valueFrom: '$(self ? 1 : 0)'
outputs:
  - id: output_file
    type: File
    doc: Output TSV file with the predicted phage-host matches
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.db_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacepharer:5.c2e680a--hd6d6fdc_7
