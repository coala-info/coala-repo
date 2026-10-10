cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - easy-linclust
label: mmseqs2_easy-linclust
doc: 'Fast, linear-time, less sensitive clustering of FASTA sequences. Writes <prefix>_cluster.tsv,
  <prefix>_rep_seq.fasta and <prefix>_all_seqs.fasta.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: input_fasta
    type:
      type: array
      items: File
    doc: Input FASTA files (optionally gzip or bzip2)
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Prefix of the output files
    inputBinding:
      position: 2
  - id: tmp_dir
    type: string
    doc: Temporary directory (created by the tool)
    inputBinding:
      position: 3
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
  - id: alph_size
    type:
      - 'null'
      - string
    doc: Alphabet size (range 2-21)
    inputBinding:
      position: 104
      prefix: --alph-size
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
  - id: k
    type:
      - 'null'
      - int
    doc: 'k-mer length (0: automatically set to optimum)'
    inputBinding:
      position: 104
      prefix: -k
  - id: split_memory_limit
    type:
      - 'null'
      - string
    doc: Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system
      memory
    inputBinding:
      position: 104
      prefix: --split-memory-limit
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
  - id: cluster_mode
    type:
      - 'null'
      - int
    doc: '0: Set-Cover (greedy) 1: Connected component (BLASTclust) 2,3: Greedy clustering
      by sequence length (CDHIT)'
    inputBinding:
      position: 104
      prefix: --cluster-mode
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum depth of breadth first search in connected component clustering
    inputBinding:
      position: 104
      prefix: --max-iterations
  - id: similarity_type
    type:
      - 'null'
      - int
    doc: 'Type of score used for clustering. 1: alignment score 2: sequence identity'
    inputBinding:
      position: 104
      prefix: --similarity-type
  - id: weights
    type:
      - 'null'
      - string
    doc: Weights used for cluster priorization
    inputBinding:
      position: 104
      prefix: --weights
  - id: cluster_weight_threshold
    type:
      - 'null'
      - float
    doc: Weight threshold used for cluster priorization
    inputBinding:
      position: 104
      prefix: --cluster-weight-threshold
  - id: kmer_per_seq
    type:
      - 'null'
      - int
    doc: k-mers per sequence
    inputBinding:
      position: 104
      prefix: --kmer-per-seq
  - id: kmer_per_seq_scale
    type:
      - 'null'
      - string
    doc: Scale k-mer per sequence based on sequence length as kmer-per-seq val + scale x seqlen
    inputBinding:
      position: 104
      prefix: --kmer-per-seq-scale
  - id: adjust_kmer_len
    type:
      - 'null'
      - int
    doc: Adjust k-mer length based on specificity (only for nucleotides) (0 or 1)
    inputBinding:
      position: 104
      prefix: --adjust-kmer-len
  - id: hash_shift
    type:
      - 'null'
      - int
    doc: Shift k-mer hash initialization
    inputBinding:
      position: 104
      prefix: --hash-shift
  - id: include_only_extendable
    type:
      - 'null'
      - int
    doc: Include only extendable (0 or 1)
    inputBinding:
      position: 104
      prefix: --include-only-extendable
  - id: ignore_multi_kmer
    type:
      - 'null'
      - int
    doc: Skip k-mers occurring multiple times (>=2) (0 or 1)
    inputBinding:
      position: 104
      prefix: --ignore-multi-kmer
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
  - id: rescore_mode
    type:
      - 'null'
      - int
    doc: 'Rescore diagonals with: 0: Hamming distance 1: local alignment (score only) 2: local
      alignment 3: global alignment 4: longest alignment fulfilling window quality criterion'
    inputBinding:
      position: 104
      prefix: --rescore-mode
  - id: dbtype
    type:
      - 'null'
      - int
    doc: 'Database type 0: auto, 1: amino acid 2: nucleotides'
    inputBinding:
      position: 104
      prefix: --dbtype
  - id: shuffle
    type:
      - 'null'
      - int
    doc: Shuffle input database (0 or 1)
    inputBinding:
      position: 104
      prefix: --shuffle
  - id: createdb_mode
    type:
      - 'null'
      - int
    doc: 'Createdb mode 0: copy data, 1: soft link data and write new index (works only with
      single line fasta/q) 2: GPU compatible db'
    inputBinding:
      position: 104
      prefix: --createdb-mode
  - id: id_offset
    type:
      - 'null'
      - int
    doc: Numeric ids in index file are offset by this value
    inputBinding:
      position: 104
      prefix: --id-offset
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
  - id: remove_tmp_files
    type:
      - 'null'
      - int
    doc: Delete temporary files (0 or 1)
    inputBinding:
      position: 104
      prefix: --remove-tmp-files
  - id: force_reuse
    type:
      - 'null'
      - int
    doc: Reuse tmp filse in tmp/latest folder ignoring parameters and version changes (0 or
      1)
    inputBinding:
      position: 104
      prefix: --force-reuse
  - id: mpi_runner
    type:
      - 'null'
      - string
    doc: Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42")
    inputBinding:
      position: 104
      prefix: --mpi-runner
  - id: gpu
    type:
      - 'null'
      - int
    doc: Use GPU (CUDA) if possible
    inputBinding:
      position: 104
      prefix: --gpu
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
  - id: write_lookup
    type:
      - 'null'
      - int
    doc: write .lookup file containing mapping from internal id, fasta id and file number
    inputBinding:
      position: 104
      prefix: --write-lookup
outputs:
  - id: output_cluster
    type: File
    doc: 'Two-column table: cluster representative and member'
    outputBinding:
      glob: $(inputs.output_prefix)_cluster.tsv
  - id: output_all_seqs
    type: File
    doc: All sequences, grouped by cluster, as FASTA
    outputBinding:
      glob: $(inputs.output_prefix)_all_seqs.fasta
  - id: output_rep_seq
    type: File
    doc: Representative sequences as FASTA
    outputBinding:
      glob: $(inputs.output_prefix)_rep_seq.fasta
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
