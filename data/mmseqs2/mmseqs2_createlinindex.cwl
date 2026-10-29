cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - createlinindex
label: mmseqs2_createlinindex
doc: 'Create the index used by linsearch (a k-mer index with one entry per sequence).


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: sequence_db
    type: Directory
    doc: Input database (the index is built in a writable copy; the input is not changed)
    inputBinding:
      position: 1
      valueFrom: db_dir/$(inputs.sequence_db_name)
  - id: sequence_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: tmp_dir
    type: string
    doc: Temporary directory (created by the tool)
    inputBinding:
      position: 2
  - id: seed_sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file for k-mer generation
    inputBinding:
      position: 104
      prefix: --seed-sub-mat
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
  - id: alph_size
    type:
      - 'null'
      - string
    doc: Alphabet size (range 2-21)
    inputBinding:
      position: 104
      prefix: --alph-size
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
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity (for clustering) (range 0.0-1.0)
    inputBinding:
      position: 104
      prefix: --min-seq-id
  - id: hash_shift
    type:
      - 'null'
      - int
    doc: Shift k-mer hash initialization
    inputBinding:
      position: 104
      prefix: --hash-shift
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
  - id: ignore_multi_kmer
    type:
      - 'null'
      - int
    doc: Skip k-mers occurring multiple times (>=2) (0 or 1)
    inputBinding:
      position: 104
      prefix: --ignore-multi-kmer
  - id: check_compatible
    type:
      - 'null'
      - int
    doc: '0: Always recreate index, 1: Check if recreating index is needed, 2: Fail if index
      is incompatible'
    inputBinding:
      position: 104
      prefix: --check-compatible
  - id: search_type
    type:
      - 'null'
      - int
    doc: 'Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide
      alignment'
    inputBinding:
      position: 104
      prefix: --search-type
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
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    inputBinding:
      position: 104
      prefix: --max-seq-len
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
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
  - id: remove_tmp_files
    type:
      - 'null'
      - int
    doc: Delete temporary files (0 or 1)
    inputBinding:
      position: 104
      prefix: --remove-tmp-files
  - id: create_lookup
    type:
      - 'null'
      - int
    doc: Create database lookup file (can be very large)
    inputBinding:
      position: 104
      prefix: --create-lookup
outputs:
  - id: output_db
    type: Directory
    doc: Database directory holding the original database files plus the new index
    outputBinding:
      glob: db_dir
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: db_dir
        entry: $(inputs.sequence_db)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
