cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfatools_asm
label: gfatools_asm
doc: "Perform assembly operations on a GFA graph.\n\nTool homepage: https://github.com/lh3/gfatools"
inputs:
  - id: input_gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 1
  - id: cut_overlaps_topology_aware
    type:
      - 'null'
      - type: array
        items: string
    doc: cut overlaps, topology aware (ratio, tip seg count [3], tip length 
      [inf])
    inputBinding:
      position: 102
      prefix: -c
  - id: cut_short_overlaps
    type:
      - 'null'
      - type: array
        items: string
    doc: cut short overlaps (ratio to the longest overlap, overlap length [0])
    inputBinding:
      position: 102
      prefix: -o
  - id: cut_tips
    type:
      - 'null'
      - type: array
        items: string
    doc: cut tips (tip seg count, tip length [inf])
    inputBinding:
      position: 102
      prefix: -t
  - id: generate_unitigs
    type:
      - 'null'
      - boolean
    doc: generate unitigs
    inputBinding:
      position: 102
      prefix: -u
  - id: pop_bubbles
    type:
      - 'null'
      - type: array
        items: string
    doc: pop bubbles (max radius, max deletions [inf])
    inputBinding:
      position: 102
      prefix: -b
  - id: pop_bubbles_small_tips
    type:
      - 'null'
      - type: array
        items: string
    doc: pop bubbles along with small tips (max radius, max del [inf])
    inputBinding:
      position: 102
      prefix: -B
  - id: transitive_reduction_length
    type:
      - 'null'
      - int
    doc: transitive reduction (fuzzy length)
    inputBinding:
      position: 102
      prefix: -r
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: verbose level
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
stdout: gfatools_asm.out
