cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - delta-filter
label: mummer_delta-filter
doc: "Read a delta alignment file from either nucmer or promer and filter the alignments based on the command-line switches, leaving only the desired alignments, which are written in the same delta format as the input.\n\nTool homepage: https://github.com/mummer4/mummer"
inputs:
  - id: one_to_one
    type:
      - 'null'
      - boolean
    doc: "1-to-1 alignment allowing for rearrangements (intersection of -r and -q alignments)"
    inputBinding:
      position: 1
      prefix: "-1"
  - id: global
    type:
      - 'null'
      - boolean
    doc: "1-to-1 global alignment not allowing rearrangements"
    inputBinding:
      position: 1
      prefix: "-g"
  - id: min_identity
    type:
      - 'null'
      - float
    doc: "Set the minimum alignment identity [0, 100], default 0"
    inputBinding:
      position: 1
      prefix: "-i"
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Set the minimum alignment length, default 0"
    inputBinding:
      position: 1
      prefix: "-l"
  - id: many_to_many
    type:
      - 'null'
      - boolean
    doc: "Many-to-many alignment allowing for rearrangements (union of -r and -q alignments)"
    inputBinding:
      position: 1
      prefix: "-m"
  - id: query_best
    type:
      - 'null'
      - boolean
    doc: "Maps each position of each query to its best hit in the reference, allowing for reference overlaps"
    inputBinding:
      position: 1
      prefix: "-q"
  - id: reference_best
    type:
      - 'null'
      - boolean
    doc: "Maps each position of each reference to its best hit in the query, allowing for query overlaps"
    inputBinding:
      position: 1
      prefix: "-r"
  - id: min_uniqueness
    type:
      - 'null'
      - float
    doc: "Set the minimum alignment uniqueness, i.e. percent of the alignment matching to unique reference AND query sequence [0, 100], default 0"
    inputBinding:
      position: 1
      prefix: "-u"
  - id: max_overlap
    type:
      - 'null'
      - float
    doc: "Set the maximum alignment overlap for -r and -q options as a percent of the alignment length [0, 100], default 100"
    inputBinding:
      position: 1
      prefix: "-o"
  - id: delta_file
    type: File
    doc: "Delta alignment file from nucmer or promer"
    inputBinding:
      position: 100
outputs:
  - id: stdout_out
    type: stdout
    doc: "Filtered alignments in delta format"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
stdout: mummer_delta-filter.delta
stderr: mummer_delta-filter.log
