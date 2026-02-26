cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - carpedeam
  - nuclassemble
label: carpedeam_nuclassemble
doc: "By Louis Kraft <lokraf@dtu.dk> and Annika Jochheim <annika.jochheim@mpinat.mpg.de>\n\
  \nTool homepage: https://github.com/LouisPwr/CarpeDeam"
inputs:
  - id: input_fastq_pairs
    type:
      type: array
      items: File
    doc: Input FASTQ paired-end files (can be gzipped)
    inputBinding:
      position: 1
  - id: input_fastx_files
    type:
      type: array
      items: File
    doc: Input FASTQ/FASTA files (can be gzipped)
    inputBinding:
      position: 2
  - id: temporary_directory
    type: Directory
    doc: Temporary directory for intermediate files
    inputBinding:
      position: 3
  - id: add_backtrace
    type:
      - 'null'
      - boolean
    doc: Add backtrace string (convert to alignments with mmseqs convertalis 
      module)
    default: false
    inputBinding:
      position: 104
      prefix: -a
  - id: add_self_matches
    type:
      - 'null'
      - boolean
    doc: Artificially add entries of queries with themselves (for clustering)
    default: false
    inputBinding:
      position: 104
      prefix: --add-self-matches
  - id: adjust_kmer_len
    type:
      - 'null'
      - boolean
    doc: Adjust k-mer length based on specificity (only for nucleotides)
    default: false
    inputBinding:
      position: 104
      prefix: --adjust-kmer-len
  - id: aligned_residues_fraction
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see 
      --cov-mode)
    default: 0.0
    inputBinding:
      position: 104
      prefix: -c
  - id: alph_size
    type:
      - 'null'
      - string
    doc: Alphabet size (range 2-21)
    default: 5
    inputBinding:
      position: 104
      prefix: --alph-size
  - id: ancient_damage
    type:
      - 'null'
      - string
    doc: Path to damage matrix (ancient)
    default: ''
    inputBinding:
      position: 104
      prefix: --ancient-damage
  - id: chop_cycle
    type:
      - 'null'
      - boolean
    doc: Remove superfluous part of circular fragments (see --cycle-check)
    default: true
    inputBinding:
      position: 104
      prefix: --chop-cycle
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    default: 0
    inputBinding:
      position: 104
      prefix: --compressed
  - id: contig_output_mode
    type:
      - 'null'
      - int
    doc: "Type of contigs:\n                                    0: all\n         \
      \                           1: only extended"
    default: 1
    inputBinding:
      position: 104
      prefix: --contig-output-mode
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: "0: coverage of query and target\n                                    1:
      coverage of target\n                                    2: coverage of query\n\
      \                                    3: target seq. length has to be at least
      x% of query length\n                                    4: query seq. length
      has to be at least x% of target length\n                                   \
      \ 5: short seq. needs to be at least x% of the other seq. length"
    default: 0
    inputBinding:
      position: 104
      prefix: --cov-mode
  - id: createdb_mode
    type:
      - 'null'
      - int
    doc: 'Createdb mode 0: copy data, 1: soft link data and write new index (works
      only with single line fasta/q)'
    default: 0
    inputBinding:
      position: 104
      prefix: --createdb-mode
  - id: cycle_check
    type:
      - 'null'
      - boolean
    doc: Check for circular sequences (avoid over extension of circular or long 
      repeated regions)
    default: true
    inputBinding:
      position: 104
      prefix: --cycle-check
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch'
    default: 0
    inputBinding:
      position: 104
      prefix: --db-load-mode
  - id: db_mode
    type:
      - 'null'
      - boolean
    doc: Input is database
    default: false
    inputBinding:
      position: 104
      prefix: --db-mode
  - id: dbtype
    type:
      - 'null'
      - int
    doc: 'Database type 0: auto, 1: amino acid 2: nucleotides'
    default: 0
    inputBinding:
      position: 104
      prefix: --dbtype
  - id: delete_tmp_inc
    type:
      - 'null'
      - int
    doc: Delete temporary files incremental [0,1]
    default: 1
    inputBinding:
      position: 104
      prefix: --delete-tmp-inc
  - id: excess_penalty
    type:
      - 'null'
      - float
    doc: 'Use float: 0.25 to 0.5 (ancient)'
    default: 0.062
    inputBinding:
      position: 104
      prefix: --excess-penalty
  - id: ext_random_align
    type:
      - 'null'
      - float
    doc: 'Use either: 0.8 or 0.9 (ancient)'
    default: 0.85
    inputBinding:
      position: 104
      prefix: --ext-random-align
  - id: extend_evalue
    type:
      - 'null'
      - double
    doc: Extend sequences if the E-value is below (range 0.0-inf)
    default: 0.001
    inputBinding:
      position: 104
      prefix: -e
  - id: filter_hits
    type:
      - 'null'
      - boolean
    doc: Filter hits by seq.id. and coverage
    default: false
    inputBinding:
      position: 104
      prefix: --filter-hits
  - id: hash_shift
    type:
      - 'null'
      - int
    doc: Shift k-mer hash initialization
    default: 67
    inputBinding:
      position: 104
      prefix: --hash-shift
  - id: id_offset
    type:
      - 'null'
      - int
    doc: Numeric ids in index file are offset by this value
    default: 0
    inputBinding:
      position: 104
      prefix: --id-offset
  - id: ignore_multi_kmer
    type:
      - 'null'
      - boolean
    doc: Skip k-mers occurring multiple times (>=2)
    default: true
    inputBinding:
      position: 104
      prefix: --ignore-multi-kmer
  - id: include_only_extendable
    type:
      - 'null'
      - boolean
    doc: Include only extendable
    default: false
    inputBinding:
      position: 104
      prefix: --include-only-extendable
  - id: k_ancient_contigs
    type:
      - 'null'
      - int
    doc: k-mer length contig step (ancient)
    default: 22
    inputBinding:
      position: 104
      prefix: --k-ancient-contigs
  - id: k_ancient_reads
    type:
      - 'null'
      - int
    doc: k-mer length read step (ancient)
    default: 20
    inputBinding:
      position: 104
      prefix: --k-ancient-reads
  - id: keep_target
    type:
      - 'null'
      - boolean
    doc: Keep target sequences
    default: true
    inputBinding:
      position: 104
      prefix: --keep-target
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'k-mer length (0: automatically set to optimum)'
    default: 22
    inputBinding:
      position: 104
      prefix: -k
  - id: kmer_per_seq
    type:
      - 'null'
      - int
    doc: k-mers per sequence
    default: 200
    inputBinding:
      position: 104
      prefix: --kmer-per-seq
  - id: kmer_per_seq_scale
    type:
      - 'null'
      - string
    doc: Scale k-mer per sequence based on sequence length as kmer-per-seq val +
      scale x seqlen
    default: '0.200'
    inputBinding:
      position: 104
      prefix: --kmer-per-seq-scale
  - id: likelihood_ratio_threshold
    type:
      - 'null'
      - float
    doc: Min. odds ratio to accept read extension. Range 0-1 (ancient)
    default: 0.5
    inputBinding:
      position: 104
      prefix: --likelihood-ratio-threshold
  - id: mask
    type:
      - 'null'
      - int
    doc: 'Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low
      complexity masking'
    default: 0
    inputBinding:
      position: 104
      prefix: --mask
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: 'Lowercase letters will be excluded from k-mer search 0: include region,
      1: exclude region'
    default: 0
    inputBinding:
      position: 104
      prefix: --mask-lower-case
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    default: 300000
    inputBinding:
      position: 104
      prefix: --max-seq-len
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length (range 0-INT_MAX)
    default: 0
    inputBinding:
      position: 104
      prefix: --min-aln-len
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: Minimum length of assembled contig to output
    default: 500
    inputBinding:
      position: 104
      prefix: --min-contig-len
  - id: min_cov_safe
    type:
      - 'null'
      - int
    doc: Minimum coverage of extending region (ancient)
    default: 5
    inputBinding:
      position: 104
      prefix: --min-cov-safe
  - id: min_merge_seq_id
    type:
      - 'null'
      - float
    doc: Min. seq. ident. of contig overlaps (ancient) (range 0.0-1.0)
    default: 0.99
    inputBinding:
      position: 104
      prefix: --min-merge-seq-id
  - id: min_ryseq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity in RY-mer space (ancient) 
      (range 0.0-1.0)
    default: 0.99
    inputBinding:
      position: 104
      prefix: --min-ryseq-id
  - id: min_ryseq_id_corr_reads
    type:
      - 'null'
      - float
    doc: Min. RY-mer space seq. ident in correction phase. Range 0-1 (ancient)
    default: 0.99
    inputBinding:
      position: 104
      prefix: --min-ryseq-id-corr-reads
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: Overlap sequence identity threshold (range 0.0-1.0)
    default: 0.9
    inputBinding:
      position: 104
      prefix: --min-seq-id
  - id: min_seqid_corr_contigs
    type:
      - 'null'
      - float
    doc: Min. seq. ident. for contig correction (ancient) (range 0.0-1.0)
    default: 0.9
    inputBinding:
      position: 104
      prefix: --min-seqid-corr-contigs
  - id: min_seqid_corr_reads
    type:
      - 'null'
      - float
    doc: Min. seq. ident. in correction phase. Range 0-1 (ancient)
    default: 0.9
    inputBinding:
      position: 104
      prefix: --min-seqid-corr-reads
  - id: mpi_runner
    type:
      - 'null'
      - string
    doc: Use MPI on compute cluster with this MPI command (e.g. "mpirun -np 42")
    default: ''
    inputBinding:
      position: 104
      prefix: --mpi-runner
  - id: num_iter_reads_only
    type:
      - 'null'
      - int
    doc: 'Raw reads only: Number of assembly iterations performed on nucleotide level
      (ancient)'
    default: 4
    inputBinding:
      position: 104
      prefix: --num-iter-reads-only
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: Number of assembly iterations (range 1-inf)
    default: 10
    inputBinding:
      position: 104
      prefix: --num-iterations
  - id: remove_tmp_files
    type:
      - 'null'
      - boolean
    doc: Delete temporary files
    default: false
    inputBinding:
      position: 104
      prefix: --remove-tmp-files
  - id: rescore_mode
    type:
      - 'null'
      - int
    doc: "Rescore diagonals with:\n                                    0: Hamming
      distance\n                                    1: local alignment (score only)\n\
      \                                    2: local alignment\n                  \
      \                  3: global alignment\n                                   \
      \ 4: longest alignment fulfilling window quality criterion"
    default: 3
    inputBinding:
      position: 104
      prefix: --rescore-mode
  - id: seq_id_mode
    type:
      - 'null'
      - int
    doc: '0: alignment length 1: shorter, 2: longer sequence'
    default: 0
    inputBinding:
      position: 104
      prefix: --seq-id-mode
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: Shuffle input database
    default: true
    inputBinding:
      position: 104
      prefix: --shuffle
  - id: sort_results
    type:
      - 'null'
      - int
    doc: 'Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming)'
    default: 0
    inputBinding:
      position: 104
      prefix: --sort-results
  - id: spaced_kmer_mode
    type:
      - 'null'
      - int
    doc: '0: use consecutive positions in k-mers; 1: use spaced k-mers'
    default: 0
    inputBinding:
      position: 104
      prefix: --spaced-kmer-mode
  - id: spaced_kmer_pattern
    type:
      - 'null'
      - string
    doc: User-specified spaced k-mer pattern
    default: ''
    inputBinding:
      position: 104
      prefix: --spaced-kmer-pattern
  - id: split_memory_limit
    type:
      - 'null'
      - string
    doc: Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all 
      available system memory
    default: '0'
    inputBinding:
      position: 104
      prefix: --split-memory-limit
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    default: nucl:nucleotide.out,aa:blosum62.out
    inputBinding:
      position: 104
      prefix: --sub-mat
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    default: 20
    inputBinding:
      position: 104
      prefix: --threads
  - id: unsafe
    type:
      - 'null'
      - boolean
    doc: Maximize the contig length, but higher misassembly rate (ancient)
    default: false
    inputBinding:
      position: 104
      prefix: --unsafe
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    default: 3
    inputBinding:
      position: 104
      prefix: -v
  - id: wrapped_scoring
    type:
      - 'null'
      - boolean
    doc: Double the (nucleotide) query sequence during the scoring process to 
      allow wrapped diagonal scoring around end and start
    default: false
    inputBinding:
      position: 104
      prefix: --wrapped-scoring
  - id: write_lookup
    type:
      - 'null'
      - int
    doc: write .lookup file containing mapping from internal id, fasta id and 
      file number
    default: 1
    inputBinding:
      position: 104
      prefix: --write-lookup
outputs:
  - id: output_fasta_file
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/carpedeam:1.0.1--hd6d6fdc_0
