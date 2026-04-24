cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoq
label: nanoq
doc: "Fast quality control and summary statistics for nanopore reads\n\nTool homepage:
  https://github.com/esteinig/nanoq"
inputs:
  - id: compress_level
    type:
      - 'null'
      - int
    doc: Compression level for gzipped output (0-9)
    inputBinding:
      position: 101
      prefix: --compress-level
  - id: input
    type:
      - 'null'
      - File
    doc: 'Input fastq[.gz] file [default: stdin]'
    inputBinding:
      position: 101
      prefix: --input
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum read length filter
    inputBinding:
      position: 101
      prefix: --max-len
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum read length filter
    inputBinding:
      position: 101
      prefix: --min-len
  - id: min_qual
    type:
      - 'null'
      - float
    doc: Minimum average read quality filter
    inputBinding:
      position: 101
      prefix: --min-qual
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Output summary statistics
    inputBinding:
      position: 101
      prefix: --stats
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: top
    type:
      - 'null'
      - int
    doc: Filter the top N reads by length
    inputBinding:
      position: 101
      prefix: --top
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Output fastq[.gz] file [default: stdout]'
    outputBinding:
      glob: $(inputs.output)
  - id: report
    type:
      - 'null'
      - File
    doc: Output report file
    outputBinding:
      glob: $(inputs.report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoq:0.10.0--hc1c3326_4
