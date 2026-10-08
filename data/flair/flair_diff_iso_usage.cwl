cwlVersion: v1.2
class: CommandLineTool
baseCommand: diff_iso_usage
label: flair_diff_iso_usage
doc: 'Calculate the usage of each isoform as a fraction of the total expression of
  its gene and compare it between two samples.


  Tool homepage: https://github.com/BrooksLabUCSC/flair'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: counts_matrix_tsv
    type: File
    doc: Counts matrix TSV from flair quantify
    inputBinding:
      position: 1
  - id: colname1
    type: string
    doc: Name of the column of the first sample
    inputBinding:
      position: 2
  - id: colname2
    type: string
    doc: Name of the column of the second sample
    inputBinding:
      position: 3
  - id: outfile
    type: string
    doc: Output file name with the p-value of differential isoform usage for each
      isoform
    inputBinding:
      position: 4
  - id: log_stderr
    type:
      - 'null'
      - boolean
    doc: Also log to stderr, even when logging to syslog
    inputBinding:
      position: 1
      prefix: --log-stderr
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set level to case-insensitive symbolic value, one of CRITICAL, DEBUG, ERROR,
      FATAL, INFO, NOTSET, WARN, WARNING
    inputBinding:
      position: 1
      prefix: --log-level
  - id: log_conf
    type:
      - 'null'
      - File
    doc: Python logging configuration file, see logging.config.fileConfig()
    inputBinding:
      position: 1
      prefix: --log-conf
  - id: log_debug
    type:
      - 'null'
      - boolean
    doc: Short-cut that sets --log-stderr and --log-level=DEBUG
    inputBinding:
      position: 1
      prefix: --log-debug
outputs:
  - id: output_table
    type: File
    doc: Differential isoform usage table
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
