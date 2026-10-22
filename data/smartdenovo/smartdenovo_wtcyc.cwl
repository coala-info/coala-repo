cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtcyc
label: smartdenovo_wtcyc
doc: "WTCYC: Align long read against its reverse complementary (SMARTdenovo)\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs:
  - id: long_read_file
    type: File
    doc: "Long reads file"
    inputBinding:
      position: 102
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads, [1]"
    inputBinding:
      position: 101
      prefix: -t
  - id: total_parallel_jobs
    type:
      - 'null'
      - int
    doc: "Total parallel jobs, [1]"
    inputBinding:
      position: 101
      prefix: -P
  - id: current_job_index
    type:
      - 'null'
      - int
    doc: "Index of current job (0-based), [0]"
    inputBinding:
      position: 101
      prefix: -p
  - id: output_path
    type: string
    doc: "Output of reads' regions after trimming, [-]"
    inputBinding:
      position: 101
      prefix: -o
  - id: alignments_path
    type:
      - 'null'
      - string
    doc: "Output of alignments, [NULL]"
    inputBinding:
      position: 101
      prefix: -a
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "Force overwrite output file"
    inputBinding:
      position: 101
      prefix: -f
  - id: min_score
    type:
      - 'null'
      - int
    doc: "Mininum alignment score, [400]"
    inputBinding:
      position: 101
      prefix: -s
  - id: min_identity
    type:
      - 'null'
      - float
    doc: "Mininum alignment identity, [0.7]"
    inputBinding:
      position: 101
      prefix: -m
  - id: penalty_match
    type:
      - 'null'
      - int
    doc: "Alignment penalty: match, [2]"
    inputBinding:
      position: 101
      prefix: -M
  - id: penalty_mismatch
    type:
      - 'null'
      - int
    doc: "Alignment penalty: mismatch, [-5]"
    inputBinding:
      position: 101
      prefix: -X
  - id: penalty_gap_open
    type:
      - 'null'
      - int
    doc: "Alignment penalty: gap open, [-3]"
    inputBinding:
      position: 101
      prefix: -O
  - id: penalty_gap_extension
    type:
      - 'null'
      - int
    doc: "Alignment penalty: gap extension, [-1]"
    inputBinding:
      position: 101
      prefix: -E
  - id: penalty_end_clipping
    type:
      - 'null'
      - int
    doc: "Alignment penalty: read end clipping, 0: disable HSP extension, otherwise set to -30 or other [-100]"
    inputBinding:
      position: 101
      prefix: -T
  - id: bandwidth
    type:
      - 'null'
      - int
    doc: "Bandwidth, [800]"
    inputBinding:
      position: 101
      prefix: -W
outputs:
  - id: output
    type: File
    doc: "Reads' regions after trimming"
    outputBinding:
      glob: $(inputs.output_path)
  - id: alignments
    type:
      - 'null'
      - File
    doc: Alignments
    outputBinding:
      glob: $(inputs.alignments_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
