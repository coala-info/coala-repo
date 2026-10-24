cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedIntersect
label: ucsc-bedintersect
doc: "Intersect two bed files. Bed columns four (name) and five (score) are optional.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: a_bed
    type: File
    doc: First BED file (a.bed).
    inputBinding:
      position: 1
  - id: b_bed
    type: File
    doc: Second BED file (b.bed).
    inputBinding:
      position: 2
  - id: out_bed
    type: string
    doc: Name of the output BED file.
    inputBinding:
      position: 3
  - id: a_hit_any
    type:
      - 'null'
      - boolean
    doc: Output all of a if any of it is hit by b.
    inputBinding:
      position: 0
      prefix: -aHitAny
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: Min coverage of b to output match (or if -aHitAny, of a). Not applied to
      0-length items. Default 0.000010.
    inputBinding:
      position: 0
      prefix: -minCoverage=
      separate: false
  - id: b_score
    type:
      - 'null'
      - boolean
    doc: Output score from b.bed (must be at least a 5 field bed).
    inputBinding:
      position: 0
      prefix: -bScore
  - id: tab
    type:
      - 'null'
      - boolean
    doc: Chop input at tabs not spaces.
    inputBinding:
      position: 0
      prefix: -tab
  - id: allow_start_equal_end
    type:
      - 'null'
      - boolean
    doc: Do not discard 0-length items of a or b (e.g. point insertions).
    inputBinding:
      position: 0
      prefix: -allowStartEqualEnd
outputs:
  - id: output_bed
    type: File
    doc: Intersection of the two BED files.
    outputBinding:
      glob: $(inputs.out_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedintersect:482--h0b57e2e_0
