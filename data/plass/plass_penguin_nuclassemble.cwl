cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - penguin
  - nuclassemble
label: plass_penguin_nuclassemble
doc: "Assemble nucleotide sequences by iterative greedy overlap assembly using nucleotide information only.\n\nTool homepage: https://github.com/soedinglab/plass"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTA/FASTQ file, or paired FASTQ files (fastqFile1_1 fastqFile1_2 ...)
    inputBinding:
      position: 1
  - id: fasta_file
    type: string
    doc: Output FASTA file
    inputBinding:
      position: 2
  - id: tmp_dir
    type: string
    doc: Temporary directory
    inputBinding:
      position: 3
  - id: alph_size
    type:
      - 'null'
      - string
    doc: 'Alphabet size (range 2-21) [5]'
    inputBinding:
      position: 103
      prefix: --alph-size
  - id: spaced_kmer_mode
    type:
      - 'null'
      - int
    doc: '0: use consecutive positions in k-mers; 1: use spaced k-mers [0]'
    inputBinding:
      position: 103
      prefix: --spaced-kmer-mode
  - id: spaced_kmer_pattern
    type:
      - 'null'
      - string
    doc: 'User-specified spaced k-mer pattern []'
    inputBinding:
      position: 103
      prefix: --spaced-kmer-pattern
  - id: mask
    type:
      - 'null'
      - int
    doc: 'Mask sequences in k-mer stage: 0: w/o low complexity masking, 1: with low complexity masking [0]'
    inputBinding:
      position: 103
      prefix: --mask
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: 'Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude region [0]'
    inputBinding:
      position: 103
      prefix: --mask-lower-case
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: 'k-mer length (0: automatically set to optimum) [22]'
    inputBinding:
      position: 103
      prefix: -k
  - id: split_memory_limit
    type:
      - 'null'
      - string
    doc: 'Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system memory [0]'
    inputBinding:
      position: 103
      prefix: --split-memory-limit
  - id: add_self_matches
    type:
      - 'null'
      - boolean
    doc: 'Artificially add entries of queries with themselves (for clustering) [0]'
    inputBinding:
      position: 103
      prefix: --add-self-matches
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: 'Overlap sequence identity threshold (range 0.0-1.0) [0.990]'
    inputBinding:
      position: 103
      prefix: --min-seq-id
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: '0: coverage of query and target 1: coverage of target 2: coverage of query 3: target seq. length has to be at least x% of query length 4: query seq. length has to be at least x% of target length 5: short seq. needs to be at least x% of the other seq. length [0]'
    inputBinding:
      position: 103
      prefix: --cov-mode
  - id: coverage
    type:
      - 'null'
      - float
    doc: 'List matches above this fraction of aligned (covered) residues (see --cov-mode) [0.000]'
    inputBinding:
      position: 103
      prefix: -c
  - id: wrapped_scoring
    type:
      - 'null'
      - boolean
    doc: 'Double the (nucleotide) query sequence during the scoring process to allow wrapped diagonal scoring around end and start [0]'
    inputBinding:
      position: 103
      prefix: --wrapped-scoring
  - id: e_value
    type:
      - 'null'
      - float
    doc: 'Extend sequences if the E-value is below (range 0.0-inf) [1.000E-05]'
    inputBinding:
      position: 103
      prefix: -e
  - id: add_backtrace
    type:
      - 'null'
      - boolean
    doc: 'Add backtrace string (convert to alignments with mmseqs convertalis module) [0]'
    inputBinding:
      position: 103
      prefix: -a
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: 'Minimum alignment length (range 0-INT_MAX) [0]'
    inputBinding:
      position: 103
      prefix: --min-aln-len
  - id: seq_id_mode
    type:
      - 'null'
      - int
    doc: '0: alignment length 1: shorter, 2: longer sequence [0]'
    inputBinding:
      position: 103
      prefix: --seq-id-mode
  - id: kmer_per_seq
    type:
      - 'null'
      - int
    doc: 'k-mers per sequence [60]'
    inputBinding:
      position: 103
      prefix: --kmer-per-seq
  - id: kmer_per_seq_scale
    type:
      - 'null'
      - string
    doc: 'Scale k-mer per sequence based on sequence length as kmer-per-seq val + scale x seqlen [0.100]'
    inputBinding:
      position: 103
      prefix: --kmer-per-seq-scale
  - id: adjust_kmer_len
    type:
      - 'null'
      - boolean
    doc: 'Adjust k-mer length based on specificity (only for nucleotides) [0]'
    inputBinding:
      position: 103
      prefix: --adjust-kmer-len
  - id: hash_shift
    type:
      - 'null'
      - int
    doc: 'Shift k-mer hash initialization [67]'
    inputBinding:
      position: 103
      prefix: --hash-shift
  - id: include_only_extendable
    type:
      - 'null'
      - boolean
    doc: 'Include only extendable [1]'
    inputBinding:
      position: 103
      prefix: --include-only-extendable
  - id: ignore_multi_kmer
    type:
      - 'null'
      - boolean
    doc: 'Skip k-mers occurring multiple times (>=2) [1]'
    inputBinding:
      position: 103
      prefix: --ignore-multi-kmer
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: 'Number of assembly iterations (range 1-inf) [8]'
    inputBinding:
      position: 103
      prefix: --num-iterations
  - id: dbtype
    type:
      - 'null'
      - int
    doc: 'Database type 0: auto, 1: amino acid 2: nucleotides [0]'
    inputBinding:
      position: 103
      prefix: --dbtype
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: 'Shuffle input database [1]'
    inputBinding:
      position: 103
      prefix: --shuffle
  - id: createdb_mode
    type:
      - 'null'
      - int
    doc: 'Createdb mode 0: copy data, 1: soft link data and write new index (works only with single line fasta/q) [0]'
    inputBinding:
      position: 103
      prefix: --createdb-mode
  - id: id_offset
    type:
      - 'null'
      - int
    doc: 'Numeric ids in index file are offset by this value [0]'
    inputBinding:
      position: 103
      prefix: --id-offset
  - id: rescore_mode
    type:
      - 'null'
      - int
    doc: 'Rescore diagonals with: 0: Hamming distance 1: local alignment (score only) 2: local alignment 3: global alignment 4: longest alignment fulfilling window quality criterion [3]'
    inputBinding:
      position: 103
      prefix: --rescore-mode
  - id: keep_target
    type:
      - 'null'
      - boolean
    doc: 'Keep target sequences [1]'
    inputBinding:
      position: 103
      prefix: --keep-target
  - id: chop_cycle
    type:
      - 'null'
      - boolean
    doc: 'Remove superfluous part of circular fragments (see --cycle-check) [1]'
    inputBinding:
      position: 103
      prefix: --chop-cycle
  - id: cycle_check
    type:
      - 'null'
      - boolean
    doc: 'Check for circular sequences (avoid over extension of circular or long repeated regions)  [1]'
    inputBinding:
      position: 103
      prefix: --cycle-check
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: 'Minimum length of assembled contig to output [1000]'
    inputBinding:
      position: 103
      prefix: --min-contig-len
  - id: contig_output_mode
    type:
      - 'null'
      - int
    doc: 'Type of contigs: 0: all 1: only extended [1]'
    inputBinding:
      position: 103
      prefix: --contig-output-mode
  - id: compressed
    type:
      - 'null'
      - int
    doc: 'Write compressed output [0]'
    inputBinding:
      position: 103
      prefix: --compressed
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]'
    inputBinding:
      position: 103
      prefix: -v
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: 'Substitution matrix file [nucl:nucleotide.out,aa:blosum62.out]'
    inputBinding:
      position: 103
      prefix: --sub-mat
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: 'Maximum sequence length [200000]'
    inputBinding:
      position: 103
      prefix: --max-seq-len
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU-cores used (all by default) [20]'
    inputBinding:
      position: 103
      prefix: --threads
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]'
    inputBinding:
      position: 103
      prefix: --db-load-mode
  - id: remove_tmp_files
    type:
      - 'null'
      - boolean
    doc: 'Delete temporary files [0]'
    inputBinding:
      position: 103
      prefix: --remove-tmp-files
  - id: delete_tmp_inc
    type:
      - 'null'
      - int
    doc: 'Delete temporary files incremental [0,1] [1]'
    inputBinding:
      position: 103
      prefix: --delete-tmp-inc
  - id: mpi_runner
    type:
      - 'null'
      - string
    doc: 'Use MPI on compute cluster with this MPI command (e.g. ''mpirun -np 42'') []'
    inputBinding:
      position: 103
      prefix: --mpi-runner
  - id: write_lookup
    type:
      - 'null'
      - int
    doc: 'write .lookup file containing mapping from internal id, fasta id and file number [1]'
    inputBinding:
      position: 103
      prefix: --write-lookup
  - id: filter_hits
    type:
      - 'null'
      - boolean
    doc: 'Filter hits by seq.id. and coverage [0]'
    inputBinding:
      position: 103
      prefix: --filter-hits
  - id: sort_results
    type:
      - 'null'
      - int
    doc: 'Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming) [0]'
    inputBinding:
      position: 103
      prefix: --sort-results
  - id: db_mode
    type:
      - 'null'
      - boolean
    doc: 'Input is database [0]'
    inputBinding:
      position: 103
      prefix: --db-mode
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.fasta_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plass:5.cf8933--hd6d6fdc_3
