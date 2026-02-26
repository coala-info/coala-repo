cwlVersion: v1.2
class: CommandLineTool
baseCommand: ../e-mem
label: e-mem
doc: "E-MEM finds and outputs the position and length of all maximal exact matches
  (MEMs) between <query-file> and <reference-file>\n\nTool homepage: https://github.com/EverMind-AI/EverMemOS"
inputs:
  - id: reference_file
    type: File
    doc: Reference file
    inputBinding:
      position: 1
  - id: query_file
    type: File
    doc: Query file
    inputBinding:
      position: 2
  - id: force_4_column_output
    type:
      - 'null'
      - boolean
    doc: "force 4 column output format regardless of the number of\nreference sequence
      input"
    inputBinding:
      position: 103
      prefix: -F
  - id: forward_and_reverse_complement
    type:
      - 'null'
      - boolean
    doc: compute forward and reverse complement matches
    inputBinding:
      position: 103
      prefix: -b
  - id: min_length
    type:
      - 'null'
      - int
    doc: "set the minimum length of a match. The default length\nis 50"
    default: 50
    inputBinding:
      position: 103
      prefix: -l
  - id: nucleotide_only
    type:
      - 'null'
      - boolean
    doc: "match only the characters a, c, g, or t\nthey can be in upper or in lower
      case"
    inputBinding:
      position: 103
      prefix: -n
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
  - id: show_query_length_header
    type:
      - 'null'
      - boolean
    doc: show the length of the query sequences on the header line
    inputBinding:
      position: 103
      prefix: -L
  - id: split_size
    type:
      - 'null'
      - int
    doc: set the split size. The default value is 1
    default: 1
    inputBinding:
      position: 103
      prefix: -d
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads. The default is 1 thread
    default: 1
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/e-mem:v1.0.1-2-deb_cv1
stdout: e-mem.out
