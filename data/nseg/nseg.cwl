cwlVersion: v1.2
class: CommandLineTool
baseCommand: nseg
label: nseg
doc: "Identify low and high complexity regions in DNA sequences.\n\nTool homepage:
  https://github.com/jebrosen/nseg"
inputs:
  - id: file
    type: File
    doc: filename containing fasta-formatted sequence(s)
    inputBinding:
      position: 1
  - id: window
    type:
      - 'null'
      - int
    doc: window size
    default: 21
    inputBinding:
      position: 2
  - id: locut
    type:
      - 'null'
      - float
    doc: low (trigger) complexity
    default: 1.4
    inputBinding:
      position: 3
  - id: hicut
    type:
      - 'null'
      - float
    doc: high (extension) complexity
    default: locut + 0.2
    inputBinding:
      position: 4
  - id: chars_per_line
    type:
      - 'null'
      - int
    doc: number of sequence characters/line
    default: 60
    inputBinding:
      position: 105
      prefix: -c
  - id: max_segment_trim
    type:
      - 'null'
      - int
    doc: maximum trimming of raw segment
    default: 100
    inputBinding:
      position: 105
      prefix: -t
  - id: min_high_complexity_segment_length
    type:
      - 'null'
      - int
    doc: minimum length for a high-complexity segment. Shorter segments are 
      merged with adjacent low-complexity segments
    default: 0
    inputBinding:
      position: 105
      prefix: -m
  - id: no_header_info
    type:
      - 'null'
      - boolean
    doc: do not add complexity information to the header line
    inputBinding:
      position: 105
      prefix: -n
  - id: period
    type:
      - 'null'
      - int
    doc: period
    inputBinding:
      position: 105
      prefix: -z
  - id: prettyprint_block
    type:
      - 'null'
      - boolean
    doc: prettyprint each segmented sequence (block format)
    inputBinding:
      position: 105
      prefix: -q
  - id: prettyprint_tree
    type:
      - 'null'
      - boolean
    doc: prettyprint each segmented sequence (tree format)
    inputBinding:
      position: 105
      prefix: -p
  - id: show_all_segments
    type:
      - 'null'
      - boolean
    doc: show all segments (fasta format)
    inputBinding:
      position: 105
      prefix: -a
  - id: show_high_complexity_only
    type:
      - 'null'
      - boolean
    doc: show only high-complexity segments (fasta format)
    inputBinding:
      position: 105
      prefix: -h
  - id: show_low_complexity_only
    type:
      - 'null'
      - boolean
    doc: show only low-complexity segments (fasta format)
    inputBinding:
      position: 105
      prefix: -l
  - id: show_overlapping_low_complexity
    type:
      - 'null'
      - boolean
    doc: show overlapping low-complexity segments (default merge)
    inputBinding:
      position: 105
      prefix: -o
  - id: single_output_sequence
    type:
      - 'null'
      - boolean
    doc: each input sequence is represented by a single output sequence with 
      low-complexity regions replaced by strings of 'x' characters
    inputBinding:
      position: 105
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nseg:1.0.1--h516909a_0
stdout: nseg.out
