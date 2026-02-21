cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - trimfq
label: seqtk_trimfq
doc: "Trim low-quality regions from FASTQ sequences\n\nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: error_rate_threshold
    type:
      - 'null'
      - float
    doc: error rate threshold (disabled by -b/-e)
    default: 0.05
    inputBinding:
      position: 102
      prefix: -q
  - id: force_fastq
    type:
      - 'null'
      - boolean
    doc: force FASTQ output
    inputBinding:
      position: 102
      prefix: -Q
  - id: min_length
    type:
      - 'null'
      - int
    doc: maximally trim down to INT bp (disabled by -b/-e)
    default: 30
    inputBinding:
      position: 102
      prefix: -l
  - id: retain_max_length
    type:
      - 'null'
      - int
    doc: retain at most INT bp from the 5'-end (non-zero to disable -q/-l)
    default: 0
    inputBinding:
      position: 102
      prefix: -L
  - id: trim_left
    type:
      - 'null'
      - int
    doc: trim INT bp from left (non-zero to disable -q/-l)
    default: 0
    inputBinding:
      position: 102
      prefix: -b
  - id: trim_right
    type:
      - 'null'
      - int
    doc: trim INT bp from right (non-zero to disable -q/-l)
    default: 0
    inputBinding:
      position: 102
      prefix: -e
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_trimfq.out
