cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plass
  - assemble
label: plass_assemble
doc: "Protein-level assembly of metagenomic samples\n\nTool homepage: https://github.com/soedinglab/plass"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTA/FASTQ files (single or paired-end)
    inputBinding:
      position: 1
  - id: tmp_dir
    type: Directory
    doc: Temporary directory
    inputBinding:
      position: 2
  - id: add_backtrace
    type:
      - 'null'
      - boolean
    doc: Add backtrace string
    inputBinding:
      position: 103
      prefix: -a
  - id: add_self_matches
    type:
      - 'null'
      - boolean
    doc: Artificially add entries of queries with themselves (for clustering)
    inputBinding:
      position: 103
      prefix: --add-self-matches
  - id: adjust_kmer_len
    type:
      - 'null'
      - boolean
    doc: Adjust k-mer length based on specificity (only for nucleotides)
    inputBinding:
      position: 103
      prefix: --adjust-kmer-len
  - id: alph_size
    type:
      - 'null'
      - string
    doc: Alphabet size (range 2-21)
    inputBinding:
      position: 103
      prefix: --alph-size
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 103
      prefix: --compressed
  - id: contig_end_mode
    type:
      - 'null'
      - int
    doc: 'Contig end can be 0: incomplete, 1: complete, 2: both'
    inputBinding:
      position: 103
      prefix: --contig-end-mode
  - id: contig_start_mode
    type:
      - 'null'
      - int
    doc: 'Contig start can be 0: incomplete, 1: complete, 2: both'
    inputBinding:
      position: 103
      prefix: --contig-start-mode
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: Coverage mode (0-5)
    inputBinding:
      position: 103
      prefix: --cov-mode
  - id: coverage
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues
    inputBinding:
      position: 103
      prefix: -c
  - id: create_lookup
    type:
      - 'null'
      - int
    doc: Create database lookup file
    inputBinding:
      position: 103
      prefix: --create-lookup
  - id: createdb_mode
    type:
      - 'null'
      - int
    doc: 'Createdb mode 0: copy data, 1: soft link data'
    inputBinding:
      position: 103
      prefix: --createdb-mode
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch'
    inputBinding:
      position: 103
      prefix: --db-load-mode
  - id: dbtype
    type:
      - 'null'
      - int
    doc: 'Database type 0: auto, 1: amino acid 2: nucleotides'
    inputBinding:
      position: 103
      prefix: --dbtype
  - id: delete_tmp_inc
    type:
      - 'null'
      - int
    doc: Delete temporary files incremental
    inputBinding:
      position: 103
      prefix: --delete-tmp-inc
  - id: e_value
    type:
      - 'null'
      - float
    doc: Extend sequences if the E-value is below
    inputBinding:
      position: 103
      prefix: -e
  - id: filter_hits
    type:
      - 'null'
      - boolean
    doc: Filter hits by seq.id. and coverage
    inputBinding:
      position: 103
      prefix: --filter-hits
  - id: filter_proteins
    type:
      - 'null'
      - int
    doc: filter proteins by a neural network
    inputBinding:
      position: 103
      prefix: --filter-proteins
  - id: forward_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the forward strand
    inputBinding:
      position: 103
      prefix: --forward-frames
  - id: hash_shift
    type:
      - 'null'
      - int
    doc: Shift k-mer hash initialization
    inputBinding:
      position: 103
      prefix: --hash-shift
  - id: id_offset
    type:
      - 'null'
      - int
    doc: Numeric ids in index file are offset by this value
    inputBinding:
      position: 103
      prefix: --id-offset
  - id: ignore_multi_kmer
    type:
      - 'null'
      - boolean
    doc: Skip k-mers occurring multiple times (>=2)
    inputBinding:
      position: 103
      prefix: --ignore-multi-kmer
  - id: include_only_extendable
    type:
      - 'null'
      - boolean
    doc: Include only extendable
    inputBinding:
      position: 103
      prefix: --include-only-extendable
  - id: keep_target
    type:
      - 'null'
      - boolean
    doc: Keep target sequences
    inputBinding:
      position: 103
      prefix: --keep-target
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'k-mer length (0: automatically set to optimum)'
    inputBinding:
      position: 103
      prefix: -k
  - id: kmer_per_seq
    type:
      - 'null'
      - int
    doc: k-mers per sequence
    inputBinding:
      position: 103
      prefix: --kmer-per-seq
  - id: kmer_per_seq_scale
    type:
      - 'null'
      - string
    doc: Scale k-mer per sequence based on sequence length
    inputBinding:
      position: 103
      prefix: --kmer-per-seq-scale
  - id: mask
    type:
      - 'null'
      - int
    doc: 'Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low
      complexity masking'
    inputBinding:
      position: 103
      prefix: --mask
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: 'Lowercase letters will be excluded from k-mer search 0: include region,
      1: exclude region'
    inputBinding:
      position: 103
      prefix: --mask-lower-case
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: Maximum number of codons with gaps or unknown residues
    inputBinding:
      position: 103
      prefix: --max-gaps
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum codon number in open reading frames
    inputBinding:
      position: 103
      prefix: --max-length
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    inputBinding:
      position: 103
      prefix: --max-seq-len
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length
    inputBinding:
      position: 103
      prefix: --min-aln-len
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum codon number in open reading frames
    inputBinding:
      position: 103
      prefix: --min-length
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: Overlap sequence identity threshold [0.0, 1.0]
    inputBinding:
      position: 103
      prefix: --min-seq-id
  - id: mpi_runner
    type:
      - 'null'
      - string
    doc: Use MPI on compute cluster with this MPI command
    inputBinding:
      position: 103
      prefix: --mpi-runner
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: Number of assembly iterations
    inputBinding:
      position: 103
      prefix: --num-iterations
  - id: orf_start_mode
    type:
      - 'null'
      - int
    doc: Orf fragment start mode (0-2)
    inputBinding:
      position: 103
      prefix: --orf-start-mode
  - id: protein_filter_threshold
    type:
      - 'null'
      - float
    doc: filter proteins lower than threshold
    inputBinding:
      position: 103
      prefix: --protein-filter-threshold
  - id: remove_tmp_files
    type:
      - 'null'
      - boolean
    doc: Delete temporary files
    inputBinding:
      position: 103
      prefix: --remove-tmp-files
  - id: rescore_mode
    type:
      - 'null'
      - int
    doc: Rescore diagonals mode (0-4)
    inputBinding:
      position: 103
      prefix: --rescore-mode
  - id: reverse_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the reverse strand
    inputBinding:
      position: 103
      prefix: --reverse-frames
  - id: seq_id_mode
    type:
      - 'null'
      - int
    doc: '0: alignment length 1: shorter, 2: longer sequence'
    inputBinding:
      position: 103
      prefix: --seq-id-mode
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: Shuffle input database
    inputBinding:
      position: 103
      prefix: --shuffle
  - id: sort_results
    type:
      - 'null'
      - int
    doc: 'Sort results: 0: no sorting, 1: sort by E-value or seq.id.'
    inputBinding:
      position: 103
      prefix: --sort-results
  - id: spaced_kmer_mode
    type:
      - 'null'
      - int
    doc: '0: use consecutive positions in k-mers; 1: use spaced k-mers'
    inputBinding:
      position: 103
      prefix: --spaced-kmer-mode
  - id: spaced_kmer_pattern
    type:
      - 'null'
      - string
    doc: User-specified spaced k-mer pattern
    inputBinding:
      position: 103
      prefix: --spaced-kmer-pattern
  - id: split_memory_limit
    type:
      - 'null'
      - string
    doc: Set max memory per split. E.g. 800B, 5K, 10M, 1G
    inputBinding:
      position: 103
      prefix: --split-memory-limit
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    inputBinding:
      position: 103
      prefix: --sub-mat
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used
    inputBinding:
      position: 103
      prefix: --threads
  - id: translate
    type:
      - 'null'
      - int
    doc: Translate ORF to amino acid
    inputBinding:
      position: 103
      prefix: --translate
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Genetic code translation table
    inputBinding:
      position: 103
      prefix: --translation-table
  - id: use_all_table_starts
    type:
      - 'null'
      - boolean
    doc: Use all alternatives for a start codon in the genetic table
    inputBinding:
      position: 103
      prefix: --use-all-table-starts
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 103
      prefix: -v
  - id: wrapped_scoring
    type:
      - 'null'
      - boolean
    doc: Double the (nucleotide) query sequence during the scoring process to allow
      wrapped diagonal scoring
    inputBinding:
      position: 103
      prefix: --wrapped-scoring
  - id: write_lookup
    type:
      - 'null'
      - int
    doc: write .lookup file containing mapping from internal id, fasta id and file
      number
    inputBinding:
      position: 103
      prefix: --write-lookup
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plass:5.cf8933--hd6d6fdc_3
