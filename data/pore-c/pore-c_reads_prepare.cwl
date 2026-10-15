cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, reads, prepare]
label: pore-c_reads_prepare
doc: "Preprocess a set of reads for use with pore_c tools: filter by length and qscore, split into batches and write metadata.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "The reads are split into batches of this size for downstream processing. Default: 10000"
    inputBinding:
      position: 1
      prefix: --batch-size
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: "The minimum length read to run through pore_c. Default: 1"
    inputBinding:
      position: 1
      prefix: --min-read-length
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: "The maximum length read to run through pore_c. Default: 150000"
    inputBinding:
      position: 1
      prefix: --max-read-length
  - id: min_qscore
    type:
      - 'null'
      - int
    doc: "The minimum read qscore. Default: 0"
    inputBinding:
      position: 1
      prefix: --min-qscore
  - id: max_qscore
    type:
      - 'null'
      - int
    doc: "The maximum read qscore. Default: 266"
    inputBinding:
      position: 1
      prefix: --max-qscore
  - id: user_metadata
    type:
      - 'null'
      - string
    doc: "Additional user metadata to associate with this run"
    inputBinding:
      position: 1
      prefix: --user-metadata
  - id: fastq
    type: File
    doc: "Input reads (FASTQ, may be gzip-compressed)"
    inputBinding:
      position: 10
  - id: output_prefix
    type: string
    doc: "Output prefix for the files that are written"
    inputBinding:
      position: 11
outputs:
  - id: batches
    type:
      type: array
      items: File
    doc: "Reads passing the filters, split in batches"
    outputBinding:
      glob: "$(inputs.output_prefix).batch*.fq.gz"
  - id: fail_reads
    type:
      - 'null'
      - File
    doc: "Reads that fail the filters"
    outputBinding:
      glob: "$(inputs.output_prefix).fail.fq.gz"
  - id: read_metadata
    type: File
    doc: "Length and qscore metadata of each read"
    outputBinding:
      glob: "$(inputs.output_prefix).read_metadata.parquet"
  - id: summary
    type: File
    doc: "Summary stats for all/pass/fail reads"
    outputBinding:
      glob: "$(inputs.output_prefix).summary.csv"
  - id: catalog
    type: File
    doc: "Intake catalog"
    outputBinding:
      glob: "$(inputs.output_prefix).catalog.yaml"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
