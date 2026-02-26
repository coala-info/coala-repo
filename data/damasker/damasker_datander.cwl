cwlVersion: v1.2
class: CommandLineTool
baseCommand: datander
label: damasker_datander
doc: "Searches for k-mers in overlapping bands and identifies alignments based on
  specified criteria.\n\nTool homepage: https://github.com/thegenemyers/DAMASKER"
inputs:
  - id: subject_db
    type:
      type: array
      items: string
    doc: Subject database (db or dam)
    inputBinding:
      position: 1
  - id: band_width
    type:
      - 'null'
      - int
    doc: Look for k-mers in averlapping bands of size 2^-w.
    default: 4
    inputBinding:
      position: 102
      prefix: -w
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (must be <= 32).
    default: 12
    inputBinding:
      position: 102
      prefix: -k
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Look for alignments of length >= -l.
    default: 500
    inputBinding:
      position: 102
      prefix: -l
  - id: seed_hit_threshold
    type:
      - 'null'
      - int
    doc: A seed hit if the k-mers in band cover >= -h bps in the targest read.
    default: 35
    inputBinding:
      position: 102
      prefix: -h
  - id: similarity_threshold
    type:
      - 'null'
      - float
    doc: Look for alignments with -e percent similarity.
    default: 0.7
    inputBinding:
      position: 102
      prefix: -e
  - id: sort_merge_dir
    type:
      - 'null'
      - Directory
    doc: Do first level sort and merge in directory -P.
    default: /tmp
    inputBinding:
      position: 102
      prefix: -P
  - id: threads
    type:
      - 'null'
      - int
    doc: Use -T threads.
    default: 4
    inputBinding:
      position: 102
      prefix: -T
  - id: trace_point_spacing
    type:
      - 'null'
      - int
    doc: Use -s as the trace point spacing for encoding alignments.
    default: 100
    inputBinding:
      position: 102
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, output statistics as proceed.
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
stdout: damasker_datander.out
