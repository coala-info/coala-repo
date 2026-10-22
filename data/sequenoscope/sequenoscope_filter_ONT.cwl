cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenoscope
  - filter_ONT
label: sequenoscope_filter_ONT
doc: "Filter reads from a fastq file based on a sequencing summary file\n\nTool homepage: https://github.com/phac-nml/sequenoscope"
inputs:
  - id: input_summary
    type: File
    doc: Path to ONT sequencing summary file.
    inputBinding:
      position: 101
      prefix: --input_summary
  - id: output
    type: string
    doc: Output directory designation
    inputBinding:
      position: 101
      prefix: -o
  - id: input_fastq
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to adaptive sequencing fastq files to process. Not required when using --summarize.
    inputBinding:
      position: 101
      prefix: --input_fastq
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output file prefix designation. default is [sample]
    inputBinding:
      position: 101
      prefix: -op
  - id: classification
    type:
      - 'null'
      - string
    doc: "Adaptive-sampling sequencing decision classification based on the 'end_reason' column in the sequencing summary file: unblocked, stop_receiving, no_decision or all. Default: all."
    inputBinding:
      position: 101
      prefix: -cls
  - id: minimum_channel
    type:
      - 'null'
      - int
    doc: Minimum channel number for filtering reads. Default=1.
    inputBinding:
      position: 101
      prefix: -min_ch
  - id: maximum_channel
    type:
      - 'null'
      - int
    doc: Maximum channel number for filtering reads. Default=512.
    inputBinding:
      position: 101
      prefix: -max_ch
  - id: minimum_duration
    type:
      - 'null'
      - float
    doc: Minimum duration (s) for filtering reads. Default=0.
    inputBinding:
      position: 101
      prefix: -min_dur
  - id: maximum_duration
    type:
      - 'null'
      - float
    doc: Maximum duration (s) for filtering reads. Default=100.
    inputBinding:
      position: 101
      prefix: -max_dur
  - id: minimum_start_time
    type:
      - 'null'
      - float
    doc: Minimum start time (s) for filtering reads. Default=0.
    inputBinding:
      position: 101
      prefix: -min_start
  - id: maximum_start_time
    type:
      - 'null'
      - float
    doc: Maximum start time (s) for filtering reads. Default=259200.
    inputBinding:
      position: 101
      prefix: -max_start
  - id: minimum_q_score
    type:
      - 'null'
      - float
    doc: Minimum Q score for filtering reads. Default=0.
    inputBinding:
      position: 101
      prefix: -min_q
  - id: maximum_q_score
    type:
      - 'null'
      - float
    doc: Maximum Q score for filtering reads. Default=100.
    inputBinding:
      position: 101
      prefix: -max_q
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: Minimum read length for filtering. Default=0.
    inputBinding:
      position: 101
      prefix: -min_len
  - id: maximum_length
    type:
      - 'null'
      - int
    doc: Maximum read length for filtering. Default=50000.
    inputBinding:
      position: 101
      prefix: -max_len
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing results directory
    inputBinding:
      position: 101
      prefix: --force
  - id: summarize
    type:
      - 'null'
      - boolean
    doc: Generate barcode statistics only (works only with --input_summary and --output).
    inputBinding:
      position: 101
      prefix: --summarize
outputs:
  - id: output_directory
    type: Directory
    doc: Directory with the filtered FASTQ subset, read id list and log.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenoscope:1.0.0--pyh7e72e81_1
