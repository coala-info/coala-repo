cwlVersion: v1.2
class: CommandLineTool
baseCommand: vmatch
label: vmatch
doc: "vmatch\n\nTool homepage: http://www.vmatch.de/"
inputs:
  - id: complete
    type:
      - 'null'
      - boolean
    doc: specify that query sequences must match completely
    inputBinding:
      position: 101
      prefix: --complete
  - id: direct_matches
    type:
      - 'null'
      - boolean
    doc: compute direct matches (default)
    default: true
    inputBinding:
      position: 101
      prefix: --d
  - id: edit_distance
    type:
      - 'null'
      - int
    doc: specify the allowed edit distance > 0
    inputBinding:
      position: 101
      prefix: -e
  - id: edit_xdrop
    type:
      - 'null'
      - int
    doc: specify the xdrop value for edit distance extension
    inputBinding:
      position: 101
      prefix: --exdrop
  - id: evalue
    type:
      - 'null'
      - float
    doc: specify the maximum E-value of a match
    inputBinding:
      position: 101
      prefix: --evalue
  - id: hamming_distance
    type:
      - 'null'
      - int
    doc: specify the allowed hamming distance > 0
    inputBinding:
      position: 101
      prefix: -h
  - id: hamming_xdrop
    type:
      - 'null'
      - int
    doc: specify the xdrop value for hamming distance extension
    inputBinding:
      position: 101
      prefix: --hxdrop
  - id: least_score
    type:
      - 'null'
      - int
    doc: specify the minimum score of a match
    inputBinding:
      position: 101
      prefix: --leastscore
  - id: match_length
    type:
      - 'null'
      - int
    doc: specify that match must have the given length
    inputBinding:
      position: 101
      prefix: -l
  - id: min_identity
    type:
      - 'null'
      - int
    doc: specify minimum identity of match in range [1..100%]
    inputBinding:
      position: 101
      prefix: --identity
  - id: online
    type:
      - 'null'
      - boolean
    doc: run algorithms online without using the index
    inputBinding:
      position: 101
      prefix: --online
  - id: palindromic_matches
    type:
      - 'null'
      - boolean
    doc: compute palindromic (i.e. reverse complemented matches)
    inputBinding:
      position: 101
      prefix: --p
  - id: queries
    type:
      - 'null'
      - File
    doc: specify files containing queries to be matched
    inputBinding:
      position: 101
      prefix: -q
  - id: show_alignment
    type:
      - 'null'
      - boolean
    doc: show the alignment of matching sequences
    inputBinding:
      position: 101
      prefix: -s
  - id: show_description
    type:
      - 'null'
      - boolean
    doc: show sequence description of match
    inputBinding:
      position: 101
      prefix: --showdesc
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch.out
