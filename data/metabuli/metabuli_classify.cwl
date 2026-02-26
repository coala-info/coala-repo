cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabuli classify
label: metabuli_classify
doc: "By Jaebeom Kim <jbeom0731@gmail.com>\n\nTool homepage: https://github.com/steineggerlab/Metabuli"
inputs:
  - id: query_files
    type:
      type: array
      items: File
    doc: query file(s)
    inputBinding:
      position: 1
  - id: database_directory
    type: Directory
    doc: database directory
    inputBinding:
      position: 2
  - id: job_id
    type: string
    doc: job ID
    inputBinding:
      position: 3
  - id: accession_level
    type:
      - 'null'
      - int
    doc: Build or search a database for accession-level classification
    default: 0
    inputBinding:
      position: 104
      prefix: --accession-level
  - id: hamming_margin
    type:
      - 'null'
      - int
    doc: It allows extra Hamming distance than the minimum distance.
    default: 0
    inputBinding:
      position: 104
      prefix: --hamming-margin
  - id: lineage
    type:
      - 'null'
      - int
    doc: Print lineage information
    default: 0
    inputBinding:
      position: 104
      prefix: --lineage
  - id: mask
    type:
      - 'null'
      - int
    doc: 'Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking,
      1: with low complexity masking'
    default: 0
    inputBinding:
      position: 104
      prefix: --mask
  - id: mask_prob
    type:
      - 'null'
      - float
    doc: Mask sequences is probablity is above threshold
    default: 0.9
    inputBinding:
      position: 104
      prefix: --mask-prob
  - id: match_per_kmer
    type:
      - 'null'
      - int
    doc: Num. of matches per query k-mer. Larger values assign more memory for 
      storing k-mer matches.
    default: 4
    inputBinding:
      position: 104
      prefix: --match-per-kmer
  - id: max_ram
    type:
      - 'null'
      - int
    doc: RAM usage in GiB
    default: 128
    inputBinding:
      position: 104
      prefix: --max-ram
  - id: min_cons_cnt
    type:
      - 'null'
      - int
    doc: Min. number of consecutive matches for prokaryote/virus classification
    default: 4
    inputBinding:
      position: 104
      prefix: --min-cons-cnt
  - id: min_cons_cnt_euk
    type:
      - 'null'
      - int
    doc: Min. number of consecutive matches for eukaryote classification
    default: 9
    inputBinding:
      position: 104
      prefix: --min-cons-cnt-euk
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Min. query coverage (0.0-1.0)
    default: 0.0
    inputBinding:
      position: 104
      prefix: --min-cov
  - id: min_score
    type:
      - 'null'
      - float
    doc: Min. sequence similarity score (0.0-1.0)
    default: 0.0
    inputBinding:
      position: 104
      prefix: --min-score
  - id: min_sp_score
    type:
      - 'null'
      - float
    doc: Min. score for species- or lower-level classification.
    default: 0.0
    inputBinding:
      position: 104
      prefix: --min-sp-score
  - id: seq_mode
    type:
      - 'null'
      - int
    doc: 'Single-end: 1, Paired-end: 2, Long read: 3'
    default: 2
    inputBinding:
      position: 104
      prefix: --seq-mode
  - id: skip_redundancy
    type:
      - 'null'
      - int
    doc: Not storing k-mer's redundancy.
    default: 0
    inputBinding:
      position: 104
      prefix: --skip-redundancy
  - id: taxonomy_path
    type:
      - 'null'
      - string
    doc: Directory where the taxonomy dump files are stored
    default: ''
    inputBinding:
      position: 104
      prefix: --taxonomy-path
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    default: 20
    inputBinding:
      position: 104
      prefix: --threads
  - id: tie_ratio
    type:
      - 'null'
      - float
    doc: Best * --tie-ratio is considered as a tie
    default: 0.95
    inputBinding:
      position: 104
      prefix: --tie-ratio
  - id: validate_db
    type:
      - 'null'
      - int
    doc: Validate the database. It checks if all required files are present and 
      if the k-mer count is consistent.
    default: 0
    inputBinding:
      position: 104
      prefix: --validate-db
  - id: validate_input
    type:
      - 'null'
      - int
    doc: Validate format of input FASTA/FASTQ file(s)
    default: 0
    inputBinding:
      position: 104
      prefix: --validate-input
outputs:
  - id: output_directory
    type: Directory
    doc: output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
