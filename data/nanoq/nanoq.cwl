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
    doc: Compression level to use if compressing output (1-9)
    inputBinding:
      position: 101
      prefix: --compress-level
  - id: input
    type:
      - 'null'
      - File
    doc: 'Fast{a,q}.{gz,xz,bz} input file [default: stdin]'
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
  - id: top
    type:
      - 'null'
      - int
    doc: Number of top reads in verbose summary
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
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Ignore quality values if present
    inputBinding:
      position: 101
      prefix: --fast
  - id: header
    type:
      - 'null'
      - boolean
    doc: Header for summary output
    inputBinding:
      position: 101
      prefix: --header
  - id: json
    type:
      - 'null'
      - boolean
    doc: Summary report in JSON format
    inputBinding:
      position: 101
      prefix: --json
  - id: max_qual
    type:
      - 'null'
      - float
    doc: Maximum average read quality filter (Q)
    inputBinding:
      position: 101
      prefix: --max-qual
  - id: output_type
    type:
      - 'null'
      - string
    doc: 'Output compression type (u: uncompressed; b: Bzip2; g: Gzip; l: Lzma)'
    inputBinding:
      position: 101
      prefix: --output-type
  - id: trim_end
    type:
      - 'null'
      - int
    doc: Trim bases from end of each read
    inputBinding:
      position: 101
      prefix: --trim-end
  - id: trim_start
    type:
      - 'null'
      - int
    doc: Trim bases from start of each read
    inputBinding:
      position: 101
      prefix: --trim-start
  - id: read_lengths_path
    type:
      - 'null'
      - string
    doc: Read lengths output file
    inputBinding:
      position: 104
      prefix: --read-lengths
  - id: read_qualities_path
    type:
      - 'null'
      - string
    doc: Read qualities output file
    inputBinding:
      position: 105
      prefix: --read-qualities
  - id: output_path
    type:
      - 'null'
      - string
    doc: 'Output filepath, stdout if not present'
    inputBinding:
      position: 102
      prefix: --output
  - id: report_path
    type:
      - 'null'
      - string
    doc: Summary report output file
    inputBinding:
      position: 103
      prefix: --report
outputs:
  - id: stdout
    type: stdout
    doc: Filtered reads or the summary report when no output file is given
  - id: read_lengths
    type:
      - 'null'
      - File
    doc: Read lengths output file
    outputBinding:
      glob: $(inputs.read_lengths_path)
  - id: read_qualities
    type:
      - 'null'
      - File
    doc: Read qualities output file
    outputBinding:
      glob: $(inputs.read_qualities_path)
  - id: output
    type:
      - 'null'
      - File
    doc: 'Output fastq[.gz] file [default: stdout]'
    outputBinding:
      glob: $(inputs.output_path)
  - id: report
    type:
      - 'null'
      - File
    doc: Output report file
    outputBinding:
      glob: $(inputs.report_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoq:0.10.0--hc1c3326_4
stdout: nanoq.out
