cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run_dbcan
  - easy_CGC
label: dbcan_easy_CGC
doc: "Perform complete CGC analysis: CAZyme annotation, GFF processing, and CGC identification in one step.\n\nTool homepage: http://bcb.unl.edu/dbCAN2/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable verbose logging (equivalent to --log-level DEBUG)"
    inputBinding:
      position: 102
      prefix: --verbose
  - id: log_file
    type:
      - 'null'
      - string
    doc: "Write logs to file in addition to console"
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Set logging level (default: WARNING, only shows warnings and errors) (one of DEBUG, INFO, WARNING, ERROR, CRITICAL)"
    inputBinding:
      position: 102
      prefix: --log-level
  - id: mode
    type: string
    doc: "Mode of input sequence [required]"
    inputBinding:
      position: 102
      prefix: --mode
  - id: output_dir
    type: string
    doc: "Directory for the output files [required]"
    inputBinding:
      position: 102
      prefix: --output_dir
  - id: input_raw_data
    type: File
    doc: "Path to the input raw data [required]"
    inputBinding:
      position: 102
      prefix: --input_raw_data
  - id: db_dir
    type: Directory
    doc: "Directory for the database [required]"
    inputBinding:
      position: 102
      prefix: --db_dir
  - id: methods
    type:
      - 'null'
      - string
    doc: "Specify the annotation methods to use (comma-separated). Options: diamond, hmm, dbCANsub. Example: --methods diamond,hmm or --methods hmm [default: diamond,hmm,dbCANsub]"
    inputBinding:
      position: 102
      prefix: --methods
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads"
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose_option
    type:
      - 'null'
      - boolean
    doc: "Enable verbose option for diamond"
    inputBinding:
      position: 102
      prefix: --verbose_option
  - id: e_value_threshold
    type:
      - 'null'
      - float
    doc: "E-value threshold for diamond"
    inputBinding:
      position: 102
      prefix: --e_value_threshold
  - id: large_input_threshold_mb
    type:
      - 'null'
      - int
    doc: "Auto-enable large mode when input fasta size exceeds this threshold (MB). [default: 5000]"
    inputBinding:
      position: 102
      prefix: --large_input_threshold_mb
  - id: large
    type:
      - 'null'
      - boolean
    doc: "Enable streaming-safe mode for very large inputs (reduces OOM risk). [default: no-large]"
    inputBinding:
      position: 102
      prefix: --large
  - id: no_large
    type:
      - 'null'
      - boolean
    doc: "Turn off: Enable streaming-safe mode for very large inputs (reduces OOM risk). [default: no-large]"
    inputBinding:
      position: 102
      prefix: --no-large
  - id: enable_memory_monitoring
    type:
      - 'null'
      - boolean
    doc: "Enable memory monitoring and adaptive throttling for pyhmmer. [default: enable_memory_monitoring]"
    inputBinding:
      position: 102
      prefix: --enable_memory_monitoring
  - id: no_enable_memory_monitoring
    type:
      - 'null'
      - boolean
    doc: "Turn off: Enable memory monitoring and adaptive throttling for pyhmmer. [default: enable_memory_monitoring]"
    inputBinding:
      position: 102
      prefix: --no-enable_memory_monitoring
  - id: max_retries
    type:
      - 'null'
      - int
    doc: "Maximum retries on OOM during pyhmmer search. [default: 3]"
    inputBinding:
      position: 102
      prefix: --max_retries
  - id: memory_safety_factor
    type:
      - 'null'
      - float
    doc: "Safety factor for auto batch size (0.0-1.0, smaller = safer). [default: 0.5]"
    inputBinding:
      position: 102
      prefix: --memory_safety_factor
  - id: max_memory_usage
    type:
      - 'null'
      - float
    doc: "Maximum system memory usage ratio before warnings/throttling (0.0-1.0). [default: 0.8]"
    inputBinding:
      position: 102
      prefix: --max_memory_usage
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Process this many sequences per batch in pyhmmer (None = auto)."
    inputBinding:
      position: 102
      prefix: --batch_size
  - id: csv_buffer_size
    type:
      - 'null'
      - int
    doc: "Flush this many HMM hits to disk at once (larger can be faster, uses a bit more RAM). [default: 5000]"
    inputBinding:
      position: 102
      prefix: --csv_buffer_size
  - id: coverage_threshold_dbcan
    type:
      - 'null'
      - float
    doc: "Coverage threshold for dbCAN HMMER"
    inputBinding:
      position: 102
      prefix: --coverage_threshold_dbcan
  - id: e_value_threshold_dbcan
    type:
      - 'null'
      - float
    doc: "E-value threshold for dbCAN HMMER"
    inputBinding:
      position: 102
      prefix: --e_value_threshold_dbcan
  - id: large_input_threshold_mb_dbsub
    type:
      - 'null'
      - int
    doc: "(dbCAN-sub) Auto-enable large mode when input fasta exceeds this threshold (MB). [default: 5000]"
    inputBinding:
      position: 102
      prefix: --large_input_threshold_mb_dbsub
  - id: large_dbsub
    type:
      - 'null'
      - boolean
    doc: "(dbCAN-sub) Enable streaming-safe mode for very large inputs. [default: no-large_dbsub]"
    inputBinding:
      position: 102
      prefix: --large_dbsub
  - id: no_large_dbsub
    type:
      - 'null'
      - boolean
    doc: "Turn off: (dbCAN-sub) Enable streaming-safe mode for very large inputs. [default: no-large_dbsub]"
    inputBinding:
      position: 102
      prefix: --no-large_dbsub
  - id: enable_memory_monitoring_dbsub
    type:
      - 'null'
      - boolean
    doc: "(dbCAN-sub) Enable memory monitoring and adaptive throttling for pyhmmer. [default: enable_memory_monitoring_dbsub]"
    inputBinding:
      position: 102
      prefix: --enable_memory_monitoring_dbsub
  - id: no_enable_memory_monitoring_dbsub
    type:
      - 'null'
      - boolean
    doc: "Turn off: (dbCAN-sub) Enable memory monitoring and adaptive throttling for pyhmmer. [default: enable_memory_monitoring_dbsub]"
    inputBinding:
      position: 102
      prefix: --no-enable_memory_monitoring_dbsub
  - id: max_retries_dbsub
    type:
      - 'null'
      - int
    doc: "(dbCAN-sub) Maximum retries on OOM during pyhmmer search. [default: 3]"
    inputBinding:
      position: 102
      prefix: --max_retries_dbsub
  - id: memory_safety_factor_dbsub
    type:
      - 'null'
      - float
    doc: "(dbCAN-sub) Safety factor for auto batch size (0.0-1.0). [default: 0.5]"
    inputBinding:
      position: 102
      prefix: --memory_safety_factor_dbsub
  - id: max_memory_usage_dbsub
    type:
      - 'null'
      - float
    doc: "(dbCAN-sub) Maximum system memory usage ratio before warnings/throttling (0.0-1.0). [default: 0.8]"
    inputBinding:
      position: 102
      prefix: --max_memory_usage_dbsub
  - id: batch_size_dbsub
    type:
      - 'null'
      - int
    doc: "(dbCAN-sub) Sequences per batch in pyhmmer (None = auto)."
    inputBinding:
      position: 102
      prefix: --batch_size_dbsub
  - id: csv_buffer_size_dbsub
    type:
      - 'null'
      - int
    doc: "(dbCAN-sub) Flush this many HMM hits to disk at once. [default: 5000]"
    inputBinding:
      position: 102
      prefix: --csv_buffer_size_dbsub
  - id: coverage_threshold_dbsub
    type:
      - 'null'
      - float
    doc: "Coverage threshold for dbCAN-sub HMMER"
    inputBinding:
      position: 102
      prefix: --coverage_threshold_dbsub
  - id: e_value_threshold_dbsub
    type:
      - 'null'
      - float
    doc: "E-value threshold for dbCAN-sub HMMER"
    inputBinding:
      position: 102
      prefix: --e_value_threshold_dbsub
  - id: coverage_threshold_stp
    type:
      - 'null'
      - float
    doc: "Coverage threshold for STP HMMER"
    inputBinding:
      position: 102
      prefix: --coverage_threshold_stp
  - id: e_value_threshold_stp
    type:
      - 'null'
      - float
    doc: "E-value threshold for STP HMMER"
    inputBinding:
      position: 102
      prefix: --e_value_threshold_stp
  - id: fungi
    type:
      - 'null'
      - boolean
    doc: "Enable fungi mode for TF HMMER"
    inputBinding:
      position: 102
      prefix: --fungi
  - id: no_fungi
    type:
      - 'null'
      - boolean
    doc: "Turn off: Enable fungi mode for TF HMMER"
    inputBinding:
      position: 102
      prefix: --no-fungi
  - id: coverage_threshold_tf
    type:
      - 'null'
      - float
    doc: "Coverage threshold for TF HMMER"
    inputBinding:
      position: 102
      prefix: --coverage_threshold_tf
  - id: e_value_threshold_tf
    type:
      - 'null'
      - float
    doc: "E-value threshold for TF HMMER"
    inputBinding:
      position: 102
      prefix: --e_value_threshold_tf
  - id: prokaryotic
    type:
      - 'null'
      - boolean
    doc: "Enable prokaryotic mode for TF"
    inputBinding:
      position: 102
      prefix: --prokaryotic
  - id: no_prokaryotic
    type:
      - 'null'
      - boolean
    doc: "Turn off: Enable prokaryotic mode for TF"
    inputBinding:
      position: 102
      prefix: --no-prokaryotic
  - id: coverage_threshold_tf_diamond
    type:
      - 'null'
      - float
    doc: "Coverage threshold for TF"
    inputBinding:
      position: 102
      prefix: --coverage_threshold_tf_diamond
  - id: e_value_threshold_tf_diamond
    type:
      - 'null'
      - float
    doc: "E-value threshold for TF"
    inputBinding:
      position: 102
      prefix: --e_value_threshold_tf_diamond
  - id: coverage_threshold_tc
    type:
      - 'null'
      - float
    doc: "Coverage threshold for TC"
    inputBinding:
      position: 102
      prefix: --coverage_threshold_tc
  - id: e_value_threshold_tc
    type:
      - 'null'
      - float
    doc: "E-value threshold for TC"
    inputBinding:
      position: 102
      prefix: --e_value_threshold_tc
  - id: gff_type
    type:
      - 'null'
      - string
    doc: "GFF file type. Auto-set to prodigal when --mode != protein"
    inputBinding:
      position: 102
      prefix: --gff_type
  - id: input_gff
    type:
      - 'null'
      - File
    doc: "Input GFF file. When --mode != protein this is auto-set to <output_dir>/uniInput.gff"
    inputBinding:
      position: 102
      prefix: --input_gff
  - id: feature_type
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --feature_type
    doc: "GFF feature types to include (multiple allowed)."
    inputBinding:
      position: 102
  - id: min_cluster_genes
    type:
      - 'null'
      - int
    doc: "Minimum number of genes required per CGC."
    inputBinding:
      position: 102
      prefix: --min_cluster_genes
  - id: min_core_cazyme
    type:
      - 'null'
      - int
    doc: "Minimum number of core CAZymes required per CGC."
    inputBinding:
      position: 102
      prefix: --min_core_cazyme
  - id: extend_gene_count
    type:
      - 'null'
      - int
    doc: "When --extend_mode=gene, extend this many genes on each side."
    inputBinding:
      position: 102
      prefix: --extend_gene_count
  - id: extend_bp
    type:
      - 'null'
      - int
    doc: "When --extend_mode=bp, extend this many base pairs on each side."
    inputBinding:
      position: 102
      prefix: --extend_bp
  - id: extend_mode
    type:
      - 'null'
      - string
    doc: "Extend CGC region on both sides after identification. 'bp' extends by base pairs; 'gene' extends by gene count; 'none' disables extension. (one of none, bp, gene)"
    inputBinding:
      position: 102
      prefix: --extend_mode
  - id: use_distance
    type:
      - 'null'
      - boolean
    doc: "Use base pair distance in CGC annotation."
    inputBinding:
      position: 102
      prefix: --use_distance
  - id: use_null_genes
    type:
      - 'null'
      - boolean
    doc: "Use null genes in CGC annotation."
    inputBinding:
      position: 102
      prefix: --use_null_genes
  - id: no_use_null_genes
    type:
      - 'null'
      - boolean
    doc: "Turn off: Use null genes in CGC annotation."
    inputBinding:
      position: 102
      prefix: --no-use_null_genes
  - id: base_pair_distance
    type:
      - 'null'
      - int
    doc: "Base pair distance of signature genes."
    inputBinding:
      position: 102
      prefix: --base_pair_distance
  - id: num_null_gene
    type:
      - 'null'
      - int
    doc: "Maximum number of null genes allowed between signature genes."
    inputBinding:
      position: 102
      prefix: --num_null_gene
  - id: additional_min_categories
    type:
      - 'null'
      - int
    doc: "When --additional_logic=any, require at least this number of distinct additional categories."
    inputBinding:
      position: 102
      prefix: --additional_min_categories
  - id: additional_logic
    type:
      - 'null'
      - string
    doc: "Logic for multiple --additional_genes: 'all' requires all present; 'any' requires at least one. (one of all, any)"
    inputBinding:
      position: 102
      prefix: --additional_logic
  - id: additional_genes
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --additional_genes
    doc: "Specify additional gene types for CGC annotation, including TC, TF, and STP"
    inputBinding:
      position: 102
outputs:
  - id: output
    type: Directory
    doc: Output folder
    outputBinding:
      glob: $(inputs.output_dir)
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
