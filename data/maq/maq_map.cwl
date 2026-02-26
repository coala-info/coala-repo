cwlVersion: v1.2
class: CommandLineTool
baseCommand: maq_map
label: maq_map
doc: "Map reads to a reference genome\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: output_map
    type: File
    doc: Output map file
    inputBinding:
      position: 1
  - id: chr_bfa
    type: File
    doc: Reference genome BFA file
    inputBinding:
      position: 2
  - id: reads_1_bfq
    type: File
    doc: First read file (BFQ format)
    inputBinding:
      position: 3
  - id: reads_2_bfq
    type:
      - 'null'
      - File
    doc: Second read file (BFQ format, for paired-end reads)
    inputBinding:
      position: 4
  - id: adapter_sequence_file
    type:
      - 'null'
      - File
    doc: adapter sequence file
    default: 'null'
    inputBinding:
      position: 105
      prefix: -d
  - id: difference_rate
    type:
      - 'null'
      - float
    doc: rate of difference between reads and references
    default: 0.001
    inputBinding:
      position: 105
      prefix: -m
  - id: disable_smith_waterman
    type:
      - 'null'
      - boolean
    doc: disable Smith-Waterman alignment
    inputBinding:
      position: 105
      prefix: -W
  - id: length_first_read
    type:
      - 'null'
      - int
    doc: length of the first read (<=127)
    default: 0
    inputBinding:
      position: 105
      prefix: '-1'
  - id: length_second_read
    type:
      - 'null'
      - int
    doc: length of the second read (<=127)
    default: 0
    inputBinding:
      position: 105
      prefix: '-2'
  - id: match_colorspace
    type:
      - 'null'
      - boolean
    doc: match in the colorspace
    inputBinding:
      position: 105
      prefix: -c
  - id: max_hits_output
    type:
      - 'null'
      - int
    doc: max number of hits to output. >512 for all 01 hits.
    default: 250
    inputBinding:
      position: 105
      prefix: -C
  - id: max_mismatch_quality_sum
    type:
      - 'null'
      - int
    doc: maximum allowed sum of qualities of mismatches
    default: 70
    inputBinding:
      position: 105
      prefix: -e
  - id: max_paired_distance
    type:
      - 'null'
      - int
    doc: max distance between two paired reads
    default: 250
    inputBinding:
      position: 105
      prefix: -a
  - id: max_rf_paired_distance
    type:
      - 'null'
      - int
    doc: max distance between two RF paired reads
    default: 0
    inputBinding:
      position: 105
      prefix: -A
  - id: methylation_alignment_mode
    type:
      - 'null'
      - string
    doc: methylation alignment mode [c|g]
    default: 'null'
    inputBinding:
      position: 105
      prefix: -M
  - id: mismatches_first_24bp
    type:
      - 'null'
      - int
    doc: number of mismatches in the first 24bp
    default: 2
    inputBinding:
      position: 105
      prefix: -n
  - id: multiple_hits_file
    type:
      - 'null'
      - File
    doc: dump multiple/all 01-mismatch hits to FILE
    default: 'null'
    inputBinding:
      position: 105
      prefix: -H
  - id: seed_random_generator
    type:
      - 'null'
      - int
    doc: seed for random number generator
    default: random
    inputBinding:
      position: 105
      prefix: -s
  - id: trim_reads
    type:
      - 'null'
      - boolean
    doc: trim all reads (usually not recommended)
    inputBinding:
      position: 105
      prefix: -t
  - id: unmapped_reads_file
    type:
      - 'null'
      - File
    doc: dump unmapped and poorly aligned reads to FILE
    default: 'null'
    inputBinding:
      position: 105
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_map.out
