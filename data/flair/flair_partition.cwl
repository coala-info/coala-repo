cwlVersion: v1.2
class: CommandLineTool
baseCommand: flair_partition
label: flair_partition
doc: 'Define non-overlapping regions from BED, SAM/BAM or GTF files. Partitions are
  made across all input files.


  Tool homepage: https://github.com/BrooksLabUCSC/flair'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: min_partition_items
    type:
      - 'null'
      - int
    doc: Minimum number of input items in a partition
    inputBinding:
      position: 1
      prefix: --min_partition_items
  - id: part_merge_dist
    type:
      - 'null'
      - int
    doc: Combine adjacent non-overlapping partitions separated by this distance
    inputBinding:
      position: 1
      prefix: -part_merge_dist
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of cores for parallel sorting
    inputBinding:
      position: 1
      prefix: --threads
  - id: bed_files
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --bed
    doc: Input BED file(s), may be compressed
    inputBinding:
      position: 1
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --bam
    doc: Input SAM/BAM file(s)
    inputBinding:
      position: 1
  - id: gtf_files
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --gtf
    doc: Input GTF file(s)
    inputBinding:
      position: 1
  - id: ranges_bed
    type: string
    doc: Output ranges BED file, compressed if it ends in .gz
    inputBinding:
      position: 3
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
  - id: ranges
    type: File
    doc: Ranges BED file
    outputBinding:
      glob: $(inputs.ranges_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
