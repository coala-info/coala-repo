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
  - id: output_bam_name
    type: string
    doc: Output BAM or DataSet to which filtered reads will be written
    inputBinding:
      position: 2
  - id: anonymize
    type:
      - 'null'
      - boolean
    doc: Randomize sequences for privacy
    inputBinding:
      position: 102
      prefix: --anonymize
  - id: barcodes
    type:
      - 'null'
      - boolean
    doc: Indicates that the whitelist or blacklist contains barcode indices instead
      of ZMW numbers
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
    inputBinding:
      position: 102
      prefix: --debug
  - id: ignore_metadata
    type:
      - 'null'
      - boolean
    doc: Discard input DataSet metadata
    inputBinding:
      position: 102
      prefix: --ignore-metadata
  - id: keep_uuid
    type:
      - 'null'
      - boolean
    doc: If enabled, the UUID from the input dataset will be used for the output as
      well.
    inputBinding:
      position: 102
      prefix: --keep-uuid
  - id: log_file
    type:
      - 'null'
      - string
    doc: Write the log to file. Default(None) will write to stdout.
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set log level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
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
    inputBinding:
      position: 102
      prefix: --quiet
  - id: relative
    type:
      - 'null'
      - boolean
    doc: Make external resource paths relative
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
    inputBinding:
      position: 102
      prefix: --show-zmws
  - id: subreads
    type:
      - 'null'
      - boolean
    doc: If set, the whitelist or blacklist will be assumed to contain one subread
      name per line, or a BAM/DataSet file from which to extract subreads
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
  - id: whitelist_file
    type:
      - 'null'
      - File
    doc: File with a whitelist of one hole number per line (or a BAM/DataSet file
      from which to extract ZMWs), used with --whitelist
    inputBinding:
      position: 102
      prefix: --whitelist
  - id: blacklist_file
    type:
      - 'null'
      - File
    doc: File with a blacklist of one hole number per line (or a BAM/DataSet file
      from which to extract ZMWs), used with --blacklist
    inputBinding:
      position: 102
      prefix: --blacklist
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
    doc: Output BAM or DataSet with the filtered reads
    outputBinding:
      glob: $(inputs.output_bam_name)
  - id: output_pbi
    type:
      - 'null'
      - File
    doc: PacBio index of the output BAM
    outputBinding:
      glob: $(inputs.output_bam_name).pbi
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file, when --log-file is used
    outputBinding:
      glob: $(inputs.log_file)
  - id: zmw_list
    type:
      - 'null'
      - File
    doc: ZMW list printed by --show-zmws
    outputBinding:
      glob: bamsieve_stdout.txt
stdout: bamsieve_stdout.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbcoretools:0.8.1--py_1
