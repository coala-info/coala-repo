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
    type: string
    doc: Temporary directory
    inputBinding:
      position: 4
  - id: add_backtrace
    type:
      - 'null'
      - int
    doc: add backtrace string (convert to alignments with mmseqs convertalis utility)
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
    inputBinding:
      position: 104
      prefix: --alignment-mode
  - id: alph_size
    type:
      - 'null'
      - int
    doc: alphabet size (range 2-21)
    inputBinding:
      position: 104
      prefix: --alph-size
  - id: alt_ali
    type:
      - 'null'
      - int
    doc: Show up to this many alternative alignments
    inputBinding:
      position: 104
      prefix: --alt-ali
  - id: comp_bias_corr
    type:
      - 'null'
      - int
    doc: correct for locally biased amino acid composition (range 0-1)
    inputBinding:
      position: 104
      prefix: --comp-bias-corr
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: '0: coverage of query and target, 1: coverage of target, 2: coverage of query
      etc.'
    inputBinding:
      position: 104
      prefix: --cov-mode
  - id: coverage
    type:
      - 'null'
      - float
    doc: list matches above this fraction of aligned (covered) residues
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
    inputBinding:
      position: 104
      prefix: --disk-space-limit
  - id: e_profile
    type:
      - 'null'
      - float
    doc: includes sequences matches with < e-value thr. into the profile (>=0.0)
    inputBinding:
      position: 104
      prefix: --e-profile
  - id: e_value
    type:
      - 'null'
      - float
    doc: list matches below this E-value (range 0.0-inf)
    inputBinding:
      position: 104
      prefix: -e
  - id: exact_kmer_matching
    type:
      - 'null'
      - int
    doc: only exact k-mer matching (range 0-1)
    inputBinding:
      position: 104
      prefix: --exact-kmer-matching
  - id: filter_msa
    type:
      - 'null'
      - int
    doc: 'filter msa: 0: do not filter, 1: filter'
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
    inputBinding:
      position: 104
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - int
    doc: Gap open cost
    inputBinding:
      position: 104
      prefix: --gap-open
  - id: k_mer_size
    type:
      - 'null'
      - int
    doc: 'k-mer size in the range (0: set automatically to optimum)'
    inputBinding:
      position: 104
      prefix: -k
  - id: k_score
    type:
      - 'null'
      - int
    doc: K-mer threshold for generating similar k-mer lists
    inputBinding:
      position: 104
      prefix: --k-score
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
    doc: 'mask sequences in k-mer stage 0: w/o low complexity masking, 1: with low
      complexity masking'
    inputBinding:
      position: 104
      prefix: --mask
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: 'lowercase letters will be excluded from k-mer search 0: include region,
      1: exclude region'
    inputBinding:
      position: 104
      prefix: --mask-lower-case
  - id: mask_profile
    type:
      - 'null'
      - int
    doc: mask query sequence of profile using tantan [0,1]
    inputBinding:
      position: 104
      prefix: --mask-profile
  - id: max_accept
    type:
      - 'null'
      - int
    doc: maximum accepted alignments before alignment calculation for a query is stopped
    inputBinding:
      position: 104
      prefix: --max-accept
  - id: max_rejected
    type:
      - 'null'
      - int
    doc: maximum rejected alignments before alignment calculation for a query is aborted
    inputBinding:
      position: 104
      prefix: --max-rejected
  - id: max_seq_id_msa
    type:
      - 'null'
      - float
    doc: reduce redundancy of output MSA using max. pairwise sequence identity
    inputBinding:
      position: 104
      prefix: --max-seq-id
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: minimum alignment length (range 0-INT_MAX)
    inputBinding:
      position: 104
      prefix: --min-aln-len
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimum codon number in open reading frames
    inputBinding:
      position: 104
      prefix: --min-length
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: list matches above this sequence identity (for clustering) (range 0.0-1.0)
    inputBinding:
      position: 104
      prefix: --min-seq-id
  - id: min_ungapped_score
    type:
      - 'null'
      - int
    doc: accept only matches with ungapped alignment score above this threshold
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
    inputBinding:
      position: 104
      prefix: --num-iterations
  - id: pca
    type:
      - 'null'
      - float
    doc: pseudo count admixture strength
    inputBinding:
      position: 104
      prefix: --pca
  - id: pcb
    type:
      - 'null'
      - float
    doc: 'pseudo counts: Neff at half of maximum admixture (range 0.0-inf)'
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
    inputBinding:
      position: 104
      prefix: --rescore-mode
  - id: score_bias
    type:
      - 'null'
      - float
    doc: Score bias when computing the SW alignment (in bits)
    inputBinding:
      position: 104
      prefix: --score-bias
  - id: search_type
    type:
      - 'null'
      - int
    doc: 'search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated
      nucleotide alignment'
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
    inputBinding:
      position: 104
      prefix: --threads
  - id: translate
    type:
      - 'null'
      - int
    doc: translate ORF to amino acid
    inputBinding:
      position: 104
      prefix: --translate
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Genetic code translation table
    inputBinding:
      position: 104
      prefix: --translation-table
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'verbosity level: 0=nothing, 1: +errors, 2: +warnings, 3: +info'
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
  - id: result_path
    type: string
    doc: Prefix of the result files (<result>_conterm_prediction and <result>_all)
    inputBinding:
      position: 3
  - id: qid
    type:
      - 'null'
      - float
    doc: 'reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0] [0.000]'
    inputBinding:
      position: 104
      prefix: --qid
  - id: qsc
    type:
      - 'null'
      - float
    doc: 'reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]'
    inputBinding:
      position: 104
      prefix: --qsc
  - id: cov
    type:
      - 'null'
      - float
    doc: 'filter output MSAs using min. fraction of query residues covered by matched sequences [0.0,1.0] [0.000]'
    inputBinding:
      position: 104
      prefix: --cov
  - id: diff
    type:
      - 'null'
      - int
    doc: 'filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [1000]'
    inputBinding:
      position: 104
      prefix: --diff
  - id: allow_deletion
    type:
      - 'null'
      - boolean
    doc: 'allow deletions in a MSA'
    inputBinding:
      position: 104
      prefix: --allow-deletion
  - id: max_length
    type:
      - 'null'
      - int
    doc: 'maximum codon number in open reading frames [32734]'
    inputBinding:
      position: 104
      prefix: --max-length
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: 'maximum number of codons with gaps or unknown residues before an open reading frame is rejected [2147483647]'
    inputBinding:
      position: 104
      prefix: --max-gaps
  - id: contig_start_mode
    type:
      - 'null'
      - int
    doc: 'Contig start can be 0: incomplete, 1: complete, 2: both [2]'
    inputBinding:
      position: 104
      prefix: --contig-start-mode
  - id: contig_end_mode
    type:
      - 'null'
      - int
    doc: 'Contig end can be 0: incomplete, 1: complete, 2: both  [2]'
    inputBinding:
      position: 104
      prefix: --contig-end-mode
  - id: orf_start_mode
    type:
      - 'null'
      - int
    doc: 'Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from last encountered start to stop (no start in the middle) [1]'
    inputBinding:
      position: 104
      prefix: --orf-start-mode
  - id: forward_frames
    type:
      - 'null'
      - string
    doc: 'comma-seperated list of ORF frames on the forward strand to be extracted [1]'
    inputBinding:
      position: 104
      prefix: --forward-frames
  - id: reverse_frames
    type:
      - 'null'
      - string
    doc: 'comma-seperated list of ORF frames on the reverse strand to be extracted [1]'
    inputBinding:
      position: 104
      prefix: --reverse-frames
  - id: use_all_table_starts
    type:
      - 'null'
      - boolean
    doc: 'use all alteratives for a start codon in the genetic table, if false - only ATG (AUG)'
    inputBinding:
      position: 104
      prefix: --use-all-table-starts
  - id: id_offset
    type:
      - 'null'
      - int
    doc: 'numeric ids in index file are offset by this value  [0]'
    inputBinding:
      position: 104
      prefix: --id-offset
  - id: add_orf_stop
    type:
      - 'null'
      - boolean
    doc: 'add * at complete start and end'
    inputBinding:
      position: 104
      prefix: --add-orf-stop
  - id: start_sens
    type:
      - 'null'
      - float
    doc: 'start sensitivity [4.000]'
    inputBinding:
      position: 104
      prefix: --start-sens
  - id: sens_steps
    type:
      - 'null'
      - int
    doc: 'Search steps performed from --start-sense and -s. [1]'
    inputBinding:
      position: 104
      prefix: --sens-steps
  - id: remove_tmp_files
    type:
      - 'null'
      - int
    doc: 'Delete temporary files [1, set to 0 to disable]'
    inputBinding:
      position: 104
      prefix: --remove-tmp-files
  - id: dbtype
    type:
      - 'null'
      - int
    doc: 'Database type 0: auto, 1: amino acid 2: nucleotides [0]'
    inputBinding:
      position: 104
      prefix: --dbtype
  - id: shuffle
    type:
      - 'null'
      - int
    doc: 'Shuffle input database [1, set to 0 to disable]'
    inputBinding:
      position: 104
      prefix: --shuffle
  - id: createdb_mode
    type:
      - 'null'
      - int
    doc: 'createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) [0]'
    inputBinding:
      position: 104
      prefix: --createdb-mode
  - id: blacklist
    type:
      - 'null'
      - string
    doc: 'Comma separated list of ignored taxa in LCA computation [10239,12908,28384,81077,11632,340016,61964,48479,48510]'
    inputBinding:
      position: 104
      prefix: --blacklist
  - id: kingdoms
    type:
      - 'null'
      - string
    doc: '[(2||2157),4751,33208,33090,(2759&&!4751&&!33208&&!33090)]'
    inputBinding:
      position: 104
      prefix: --kingdoms
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: 'amino acid substitution matrix file [nucl:nucleotide.out,aa:blosum62.out]'
    inputBinding:
      position: 104
      prefix: --sub-mat
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: 'maximum sequence length (range 1-32768]) [1000]'
    inputBinding:
      position: 104
      prefix: --max-seq-len
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]'
    inputBinding:
      position: 104
      prefix: --db-load-mode
  - id: compressed
    type:
      - 'null'
      - int
    doc: 'write results in compressed format [0]'
    inputBinding:
      position: 104
      prefix: --compressed
  - id: split_memory_limit
    type:
      - 'null'
      - string
    doc: 'Set max memory per split. E.g. 800B, 5K, 10M, 1G. Defaults (0) to all available system memory. [0]'
    inputBinding:
      position: 104
      prefix: --split-memory-limit
  - id: mpi_runner
    type:
      - 'null'
      - string
    doc: 'Use MPI on compute grid with this MPI command (e.g. "mpirun -np 42") []'
    inputBinding:
      position: 104
      prefix: --mpi-runner
  - id: filter_hits
    type:
      - 'null'
      - boolean
    doc: 'filter hits by seq.id. and coverage'
    inputBinding:
      position: 104
      prefix: --filter-hits
  - id: sort_results
    type:
      - 'null'
      - int
    doc: 'Sort results: 0: no sorting, 1: sort by evalue (Alignment) or seq.id. (Hamming) [0]'
    inputBinding:
      position: 104
      prefix: --sort-results
  - id: omit_consensus
    type:
      - 'null'
      - boolean
    doc: 'Omit consensus sequence in alignment'
    inputBinding:
      position: 104
      prefix: --omit-consensus
  - id: create_lookup
    type:
      - 'null'
      - int
    doc: 'Create database lookup file (can be very large) [0]'
    inputBinding:
      position: 104
      prefix: --create-lookup
  - id: chain_alignments
    type:
      - 'null'
      - int
    doc: 'Chain overlapping alignments [0]'
    inputBinding:
      position: 104
      prefix: --chain-alignments
  - id: merge_query
    type:
      - 'null'
      - int
    doc: 'combine ORFs/split sequences to a single entry [1]'
    inputBinding:
      position: 104
      prefix: --merge-query
  - id: strand
    type:
      - 'null'
      - int
    doc: 'Strand selection only works for DNA/DNA search 0: reverse, 1: forward, 2: both [2]'
    inputBinding:
      position: 104
      prefix: --strand
outputs:
  - id: conterm_prediction
    type: File
    doc: Predicted contamination (TSV), written to <result>_conterm_prediction
    outputBinding:
      glob: $(inputs.result_path)_conterm_prediction
  - id: all_alignments
    type: File
    doc: All alignments used to predict contamination, written to <result>_all
    outputBinding:
      glob: $(inputs.result_path)_all
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conterminator:1.c74b5--h9cf7dee_0
