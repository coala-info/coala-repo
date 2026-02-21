cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamsieve
label: pbcoretools_bamsieve
doc: "Tool for subsetting a BAM or PacBio DataSet file based on either a whitelist
  of hole numbers or a percentage of reads to be randomly selected.\n\nTool homepage:
  https://github.com/mpkocher/pbcoretools"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM or DataSet from which reads will be read
    inputBinding:
      position: 1
  - id: anonymize
    type:
      - 'null'
      - boolean
    doc: Randomize sequences for privacy
    default: false
    inputBinding:
      position: 102
      prefix: --anonymize
  - id: barcodes
    type:
      - 'null'
      - boolean
    doc: Indicates that the whitelist or blacklist contains barcode indices instead
      of ZMW numbers
    default: false
    inputBinding:
      position: 102
      prefix: --barcodes
  - id: blacklist
    type:
      - 'null'
      - string
    doc: Opposite of --whitelist, specifies ZMWs to discard
    inputBinding:
      position: 102
      prefix: --blacklist
  - id: count
    type:
      - 'null'
      - int
    doc: Recover a specific number of ZMWs picked at random
    inputBinding:
      position: 102
      prefix: --count
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Alias for setting log level to DEBUG
    default: false
    inputBinding:
      position: 102
      prefix: --debug
  - id: ignore_metadata
    type:
      - 'null'
      - boolean
    doc: Discard input DataSet metadata
    default: false
    inputBinding:
      position: 102
      prefix: --ignore-metadata
  - id: keep_uuid
    type:
      - 'null'
      - boolean
    doc: If enabled, the UUID from the input dataset will be used for the output as
      well.
    default: false
    inputBinding:
      position: 102
      prefix: --keep-uuid
  - id: log_file
    type:
      - 'null'
      - File
    doc: Write the log to file. Default(None) will write to stdout.
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set log level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
    default: WARN
    inputBinding:
      position: 102
      prefix: --log-level
  - id: min_adapters
    type:
      - 'null'
      - int
    doc: Minimum number of adapters to filter for
    inputBinding:
      position: 102
      prefix: --min-adapters
  - id: percentage
    type:
      - 'null'
      - float
    doc: If you prefer to recover a percentage of a SMRTcell rather than a specific
      list of reads specify that percentage (range 0-100) here
    inputBinding:
      position: 102
      prefix: --percentage
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Alias for setting log level to CRITICAL to suppress output.
    default: false
    inputBinding:
      position: 102
      prefix: --quiet
  - id: relative
    type:
      - 'null'
      - boolean
    doc: Make external resource paths relative
    default: false
    inputBinding:
      position: 102
      prefix: --relative
  - id: sample_scraps
    type:
      - 'null'
      - boolean
    doc: If enabled, --percentage and --count will include hole numbers from scraps
      BAM files when picking a random sample (default is to sample only ZMWs present
      in subreads BAM).
    default: false
    inputBinding:
      position: 102
      prefix: --sample-scraps
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for selecting a percentage of reads
    inputBinding:
      position: 102
      prefix: --seed
  - id: show_zmws
    type:
      - 'null'
      - boolean
    doc: Print a list of ZMWs and exit
    default: false
    inputBinding:
      position: 102
      prefix: --show-zmws
  - id: subreads
    type:
      - 'null'
      - boolean
    doc: If set, the whitelist or blacklist will be assumed to contain one subread
      name per line, or a BAM/DataSet file from which to extract subreads
    default: false
    inputBinding:
      position: 102
      prefix: --subreads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set the verbosity level.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: whitelist
    type:
      - 'null'
      - string
    doc: Comma-separated list of ZMWs, or file containing whitelist of one hole number
      per line, or BAM/DataSet file from which to extract ZMWs
    inputBinding:
      position: 102
      prefix: --whitelist
outputs:
  - id: output_bam
    type:
      - 'null'
      - File
    doc: 'Output BAM or DataSet to which filtered reads will be written (default:
      None)'
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbcoretools:0.8.1--py_1
