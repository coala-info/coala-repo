cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfaview
label: gfa1_gfaview
doc: "View and simplify a GFA graph.\n\nTool homepage: https://github.com/lh3/gfa1"
inputs:
  - id: input_gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 1
  - id: delete_segments
    type:
      - 'null'
      - string
    doc: list of segment names to delete
    default: '[]'
    inputBinding:
      position: 102
      prefix: -d
  - id: drop_shorter_overlaps
    type:
      - 'null'
      - boolean
    doc: drop shorter overlaps
    inputBinding:
      position: 102
      prefix: -o
  - id: dropped_longest_ratio
    type:
      - 'null'
      - float
    doc: dropped/longest<FLOAT, for -o
    default: 0.7
    inputBinding:
      position: 102
      prefix: -O
  - id: extract_segments
    type:
      - 'null'
      - string
    doc: list of segment names to extract
    default: '[]'
    inputBinding:
      position: 102
      prefix: -s
  - id: fuzzy_length_transitive_reduction
    type:
      - 'null'
      - int
    doc: fuzzy length for -r
    default: 1000
    inputBinding:
      position: 102
      prefix: -R
  - id: generate_unitig_graph
    type:
      - 'null'
      - boolean
    doc: generate unitig graph (unambiguous merge)
    inputBinding:
      position: 102
      prefix: -u
  - id: include_neighbors_radius
    type:
      - 'null'
      - int
    doc: include neighbors in a radius
    default: 0
    inputBinding:
      position: 102
      prefix: -S
  - id: max_bubble_dist_pop_bubbles
    type:
      - 'null'
      - int
    doc: max bubble dist for -b
    default: 50000
    inputBinding:
      position: 102
      prefix: -B
  - id: misc_trimming
    type:
      - 'null'
      - boolean
    doc: misc trimming
    inputBinding:
      position: 102
      prefix: -m
  - id: output_cigar_m_only
    type:
      - 'null'
      - boolean
    doc: only output CIGAR-M operators (for compatibility)
    inputBinding:
      position: 102
      prefix: '-1'
  - id: pop_bubbles
    type:
      - 'null'
      - boolean
    doc: pop bubbles
    inputBinding:
      position: 102
      prefix: -b
  - id: tip_length_trim_tips
    type:
      - 'null'
      - int
    doc: tip length for -t
    default: 4
    inputBinding:
      position: 102
      prefix: -T
  - id: transitive_reduction
    type:
      - 'null'
      - boolean
    doc: transitive reduction
    inputBinding:
      position: 102
      prefix: -r
  - id: trim_tips
    type:
      - 'null'
      - boolean
    doc: trim tips
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: verbose level
    default: 2
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfa1:0.53.alpha--h577a1d6_3
stdout: gfa1_gfaview.out
