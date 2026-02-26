cwlVersion: v1.2
class: CommandLineTool
baseCommand: mummer
label: mummer
doc: "Find and output (to stdout) the positions and length of all sufficiently long
  maximal matches of a substring in <query-file> and <reference-file>\n\nTool homepage:
  https://github.com/mummer4/mummer"
inputs:
  - id: reference_file
    type: File
    doc: reference-file
    inputBinding:
      position: 1
  - id: query_files
    type:
      type: array
      items: File
    doc: query-files
    inputBinding:
      position: 2
  - id: force_4_column_output
    type:
      - 'null'
      - boolean
    doc: "force 4 column output format regardless of the number of\nreference sequence
      inputs"
    inputBinding:
      position: 103
      prefix: -F
  - id: forward_reverse_complement
    type:
      - 'null'
      - boolean
    doc: compute forward and reverse complement matches
    inputBinding:
      position: 103
      prefix: -b
  - id: match_only_acgt
    type:
      - 'null'
      - boolean
    doc: "match only the characters a, c, g, or t\nthey can be in upper or in lower
      case"
    inputBinding:
      position: 103
      prefix: -n
  - id: maxmatch
    type:
      - 'null'
      - boolean
    doc: compute all maximal matches regardless of their uniqueness
    inputBinding:
      position: 103
      prefix: -maxmatch
  - id: min_match_length
    type:
      - 'null'
      - int
    doc: set the minimum length of a match
    default: 20
    inputBinding:
      position: 103
      prefix: -l
  - id: mum
    type:
      - 'null'
      - boolean
    doc: compute maximal matches that are unique in both sequences
    inputBinding:
      position: 103
      prefix: -mum
  - id: mumcand
    type:
      - 'null'
      - boolean
    doc: same as -mumreference
    inputBinding:
      position: 103
      prefix: -mumcand
  - id: mumreference
    type:
      - 'null'
      - boolean
    doc: compute maximal matches that are unique in the reference- sequence but 
      not necessarily in the query-sequence (default)
    default: true
    inputBinding:
      position: 103
      prefix: -mumreference
  - id: report_reverse_complement_query_position
    type:
      - 'null'
      - boolean
    doc: "report the query-position of a reverse complement match\nrelative to the
      original query sequence"
    inputBinding:
      position: 103
      prefix: -c
  - id: reverse_complement_only
    type:
      - 'null'
      - boolean
    doc: only compute reverse complement matches
    inputBinding:
      position: 103
      prefix: -r
  - id: show_matching_substrings
    type:
      - 'null'
      - boolean
    doc: show the matching substrings
    inputBinding:
      position: 103
      prefix: -s
  - id: show_query_sequence_length
    type:
      - 'null'
      - boolean
    doc: show the length of the query sequences on the header line
    inputBinding:
      position: 103
      prefix: -L
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
stdout: mummer.out
