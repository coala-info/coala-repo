cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslCDnaFilter
label: ucsc-pslcdnafilter
doc: "Filter psl alignments of cDNA to genomic sequences.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: Input PSL file.
    inputBinding:
      position: 1
  - id: best_overlap
    type:
      - 'null'
      - boolean
    doc: Filter for the best overlapping alignment for each part of the query.
    inputBinding:
      position: 102
      prefix: -bestOverlap
  - id: filter_near_top
    type:
      - 'null'
      - float
    doc: Filter alignments within this fraction of the top score.
    inputBinding:
      position: 102
      prefix: -filterNearTop
  - id: global_near_best
    type:
      - 'null'
      - float
    doc: Filter alignments within this fraction of the global best score.
    inputBinding:
      position: 102
      prefix: -globalNearBest
  - id: ignore_size
    type:
      - 'null'
      - boolean
    doc: Ignore the size of the query when calculating coverage.
    inputBinding:
      position: 102
      prefix: -ignoreSize
  - id: max_aligns
    type:
      - 'null'
      - int
    doc: Maximum number of alignments to output for each query.
    inputBinding:
      position: 102
      prefix: -maxAligns
  - id: min_cover
    type:
      - 'null'
      - float
    doc: Minimum fraction of coverage. Default is 0.0.
    inputBinding:
      position: 102
      prefix: -minCover
  - id: min_id
    type:
      - 'null'
      - float
    doc: Minimum fraction of identity. Default is 0.0.
    inputBinding:
      position: 102
      prefix: -minId
  - id: min_id_insert
    type:
      - 'null'
      - boolean
    doc: Minimum identity including insertions.
    inputBinding:
      position: 102
      prefix: -minIdInsert
outputs:
  - id: out_psl
    type: File
    doc: Output filtered PSL file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslcdnafilter:482--h0b57e2e_0
