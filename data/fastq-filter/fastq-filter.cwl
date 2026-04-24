cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-filter
label: fastq-filter
doc: "Filter FASTQ files on various metrics.\n\nTool homepage: https://github.com/LUMC/fastq-filter"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: Input FASTQ files. Compression format automatically detected. Use - for
      stdin.
    inputBinding:
      position: 1
  - id: average_error_rate
    type:
      - 'null'
      - float
    doc: The minimum average per base error rate.
    inputBinding:
      position: 102
      prefix: --average-error-rate
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for the output files. Relevant when output files have
      a .gz extension.
    inputBinding:
      position: 102
      prefix: --compression-level
  - id: max_length
    type:
      - 'null'
      - int
    doc: The maximum length for a read.
    inputBinding:
      position: 102
      prefix: --max-length
  - id: mean_quality
    type:
      - 'null'
      - int
    doc: Average quality. Same as the '--average-error-rate' option but 
      specified with a phred score. I.e '-q 30' is equivalent to '-e 0.001'.
    inputBinding:
      position: 102
      prefix: --mean-quality
  - id: median_quality
    type:
      - 'null'
      - int
    doc: The minimum median phred score.
    inputBinding:
      position: 102
      prefix: --median-quality
  - id: min_length
    type:
      - 'null'
      - int
    doc: The minimum length for a read.
    inputBinding:
      position: 102
      prefix: --min-length
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turn of logging output.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Report stats on individual filters.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output FASTQ files. Compression format automatically determined by file
      extension. Flag can be used multiple times. An output must be given for 
      each input.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq-filter:0.3.0--py312h0fa9677_4
