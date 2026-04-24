cwlVersion: v1.2
class: CommandLineTool
baseCommand: abimerge
label: nim-abif_abimerge
doc: "Merge forward and reverse AB1 trace files\n\nTool homepage: https://github.com/quadram-institute-bioscience/nim-abif"
inputs:
  - id: input_f_ab1
    type: File
    doc: Forward input AB1 file
    inputBinding:
      position: 1
  - id: input_r_ab1
    type: File
    doc: Reverse input AB1 file
    inputBinding:
      position: 2
  - id: output_fastq
    type:
      - 'null'
      - File
    doc: Output FASTQ file
    inputBinding:
      position: 3
  - id: join
    type:
      - 'null'
      - int
    doc: If no overlap is detected join the two sequences with a gap of INT Ns 
      (reverse complement the second sequence)
    inputBinding:
      position: 104
      prefix: --join
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap length for merging
    inputBinding:
      position: 104
      prefix: --min-overlap
  - id: min_score
    type:
      - 'null'
      - int
    doc: Minimum alignment score
    inputBinding:
      position: 104
      prefix: --min-score
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: Disable quality trimming
    inputBinding:
      position: 104
      prefix: --no-trim
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file name
    inputBinding:
      position: 104
      prefix: --output
  - id: pct_id
    type:
      - 'null'
      - float
    doc: Minimum percentage of identity
    inputBinding:
      position: 104
      prefix: --pct-id
  - id: quality
    type:
      - 'null'
      - int
    doc: Quality threshold 0-60
    inputBinding:
      position: 104
      prefix: --quality
  - id: score_gap
    type:
      - 'null'
      - int
    doc: Score for a gap
    inputBinding:
      position: 104
      prefix: --score-gap
  - id: score_match
    type:
      - 'null'
      - int
    doc: Score for a match
    inputBinding:
      position: 104
      prefix: --score-match
  - id: score_mismatch
    type:
      - 'null'
      - int
    doc: Score for a mismatch
    inputBinding:
      position: 104
      prefix: --score-mismatch
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print additional information
    inputBinding:
      position: 104
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - int
    doc: Window size for quality trimming
    inputBinding:
      position: 104
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nim-abif:0.2.0--h7b50bb2_0
stdout: nim-abif_abimerge.out
