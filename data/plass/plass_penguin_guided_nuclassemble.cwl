cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - penguin
  - guided_nuclassemble
label: plass_penguin_guided_nuclassemble
doc: "Assemble nucleotide sequences by iterative greedy overlap assembly using protein and nucleotide information (protein-guided).\n\nTool homepage: https://github.com/soedinglab/plass"
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
    doc: 'Alphabet size (range 2-21) [nucl:5,aa:13]'
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
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: '0: coverage of query and target 1: coverage of target 2: coverage of query 3: target seq. length has to be at least x% of query length 4: query seq. length has to be at least x% of target length 5: short seq. needs to be at least x% of the other seq. length [1]'
    inputBinding:
      position: 103
      prefix: --cov-mode
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
  - id: seq_id_mode
    type:
      - 'null'
      - int
    doc: '0: alignment length 1: shorter, 2: longer sequence [0]'
    inputBinding:
      position: 103
      prefix: --seq-id-mode
  - id: gap_open
    type:
      - 'null'
      - string
    doc: 'Gap open cost (only for clustering [5]'
    inputBinding:
      position: 103
      prefix: --gap-open
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: 'Gap extend cost (only for clustering) [2]'
    inputBinding:
      position: 103
      prefix: --gap-extend
  - id: zdrop
    type:
      - 'null'
      - int
    doc: 'Maximal allowed difference between score values before alignment is truncated (only for clustering) [200]'
    inputBinding:
      position: 103
      prefix: --zdrop
  - id: min_seq_id
    type:
      - 'null'
      - string
    doc: 'Overlap sequence identity threshold (range 0.0-1.0) [nucl:0.990,aa:0.970]'
    inputBinding:
      position: 103
      prefix: --min-seq-id
  - id: min_aln_len
    type:
      - 'null'
      - string
    doc: 'Minimum alignment length (range 0-INT_MAX) [0]'
    inputBinding:
      position: 103
      prefix: --min-aln-len
  - id: cluster_mode
    type:
      - 'null'
      - int
    doc: '0: Set-Cover (greedy) 1: Connected component (BLASTclust) 2,3: Greedy clustering by sequence length (CDHIT) [2]'
    inputBinding:
      position: 103
      prefix: --cluster-mode
  - id: clust_min_seq_id
    type:
      - 'null'
      - float
    doc: 'Seq. id. threshold passed to linclust algorithm to reduce redundancy in assembly (range 0.0-1.0) [0.970]'
    inputBinding:
      position: 103
      prefix: --clust-min-seq-id
  - id: clust_min_cov
    type:
      - 'null'
      - float
    doc: 'Coverage threshold passed to linclust algorithm to reduce redundancy in assembly (range 0.0-1.0) [0.990]'
    inputBinding:
      position: 103
      prefix: --clust-min-cov
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
  - id: kmer_length
    type:
      - 'null'
      - string
    doc: 'k-mer length (0: automatically set to optimum) [nucl:22,aa:14]'
    inputBinding:
      position: 103
      prefix: -k
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'Minimum codon number in open reading frames [45]'
    inputBinding:
      position: 103
      prefix: --min-length
  - id: max_length
    type:
      - 'null'
      - int
    doc: 'Maximum codon number in open reading frames [32734]'
    inputBinding:
      position: 103
      prefix: --max-length
  - id: forward_frames
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of frames on the forward strand to be extracted [1,2,3]'
    inputBinding:
      position: 103
      prefix: --forward-frames
  - id: reverse_frames
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of frames on the reverse strand to be extracted [1,2,3]'
    inputBinding:
      position: 103
      prefix: --reverse-frames
  - id: translation_table
    type:
      - 'null'
      - int
    doc: '1) CANONICAL, 2) VERT_MITOCHONDRIAL, 3) YEAST_MITOCHONDRIAL, 4) MOLD_MITOCHONDRIAL, 5) INVERT_MITOCHONDRIAL, 6) CILIATE 9) FLATWORM_MITOCHONDRIAL, 10) EUPLOTID, 11) PROKARYOTE, 12) ALT_YEAST, 13) ASCIDIAN_MITOCHONDRIAL, 14) ALT_FLATWORM_MITOCHONDRIAL 15) BLEPHARISMA, 16) CHLOROPHYCEAN_MITOCHONDRIAL, 21) TREMATODE_MITOCHONDRIAL, 22) SCENEDESMUS_MITOCHONDRIAL 23) THRAUSTOCHYTRIUM_MITOCHONDRIAL, 24) PTEROBRANCHIA_MITOCHONDRIAL, 25) GRACILIBACTERIA, 26) PACHYSOLEN, 27) KARYORELICT, 28) CONDYLOSTOMA 29) MESODINIUM, 30) PERTRICH, 31) BLASTOCRITHIDIA [1]'
    inputBinding:
      position: 103
      prefix: --translation-table
  - id: translate
    type:
      - 'null'
      - int
    doc: 'Translate ORF to amino acid [0]'
    inputBinding:
      position: 103
      prefix: --translate
  - id: use_all_table_starts
    type:
      - 'null'
      - boolean
    doc: 'Use all alternatives for a start codon in the genetic table, if false - only ATG (AUG) [0]'
    inputBinding:
      position: 103
      prefix: --use-all-table-starts
  - id: id_offset
    type:
      - 'null'
      - int
    doc: 'Numeric ids in index file are offset by this value [0]'
    inputBinding:
      position: 103
      prefix: --id-offset
  - id: keep_target
    type:
      - 'null'
      - boolean
    doc: 'Keep target sequences [1]'
    inputBinding:
      position: 103
      prefix: --keep-target
  - id: rescore_mode
    type:
      - 'null'
      - int
    doc: 'Rescore diagonals with: 0: Hamming distance 1: local alignment (score only) 2: local alignment 3: global alignment 4: longest alignment fulfilling window quality criterion [3]'
    inputBinding:
      position: 103
      prefix: --rescore-mode
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
  - id: num_iterations
    type:
      - 'null'
      - string
    doc: 'Number of assembly iterations performed on nucleotide level,protein level (range 1-inf) [5]'
    inputBinding:
      position: 103
      prefix: --num-iterations
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU-cores used (all by default) [20]'
    inputBinding:
      position: 103
      prefix: --threads
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
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: 'Maximum sequence length [200000]'
    inputBinding:
      position: 103
      prefix: --max-seq-len
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: 'Substitution matrix file [nucl:nucleotide.out,aa:blosum62.out]'
    inputBinding:
      position: 103
      prefix: --sub-mat
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
  - id: create_lookup
    type:
      - 'null'
      - int
    doc: 'Create database lookup file (can be very large) [0]'
    inputBinding:
      position: 103
      prefix: --create-lookup
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
