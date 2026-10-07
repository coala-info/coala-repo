cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run_dbcan
  - CAZyme_annotation
label: dbcan_CAZyme_annotation
doc: "annotate CAZyme using run_dbcan with prokaryotic, metagenomics, and protein sequences.\n\nTool homepage: http://bcb.unl.edu/dbCAN2/"
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
  - id: force_topology
    type:
      - 'null'
      - boolean
    doc: "Overwrite existing SignalP columns instead of only filling empty cells"
    inputBinding:
      position: 102
      prefix: --force_topology
  - id: no_force_topology
    type:
      - 'null'
      - boolean
    doc: "Turn off: Overwrite existing SignalP columns instead of only filling empty cells"
    inputBinding:
      position: 102
      prefix: --no-force_topology
  - id: signalp_org
    type:
      - 'null'
      - string
    doc: "Organism type passed to SignalP6 [default: other] (one of other, euk)"
    inputBinding:
      position: 102
      prefix: --signalp_org
  - id: run_signalp
    type:
      - 'null'
      - boolean
    doc: "Run SignalP6.0 (biolib) to predict signal peptides for all proteins in overview"
    inputBinding:
      position: 102
      prefix: --run_signalp
  - id: no_run_signalp
    type:
      - 'null'
      - boolean
    doc: "Turn off: Run SignalP6.0 (biolib) to predict signal peptides for all proteins in overview"
    inputBinding:
      position: 102
      prefix: --no-run_signalp
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
