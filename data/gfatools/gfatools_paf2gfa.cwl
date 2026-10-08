cwlVersion: v1.2
class: CommandLineTool
baseCommand: paf2gfa
label: gfatools_paf2gfa
doc: "Build a miniasm-like string graph (GFA) from all-vs-all read overlaps in PAF format.\n\nTool homepage: https://github.com/lh3/gfatools"
inputs:
  - id: tip_threshold
    type:
      - 'null'
      - int
    doc: "threshold for tips and small bubbles [3]"
    inputBinding:
      position: 1
      prefix: -n
  - id: both_directions
    type:
      - 'null'
      - boolean
    doc: "both directions of an arc are present in input"
    inputBinding:
      position: 1
      prefix: -b
  - id: keep_unidirectional
    type:
      - 'null'
      - boolean
    doc: "keep unidirectional edges (effective with -b)"
    inputBinding:
      position: 1
      prefix: -U
  - id: cut_filter_hits
    type:
      - 'null'
      - boolean
    doc: "cut and filter initial hits"
    inputBinding:
      position: 1
      prefix: -f
  - id: max_overhang
    type:
      - 'null'
      - float
    doc: "max overhang length [100]"
    inputBinding:
      position: 1
      prefix: -h
  - id: min_overlap
    type:
      - 'null'
      - float
    doc: "min overlap length [500]"
    inputBinding:
      position: 1
      prefix: -o
  - id: graph_cleaning
    type:
      - 'null'
      - boolean
    doc: "apply graph cleaning (up to 3)"
    inputBinding:
      position: 1
      prefix: -c
  - id: max_edge_cut_ratio
    type:
      - 'null'
      - float
    doc: "max edge cut ratio (between 0.5 and 1) [0.9]"
    inputBinding:
      position: 1
      prefix: -r
  - id: generate_unitigs
    type:
      - 'null'
      - boolean
    doc: "generate unitigs"
    inputBinding:
      position: 1
      prefix: -u
  - id: input_reads
    type:
      - 'null'
      - File
    doc: "input reads"
    inputBinding:
      position: 1
      prefix: -i
  - id: input_paf
    type: File
    doc: "Input all-vs-all overlap file in PAF format"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: "GFA graph"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
stdout: gfatools_paf2gfa.gfa
