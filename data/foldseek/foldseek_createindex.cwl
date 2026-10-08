cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - foldseek
  - createindex
label: foldseek_createindex
doc: 'Create a k-mer index for a structure database to speed up searches.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/steineggerlab/foldseek'
inputs:
  - id: sequence_db
    type: Directory
    doc: Input database (the index is built in a writable copy; the input is not changed)
    inputBinding:
      position: 1
      valueFrom: db_dir/$(inputs.sequence_db_name)
  - id: sequence_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index,
      db.dbtype, db_h, db_ss, db_ca
  - id: tmp_dir
    type: string
    doc: Temporary directory
    inputBinding:
      position: 2
  - id: check_compatible
    type:
      - 'null'
      - int
    doc: '0: Always recreate index, 1: Check if recreating index is needed, 2: Fail
      if index is incompatible'
    inputBinding:
      position: 104
      prefix: --check-compatible
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
  - id: create_lookup
    type:
      - 'null'
      - int
    doc: Create database lookup file (can be very large)
    inputBinding:
      position: 104
      prefix: --create-lookup
  - id: forward_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the forward strand to be extracted
    inputBinding:
      position: 104
      prefix: --forward-frames
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
  - id: index_exclude
    type:
      - 'null'
      - int
    doc: 'Exclude parts of the index: 0: Full index 1: Exclude k-mer index (for use
      with --prefilter-mode 1) 2: Exclude C-alpha coordinates (for use with --sort-by-structure-bits
      0) Flags can be combined bit wise'
    inputBinding:
      position: 104
      prefix: --index-exclude
  - id: index_subset
    type:
      - 'null'
      - int
    doc: 'Create specialized index with subset of entries 0: normal index 1: index
      without headers 2: index without prefiltering data 4: index without aln (for
      cluster db) Flags can be combined bit wise'
    inputBinding:
      position: 104
      prefix: --index-subset
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
  - id: mask
    type:
      - 'null'
      - int
    doc: 'Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking,
      1: with low complexity masking'
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
  - id: mask_n_repeat
    type:
      - 'null'
      - int
    doc: Repeat letters that occure > threshold in a rwo
    inputBinding:
      position: 104
      prefix: --mask-n-repeat
  - id: mask_prob
    type:
      - 'null'
      - float
    doc: Mask sequences is probablity is above threshold
    inputBinding:
      position: 104
      prefix: --mask-prob
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: Maximum number of codons with gaps or unknown residues before an open reading
      frame is rejected
    inputBinding:
      position: 104
      prefix: --max-gaps
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum codon number in open reading frames
    inputBinding:
      position: 104
      prefix: --max-length
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
    doc: Maximum results per query sequence allowed to pass the prefilter (affects
      sensitivity)
    inputBinding:
      position: 104
      prefix: --max-seqs
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum codon number in open reading frames
    inputBinding:
      position: 104
      prefix: --min-length
  - id: orf_start_mode
    type:
      - 'null'
      - int
    doc: 'Orf fragment can be 0: from start to stop, 1: from any to stop, 2: from
      last encountered start to stop (no start in the middle)'
    inputBinding:
      position: 104
      prefix: --orf-start-mode
  - id: remove_tmp_files
    type:
      - 'null'
      - int
    doc: Delete temporary files (0 or 1)
    inputBinding:
      position: 104
      prefix: --remove-tmp-files
  - id: reverse_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the reverse strand to be extracted
    inputBinding:
      position: 104
      prefix: --reverse-frames
  - id: seed_sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file for k-mer generation
    inputBinding:
      position: 104
      prefix: --seed-sub-mat
  - id: sensitivity
    type:
      - 'null'
      - float
    doc: 'Sensitivity: 1.0 faster; 4.0 fast; 7.5 sensitive'
    inputBinding:
      position: 104
      prefix: -s
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
    doc: Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available
      system memory
    inputBinding:
      position: 104
      prefix: --split-memory-limit
  - id: strand
    type:
      - 'null'
      - int
    doc: 'Strand selection only works for DNA/DNA search 0: reverse, 1: forward, 2:
      both'
    inputBinding:
      position: 104
      prefix: --strand
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
  - id: translation_mode
    type:
      - 'null'
      - int
    doc: 'Translation AA seq from nucleotide by 0: ORFs, 1: full reading frames'
    inputBinding:
      position: 104
      prefix: --translation-mode
  - id: translation_table
    type:
      - 'null'
      - int
    doc: 1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL,
      5) INVERT_MITOCHONDRIAL, 6) CILIATE 9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID,
      11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL
      15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL,
      22) SCENEDESMUS_MITOCHONDRIAL 23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL,
      25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA 29) MESODINIUM,
      30) PERTRICH, 31) BLASTOCRITHIDIA
    inputBinding:
      position: 104
      prefix: --translation-table
  - id: use_all_table_starts
    type:
      - 'null'
      - boolean
    doc: Use all alternatives for a start codon in the genetic table, if false - only
      ATG (AUG)
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
outputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files written next to the database (name.idx, name_ss.idx and their
      .dbtype and .index files); copy them into the database directory to use them
      in a search
    outputBinding:
      glob:
        - db_dir/*.idx
        - db_dir/*.idx.*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: db_dir
        entry: $(inputs.sequence_db)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
