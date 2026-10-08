cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gfatools
  - asm
label: gfatools_asm
doc: "Perform miniasm-like assembly graph operations on a GFA graph. The operations run in a fixed order: transitive reduction (-r), cut tips (-t), pop bubbles (-b), pop bubbles with small tips (-B), cut short overlaps (-o), cut overlaps topology aware (-c), unitigs (-u). Array options can be repeated, e.g. two -t values run two rounds.\n\nTool homepage: https://github.com/lh3/gfatools"
inputs:
  - id: input_gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 200
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: verbose level
    inputBinding:
      position: 101
      prefix: -v
  - id: transitive_reduction_length
    type:
      - 'null'
      - int
    doc: transitive reduction (fuzzy length)
    inputBinding:
      position: 102
      prefix: -r
  - id: cut_tips
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -t
    doc: "cut tips (tip seg count, tip length [inf]). Give each round as one comma-joined value."
    inputBinding:
      position: 103
  - id: pop_bubbles
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -b
    doc: "pop bubbles (max radius, max deletions [inf]). Give each round as one comma-joined value."
    inputBinding:
      position: 104
  - id: pop_bubbles_small_tips
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -B
    doc: "pop bubbles along with small tips (max radius, max del [inf]). Give each round as one comma-joined value."
    inputBinding:
      position: 105
  - id: cut_short_overlaps
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -o
    doc: "cut short overlaps (ratio to the longest overlap, overlap length [0]). Give each round as one comma-joined value."
    inputBinding:
      position: 106
  - id: cut_overlaps_topology_aware
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -c
    doc: "cut overlaps, topology aware (ratio, tip seg count [3], tip length [inf]). Give each round as one comma-joined value."
    inputBinding:
      position: 107
  - id: generate_unitigs
    type:
      - 'null'
      - boolean
    doc: generate unitigs
    inputBinding:
      position: 108
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
stdout: gfatools_asm.out
