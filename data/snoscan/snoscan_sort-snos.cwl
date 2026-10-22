cwlVersion: v1.2
class: CommandLineTool
baseCommand: sort-snos
label: snoscan_sort-snos
doc: "Sort snoRNA hits by overall score\n\nTool homepage: http://lowelab.ucsc.edu/snoscan"
inputs:
  - id: hits_file
    type: File
    doc: snoRNA hits file written by snoscan
    inputBinding:
      position: 2
  - id: sort_by_rrna_position
    type:
      - 'null'
      - boolean
    doc: Sort snos by Position of complementarity on rRNA
    inputBinding:
      position: 1
      prefix: -P
  - id: sort_by_query_position
    type:
      - 'null'
      - boolean
    doc: Sort snos by position of hit in query sequence
    inputBinding:
      position: 1
      prefix: -H
  - id: remove_duplicates_both_bounds
    type:
      - 'null'
      - boolean
    doc: Sort snos by position and remove lower-scoring duplicate hits (both start
      and end bounds must match)
    inputBinding:
      position: 1
      prefix: -R
  - id: remove_duplicates_start_bound
    type:
      - 'null'
      - boolean
    doc: Same as -R, but only the start bound must match to count as duplicate
    inputBinding:
      position: 1
      prefix: -r
  - id: only_mapped
    type:
      - 'null'
      - boolean
    doc: Sort snos, output only hits to Mapped sites
    inputBinding:
      position: 1
      prefix: -M
  - id: only_unmapped
    type:
      - 'null'
      - boolean
    doc: Sort snos, output only hits to Unmapped sites
    inputBinding:
      position: 1
      prefix: -U
  - id: top_hits
    type:
      - 'null'
      - int
    doc: Sort snos, output only top N hits per meth site (default 50)
    inputBinding:
      position: 1
      prefix: -T
  - id: min_score
    type:
      - 'null'
      - float
    doc: Sort snos, require minimum score
    inputBinding:
      position: 1
      prefix: -S
  - id: max_score
    type:
      - 'null'
      - float
    doc: Sort snos, do not include hits over this maximum score
    inputBinding:
      position: 1
      prefix: -m
  - id: header_expression
    type:
      - 'null'
      - string
    doc: Extract only snos with this expression in the header line
    inputBinding:
      position: 1
      prefix: -e
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: Do not sort, just filter and output in the same order
    inputBinding:
      position: 1
      prefix: -F
outputs:
  - id: stdout
    type: stdout
    doc: Sorted snoRNA hits
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snoscan:1.0--pl5321h031d066_5
stdout: snoscan_sort-snos.out
