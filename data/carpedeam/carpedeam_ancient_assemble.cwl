cwlVersion: v1.2
class: CommandLineTool
baseCommand: carpedeam ancient_assemble
label: carpedeam_ancient_assemble
doc: "By Louis Kraft <lokraf@dtu.dk>\n\nTool homepage: https://github.com/LouisPwr/CarpeDeam"
inputs:
  - id: input_fastx_files
    type:
      type: array
      items: File
    doc: Input FASTQ or FASTA files (can be gzipped)
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
    doc: Add backtrace string (convert to alignments with mmseqs convertalis 
      module)
    default: 0
    inputBinding:
      position: 103
      prefix: -a
  - id: add_self_matches
    type:
      - 'null'
      - boolean
    doc: Artificially add entries of queries with themselves (for clustering)
    default: 0
    inputBinding:
      position: 103
      prefix: --add-self-matches
  - id: adjust_kmer_len
    type:
      - 'null'
      - boolean
    doc: Adjust k-mer length based on specificity (only for nucleotides)
    default: 0
    inputBinding:
      position: 103
      prefix: --adjust-kmer-len
  - id: alph_size
    type:
      - 'null'
      - string
    doc: Alphabet size (range 2-21)
    default: nucl:5,aa:13
    inputBinding:
      position: 103
      prefix: --alph-size
  - id: ancient_damage
    type:
      - 'null'
      - string
    doc: Path to damage matrix (ancient)
    default: ''
    inputBinding:
      position: 103
      prefix: --ancient-damage
  - id: chop_cycle
    type:
      - 'null'
      - boolean
    doc: Remove superfluous part of circular fragments (see --cycle-check)
    default: 1
    inputBinding:
      position: 103
      prefix: --chop-cycle
  - id: clust_min_cov
    type:
      - 'null'
      - float
    doc: Coverage threshold passed to linclust algorithm to reduce redundancy in
      assembly (range 0.0-1.0)
    default: 0.99
    inputBinding:
      position: 103
      prefix: --clust-min-cov
  - id: clust_min_seq_id
    type:
      - 'null'
      - float
    doc: Seq. id. threshold passed to linclust algorithm to reduce redundancy in
      assembly (range 0.0-1.0)
    default: 0.97
    inputBinding:
      position: 103
      prefix: --clust-min-seq-id
  - id: cluster_mode
    type:
      - 'null'
      - int
    doc: 'Clustering mode: 0: Set-Cover (greedy), 1: Connected component (BLASTclust),
      2,3: Greedy clustering by sequence length (CDHIT)'
    default: 2
    inputBinding:
      position: 103
      prefix: --cluster-mode
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    default: 0
    inputBinding:
      position: 103
      prefix: --compressed
  - id: contig_output_mode
    type:
      - 'null'
      - int
    doc: 'Type of contigs: 0: all, 1: only extended'
    default: 1
    inputBinding:
      position: 103
      prefix: --contig-output-mode
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: Coverage mode for alignment
    default: 1
    inputBinding:
      position: 103
      prefix: --cov-mode
  - id: create_lookup
    type:
      - 'null'
      - int
    doc: Create database lookup file (can be very large)
    default: 0
    inputBinding:
      position: 103
      prefix: --create-lookup
  - id: createdb_mode
    type:
      - 'null'
      - int
    doc: 'Createdb mode 0: copy data, 1: soft link data and write new index (works
      only with single line fasta/q)'
    default: 0
    inputBinding:
      position: 103
      prefix: --createdb-mode
  - id: cycle_check
    type:
      - 'null'
      - boolean
    doc: Check for circular sequences (avoid over extension of circular or long 
      repeated regions)
    default: 1
    inputBinding:
      position: 103
      prefix: --cycle-check
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch'
    default: 0
    inputBinding:
      position: 103
      prefix: --db-load-mode
  - id: db_mode
    type:
      - 'null'
      - boolean
    doc: Input is database
    default: 0
    inputBinding:
      position: 103
      prefix: --db-mode
  - id: dbtype
    type:
      - 'null'
      - int
    doc: 'Database type 0: auto, 1: amino acid 2: nucleotides'
    default: 0
    inputBinding:
      position: 103
      prefix: --dbtype
  - id: delete_tmp_inc
    type:
      - 'null'
      - int
    doc: Delete temporary files incremental [0,1]
    default: 1
    inputBinding:
      position: 103
      prefix: --delete-tmp-inc
  - id: excess_penalty
    type:
      - 'null'
      - float
    doc: 'Use float: 0.25 to 0.5 (ancient)'
    default: 0.062
    inputBinding:
      position: 103
      prefix: --excess-penalty
  - id: ext_random_align
    type:
      - 'null'
      - float
    doc: 'Use either: 0.8 or 0.9 (ancient)'
    default: 0.85
    inputBinding:
      position: 103
      prefix: --ext-random-align
  - id: extend_evalue
    type:
      - 'null'
      - float
    doc: Extend sequences if the E-value is below (range 0.0-inf)
    default: '1.000E-03'
    inputBinding:
      position: 103
      prefix: -e
  - id: filter_hits
    type:
      - 'null'
      - boolean
    doc: Filter hits by seq.id. and coverage
    default: 0
    inputBinding:
      position: 103
      prefix: --filter-hits
  - id: forward_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the forward strand to be extracted
    default: 1,2,3
    inputBinding:
      position: 103
      prefix: --forward-frames
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: Gap extend cost (only for clustering)
    default: '2'
    inputBinding:
      position: 103
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - string
    doc: Gap open cost (only for clustering)
    default: '5'
    inputBinding:
      position: 103
      prefix: --gap-open
  - id: hash_shift
    type:
      - 'null'
      - int
    doc: Shift k-mer hash initialization
    default: 67
    inputBinding:
      position: 103
      prefix: --hash-shift
  - id: id_offset
    type:
      - 'null'
      - int
    doc: Numeric ids in index file are offset by this value
    default: 0
    inputBinding:
      position: 103
      prefix: --id-offset
  - id: ignore_multi_kmer
    type:
      - 'null'
      - boolean
    doc: Skip k-mers occurring multiple times (>=2)
    default: 1
    inputBinding:
      position: 103
      prefix: --ignore-multi-kmer
  - id: include_only_extendable
    type:
      - 'null'
      - boolean
    doc: Include only extendable
    default: 1
    inputBinding:
      position: 103
      prefix: --include-only-extendable
  - id: k_ancient_contigs
    type:
      - 'null'
      - int
    doc: k-mer length contig step (ancient)
    default: 22
    inputBinding:
      position: 103
      prefix: --k-ancient-contigs
  - id: k_ancient_reads
    type:
      - 'null'
      - int
    doc: k-mer length read step (ancient)
    default: 20
    inputBinding:
      position: 103
      prefix: --k-ancient-reads
  - id: keep_target
    type:
      - 'null'
      - boolean
    doc: Keep target sequences
    default: 1
    inputBinding:
      position: 103
      prefix: --keep-target
  - id: kmer_length
    type:
      - 'null'
      - string
    doc: 'k-mer length (0: automatically set to optimum)'
    default: nucl:20,aa:14
    inputBinding:
      position: 103
      prefix: -k
  - id: kmer_per_seq
    type:
      - 'null'
      - int
    doc: k-mers per sequence
    default: 200
    inputBinding:
      position: 103
      prefix: --kmer-per-seq
  - id: kmer_per_seq_scale
    type:
      - 'null'
      - string
    doc: Scale k-mer per sequence based on sequence length as kmer-per-seq val +
      scale x seqlen
    default: '0.200'
    inputBinding:
      position: 103
      prefix: --kmer-per-seq-scale
  - id: likelihood_ratio_threshold
    type:
      - 'null'
      - float
    doc: Min. odds ratio to accept read extension. Range 0-1 (ancient)
    default: 0.5
    inputBinding:
      position: 103
      prefix: --likelihood-ratio-threshold
  - id: mask
    type:
      - 'null'
      - int
    doc: 'Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low
      complexity masking'
    default: 0
    inputBinding:
      position: 103
      prefix: --mask
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: 'Lowercase letters will be excluded from k-mer search 0: include region,
      1: exclude region'
    default: 0
    inputBinding:
      position: 103
      prefix: --mask-lower-case
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum codon number in open reading frames
    default: 32734
    inputBinding:
      position: 103
      prefix: --max-length
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    default: 200000
    inputBinding:
      position: 103
      prefix: --max-seq-len
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length (range 0-INT_MAX)
    default: 0
    inputBinding:
      position: 103
      prefix: --min-aln-len
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: Minimum length of assembled contig to output
    default: 500
    inputBinding:
      position: 103
      prefix: --min-contig-len
  - id: min_cov_safe
    type:
      - 'null'
      - int
    doc: Minimum coverage of extending region (ancient)
    default: 5
    inputBinding:
      position: 103
      prefix: --min-cov-safe
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum codon number in open reading frames
    default: 45
    inputBinding:
      position: 103
      prefix: --min-length
  - id: min_merge_seq_id
    type:
      - 'null'
      - float
    doc: Min. seq. ident. of contig overlaps (ancient) (range 0.0-1.0)
    default: 0.99
    inputBinding:
      position: 103
      prefix: --min-merge-seq-id
  - id: min_ryseq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity in RY-mer space (ancient) 
      (range 0.0-1.0)
    default: 0.99
    inputBinding:
      position: 103
      prefix: --min-ryseq-id
  - id: min_ryseq_id_corr_reads
    type:
      - 'null'
      - float
    doc: Min. RY-mer space seq. ident in correction phase. Range 0-1 (ancient)
    default: 0.99
    inputBinding:
      position: 103
      prefix: --min-ryseq-id-corr-reads
  - id: min_seq_id
    type:
      - 'null'
      - string
    doc: Overlap sequence identity threshold (range 0.0-1.0)
    default: nucl:0.900,aa:0.970
    inputBinding:
      position: 103
      prefix: --min-seq-id
  - id: min_seqid_corr_contigs
    type:
      - 'null'
      - float
    doc: Min. seq. ident. for contig correction (ancient) (range 0.0-1.0)
    default: 0.9
    inputBinding:
      position: 103
      prefix: --min-seqid-corr-contigs
  - id: min_seqid_corr_reads
    type:
      - 'null'
      - float
    doc: Min. seq. ident. in correction phase. Range 0-1 (ancient)
    default: 0.9
    inputBinding:
      position: 103
      prefix: --min-seqid-corr-reads
  - id: mpi_runner
    type:
      - 'null'
      - string
    doc: Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42")
    default: ''
    inputBinding:
      position: 103
      prefix: --mpi-runner
  - id: num_iter_reads_only
    type:
      - 'null'
      - int
    doc: 'Raw reads only: Number of assembly iterations performed on nucleotide level
      (ancient)'
    default: 5
    inputBinding:
      position: 103
      prefix: --num-iter-reads-only
  - id: num_iterations
    type:
      - 'null'
      - string
    doc: Number of assembly total iterations performed on nucleotide level 
      (ignore protein level for ancient) (range 1-inf)
    default: nucl:10,aa:1
    inputBinding:
      position: 103
      prefix: --num-iterations
  - id: remove_tmp_files
    type:
      - 'null'
      - boolean
    doc: Delete temporary files
    default: 0
    inputBinding:
      position: 103
      prefix: --remove-tmp-files
  - id: rescore_mode
    type:
      - 'null'
      - int
    doc: 'Rescore diagonals with:'
    default: 3
    inputBinding:
      position: 103
      prefix: --rescore-mode
  - id: reverse_frames
    type:
      - 'null'
      - string
    doc: Comma-separated list of frames on the reverse strand to be extracted
    default: 1,2,3
    inputBinding:
      position: 103
      prefix: --reverse-frames
  - id: seq_id_mode
    type:
      - 'null'
      - int
    doc: 'Sequence identity mode: 0: alignment length 1: shorter, 2: longer sequence'
    default: 0
    inputBinding:
      position: 103
      prefix: --seq-id-mode
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: Shuffle input database
    default: 1
    inputBinding:
      position: 103
      prefix: --shuffle
  - id: sort_results
    type:
      - 'null'
      - int
    doc: 'Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming)'
    default: 0
    inputBinding:
      position: 103
      prefix: --sort-results
  - id: spaced_kmer_mode
    type:
      - 'null'
      - int
    doc: '0: use consecutive positions in k-mers; 1: use spaced k-mers'
    default: 0
    inputBinding:
      position: 103
      prefix: --spaced-kmer-mode
  - id: spaced_kmer_pattern
    type:
      - 'null'
      - string
    doc: User-specified spaced k-mer pattern
    default: ''
    inputBinding:
      position: 103
      prefix: --spaced-kmer-pattern
  - id: split_memory_limit
    type:
      - 'null'
      - string
    doc: Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all 
      available system memory
    default: '0'
    inputBinding:
      position: 103
      prefix: --split-memory-limit
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    default: nucl:nucleotide.out,aa:blosum62.out
    inputBinding:
      position: 103
      prefix: --sub-mat
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    default: 20
    inputBinding:
      position: 103
      prefix: --threads
  - id: translate
    type:
      - 'null'
      - boolean
    doc: Translate ORF to amino acid
    default: 0
    inputBinding:
      position: 103
      prefix: --translate
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Genetic code table
    default: 1
    inputBinding:
      position: 103
      prefix: --translation-table
  - id: unsafe
    type:
      - 'null'
      - boolean
    doc: Maximize the contig length, but higher misassembly rate (ancient)
    default: 0
    inputBinding:
      position: 103
      prefix: --unsafe
  - id: use_all_table_starts
    type:
      - 'null'
      - boolean
    doc: Use all alternatives for a start codon in the genetic table, if false -
      only ATG (AUG)
    default: 0
    inputBinding:
      position: 103
      prefix: --use-all-table-starts
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    default: 3
    inputBinding:
      position: 103
      prefix: -v
  - id: write_lookup
    type:
      - 'null'
      - int
    doc: write .lookup file containing mapping from internal id, fasta id and 
      file number
    default: 1
    inputBinding:
      position: 103
      prefix: --write-lookup
  - id: zdrop
    type:
      - 'null'
      - int
    doc: Maximal allowed difference between score values before alignment is 
      truncated (only for clustering)
    default: 200
    inputBinding:
      position: 103
      prefix: --zdrop
outputs:
  - id: output_fasta_file
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carpedeam:1.0.1--hd6d6fdc_0
