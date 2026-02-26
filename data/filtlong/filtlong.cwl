cwlVersion: v1.2
class: CommandLineTool
baseCommand: filtlong
label: filtlong
doc: "A tool for filtering long reads by quality\n\nTool homepage: http://http://canu.readthedocs.org/"
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
    default: 1.0
    inputBinding:
      position: 102
      prefix: --length_weight
  - id: mean_q_weight
    type:
      - 'null'
      - float
    doc: Weight for mean quality
    default: 1.0
    inputBinding:
      position: 102
      prefix: --mean_q_weight
  - id: min_length
    type:
      - 'null'
      - int
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
  - id: read_1
    type:
      - 'null'
      - File
    doc: Input reads (alternative to positional input)
    inputBinding:
      position: 102
      prefix: --read_1
  - id: read_2
    type:
      - 'null'
      - File
    doc: External references (e.g. short reads) for quality calibration
    inputBinding:
      position: 102
      prefix: --read_2
  - id: split
    type:
      - 'null'
      - int
    doc: Split reads at adapter sequences
    inputBinding:
      position: 102
      prefix: --split
  - id: target_bases
    type:
      - 'null'
      - int
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
    default: 1.0
    inputBinding:
      position: 102
      prefix: --window_q_weight
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/filtlong:0.3.1--h077b44d_0
stdout: filtlong.out
