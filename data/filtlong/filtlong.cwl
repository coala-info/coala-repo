cwlVersion: v1.2
class: CommandLineTool
baseCommand: filtlong
label: filtlong
doc: "A tool for filtering long reads by quality\n\nTool homepage: https://github.com/rrwick/Filtlong"
inputs:
  - id: input_reads
    type: File
    doc: Input long reads to be filtered
    inputBinding:
      position: 1
  - id: keep_percent
    type:
      - 'null'
      - float
    doc: Keep only the best percent of reads (e.g. 90)
    inputBinding:
      position: 102
      prefix: --keep_percent
  - id: length_weight
    type:
      - 'null'
      - float
    doc: Weight for length
    inputBinding:
      position: 102
      prefix: --length_weight
  - id: mean_q_weight
    type:
      - 'null'
      - float
    doc: Weight for mean quality
    inputBinding:
      position: 102
      prefix: --mean_q_weight
  - id: min_length
    type:
      - 'null'
      - string
    doc: Remove reads shorter than this
    inputBinding:
      position: 102
      prefix: --min_length
  - id: min_mean_q
    type:
      - 'null'
      - float
    doc: Remove reads with mean quality less than this
    inputBinding:
      position: 102
      prefix: --min_mean_q
  - id: min_window_q
    type:
      - 'null'
      - float
    doc: Remove reads with a window quality less than this
    inputBinding:
      position: 102
      prefix: --min_window_q
  - id: short_1
    type:
      - 'null'
      - File
    doc: Reference short reads in FASTQ format
    inputBinding:
      position: 102
      prefix: --short_1
  - id: short_2
    type:
      - 'null'
      - File
    doc: Reference short reads in FASTQ format
    inputBinding:
      position: 102
      prefix: --short_2
  - id: split
    type:
      - 'null'
      - string
    doc: Split reads at adapter sequences
    inputBinding:
      position: 102
      prefix: --split
  - id: target_bases
    type:
      - 'null'
      - string
    doc: Keep only the best reads up to this many bases
    inputBinding:
      position: 102
      prefix: --target_bases
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Trim read ends
    inputBinding:
      position: 102
      prefix: --trim
  - id: window_q_weight
    type:
      - 'null'
      - float
    doc: Weight for window quality
    inputBinding:
      position: 102
      prefix: --window_q_weight
  - id: max_length
    type:
      - 'null'
      - string
    doc: Maximum length threshold (unit suffixes k, kb, m, mb, g, gb)
    inputBinding:
      position: 102
      prefix: --max_length
  - id: assembly
    type:
      - 'null'
      - File
    doc: Reference assembly in FASTA format
    inputBinding:
      position: 102
      prefix: --assembly
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of sliding window used when measuring window quality (default 250)
    inputBinding:
      position: 102
      prefix: --window_size
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output to stderr with info for each read
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/filtlong:0.3.1--h077b44d_0
stdout: filtlong.out
