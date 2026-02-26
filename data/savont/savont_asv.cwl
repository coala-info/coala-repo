cwlVersion: v1.2
class: CommandLineTool
baseCommand: savont asv
label: savont_asv
doc: "Cluster long reads of >~ 98% accuracy into ASVs (Amplicon Sequence Variants)\n\
  \nTool homepage: https://github.com/bluenote-1577/savont"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input read file(s) in FASTQ or FASTA format (.gz supported). Multiple 
      files are concatenated
    inputBinding:
      position: 1
  - id: chimera_allowable_errors
    type:
      - 'null'
      - int
    doc: Allowable errors for bi-chimeric detection (higher = more sensitive, 
      slower)
    default: 1
    inputBinding:
      position: 102
      prefix: --chimera-allowable-errors
  - id: chimera_detect_length
    type:
      - 'null'
      - int
    doc: Length of near-perfect asv segment matches to consider for chimera 
      detection (higher = less sensitive). Default is 1/10 of the minimum read 
      length
    inputBinding:
      position: 102
      prefix: --chimera-detect-length
  - id: fl_16s
    type:
      - 'null'
      - boolean
    doc: 16s rRNA full length (~1500 bp) amplicon preset (default; does nothing)
    inputBinding:
      position: 102
      prefix: --fl-16s
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging verbosity level
    default: debug
    inputBinding:
      position: 102
      prefix: --log-level
  - id: mask_low_quality
    type:
      - 'null'
      - boolean
    doc: Mask low-quality bases in consensus sequences (set to 'N' if below 
      posterior probability threshold)
    inputBinding:
      position: 102
      prefix: --mask-low-quality
  - id: max_iterations_recluster
    type:
      - 'null'
      - int
    doc: Maximum number of reclustering iterations
    default: 10
    inputBinding:
      position: 102
      prefix: --max-iterations-recluster
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: Maximum read length for reads
    default: 2000
    inputBinding:
      position: 102
      prefix: --max-read-length
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: Minimum number of reads required to keep a cluster (ASV)
    default: 12
    inputBinding:
      position: 102
      prefix: --min-cluster-size
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length for reads
    default: 1100
    inputBinding:
      position: 102
      prefix: --min-read-length
  - id: minimum_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality to be considered high-quality for SNPmer 
      detection. Set lower for older reads (~18 for R9)
    default: 25
    inputBinding:
      position: 102
      prefix: --minimum-base-quality
  - id: n_depth_cutoff
    type:
      - 'null'
      - int
    doc: Minimum depth required for sequences with ambiguous bases to be 
      included in output
    default: 250
    inputBinding:
      position: 102
      prefix: --n-depth-cutoff
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for results (created if it does not exist)
    default: savont-out
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: posterior_threshold_ln
    type:
      - 'null'
      - float
    doc: Negative alternate posterior probability threshold (natural log scale) 
      for base consensus. Higher = more stringent for low-quality consensuses. 
      Do not set higher than min_depth * ln(error_rate)
    default: 30
    inputBinding:
      position: 102
      prefix: --posterior-threshold-ln
  - id: quality_value_cutoff
    type:
      - 'null'
      - float
    doc: Minimum estimated read accuracy (%) to include in clustering
    default: 98
    inputBinding:
      position: 102
      prefix: --quality-value-cutoff
  - id: rrna_operon
    type:
      - 'null'
      - boolean
    doc: rRNA operon (~4000 bp) amplicon preset (--min-read-length 3500 
      --max-read-length 5000)
    inputBinding:
      position: 102
      prefix: --rrna-operon
  - id: single_strand
    type:
      - 'null'
      - boolean
    doc: Use only forward strand k-mers (for strand-specific protocols)
    inputBinding:
      position: 102
      prefix: --single-strand
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel processing
    default: 20
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savont:0.3.2--h3ab6199_0
stdout: savont_asv.out
