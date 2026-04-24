cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spacedust
  - aa2foldseek
label: spacedust_aa2foldseek
doc: "By Ruoshi Zhang <ruoshi.zhang@mpinat.mpg.de> & Milot Mirdita <milot@mirdita.de>\n\
  \nTool homepage: https://github.com/soedinglab/spacedust"
inputs:
  - id: input_db
    type: string
    doc: inputDB
    inputBinding:
      position: 1
  - id: target_db
    type: string
    doc: targetDB
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
  - id: add_self_matches
    type:
      - 'null'
      - boolean
    doc: Artificially add entries of queries with themselves (for clustering) 
      [0]
    inputBinding:
      position: 104
      prefix: --add-self-matches
  - id: alignment_mode
    type:
      - 'null'
      - int
    doc: "How to compute the alignment:\n                               0: automatic\n\
      \                               1: only score and end_pos\n                \
      \               2: also start_pos and cov\n                               3:
      also seq.id\n                               4: only ungapped alignment [0]"
    inputBinding:
      position: 104
      prefix: --alignment-mode
  - id: alignment_output_mode
    type:
      - 'null'
      - int
    doc: "How to compute the alignment:\n                               0: automatic\n\
      \                               1: only score and end_pos\n                \
      \               2: also start_pos and cov\n                               3:
      also seq.id\n                               4: only ungapped alignment\n   \
      \                            5: score only (output) cluster format [0]"
    inputBinding:
      position: 104
      prefix: --alignment-output-mode
  - id: alphabet_size
    type:
      - 'null'
      - string
    doc: Alphabet size (range 2-21) [aa:21,nucl:5]
    inputBinding:
      position: 104
      prefix: --alph-size
  - id: alt_ali
    type:
      - 'null'
      - int
    doc: Show up to this many alternative alignments [0]
    inputBinding:
      position: 104
      prefix: --alt-ali
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
      - int
    doc: Write compressed output [0]
    inputBinding:
      position: 104
      prefix: --compressed
  - id: corr_score_weight
    type:
      - 'null'
      - float
    doc: Weight of backtrace correlation score that is added to the alignment 
      score [0.000]
    inputBinding:
      position: 104
      prefix: --corr-score-weight
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: "0: coverage of query and target\n                               1: coverage
      of target\n                               2: coverage of query\n           \
      \                    3: target seq. length has to be at least x% of query length\n\
      \                               4: query seq. length has to be at least x% of
      target length\n                               5: short seq. needs to be at least
      x% of the other seq. length [0]"
    inputBinding:
      position: 104
      prefix: --cov-mode
  - id: coverage_fraction
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see 
      --cov-mode) [0.900]
    inputBinding:
      position: 104
      prefix: -c
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
  - id: evalue
    type:
      - 'null'
      - double
    doc: List matches below this E-value (range 0.0-inf) [1.000E-03]
    inputBinding:
      position: 104
      prefix: -e
  - id: exact_kmer_matching
    type:
      - 'null'
      - int
    doc: Extract only exact k-mers for matching (range 0-1) [1]
    inputBinding:
      position: 104
      prefix: --exact-kmer-matching
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: Gap extension cost [aa:1,nucl:2]
    inputBinding:
      position: 104
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - string
    doc: Gap open cost [aa:11,nucl:5]
    inputBinding:
      position: 104
      prefix: --gap-open
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'k-mer length (0: automatically set to optimum) [0]'
    inputBinding:
      position: 104
      prefix: -k
  - id: kmer_score
    type:
      - 'null'
      - string
    doc: k-mer threshold for generating similar k-mer lists 
      [seq:2147483647,prof:2147483647]
    inputBinding:
      position: 104
      prefix: --k-score
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
    doc: 'Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low
      complexity masking [1]'
    inputBinding:
      position: 104
      prefix: --mask
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: 'Lowercase letters will be excluded from k-mer search 0: include region,
      1: exclude region [0]'
    inputBinding:
      position: 104
      prefix: --mask-lower-case
  - id: mask_prob
    type:
      - 'null'
      - float
    doc: Mask sequences is probablity is above threshold [0.900]
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
      (affects sensitivity) [10]
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
      0.0-1.0) [0.900]
    inputBinding:
      position: 104
      prefix: --min-seq-id
  - id: min_ungapped_score
    type:
      - 'null'
      - int
    doc: Accept only matches with ungapped alignment score above threshold [15]
    inputBinding:
      position: 104
      prefix: --min-ungapped-score
  - id: pca
    type:
      - 'null'
      - boolean
    doc: Pseudo count admixture strength []
    inputBinding:
      position: 104
      prefix: --pca
  - id: pcb
    type:
      - 'null'
      - float
    doc: 'Pseudo counts: Neff at half of maximum admixture (range 0.0-inf) []'
    inputBinding:
      position: 104
      prefix: --pcb
  - id: realign
    type:
      - 'null'
      - boolean
    doc: Compute more conservative, shorter alignments (scores and E-values not 
      changed) [0]
    inputBinding:
      position: 104
      prefix: --realign
  - id: realign_max_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of results to return in realignment [2147483647]
    inputBinding:
      position: 104
      prefix: --realign-max-seqs
  - id: realign_score_bias
    type:
      - 'null'
      - float
    doc: Additional bias when computing realignment [-0.200]
    inputBinding:
      position: 104
      prefix: --realign-score-bias
  - id: remove_tmp_files
    type:
      - 'null'
      - boolean
    doc: Delete temporary files [0]
    inputBinding:
      position: 104
      prefix: --remove-tmp-files
  - id: score_bias
    type:
      - 'null'
      - float
    doc: Score bias when computing SW alignment (in bits) [0.000]
    inputBinding:
      position: 104
      prefix: --score-bias
  - id: seed_sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file for k-mer generation 
      [aa:VTML80.out,nucl:nucleotide.out]
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
  - id: stat
    type:
      - 'null'
      - string
    doc: 'One of: linecount, mean, min, max, doolittle, charges, seqlen, firstline
      []'
    inputBinding:
      position: 104
      prefix: --stat
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file [aa:blosum62.out,nucl:nucleotide.out]
    inputBinding:
      position: 104
      prefix: --sub-mat
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
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: Return output in TSV format [0]
    inputBinding:
      position: 104
      prefix: --tsv
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]'
    inputBinding:
      position: 104
      prefix: -v
  - id: wrapped_scoring
    type:
      - 'null'
      - boolean
    doc: Double the (nucleotide) query sequence during the scoring process to 
      allow wrapped diagonal scoring around end and start [0]
    inputBinding:
      position: 104
      prefix: --wrapped-scoring
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
    dockerPull: quay.io/biocontainers/spacedust:2.e56c505--hd6d6fdc_0
stdout: spacedust_aa2foldseek.out
