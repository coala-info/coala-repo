cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslFilter
label: ucsc-pslfilter
doc: "Filter PSL files based on score, identity, coverage, and other criteria.\n\n\
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_in
    type: File
    doc: Input PSL file
    inputBinding:
      position: 1
  - id: best
    type:
      - 'null'
      - boolean
    doc: Only output best match for each query
    inputBinding:
      position: 102
      prefix: -best
  - id: ignore_introns
    type:
      - 'null'
      - boolean
    doc: Ignore introns when calculating score/id
    inputBinding:
      position: 102
      prefix: -ignoreIntrons
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum gap size is N
    inputBinding:
      position: 102
      prefix: -maxGap
  - id: min_cover
    type:
      - 'null'
      - float
    doc: Minimum coverage is N.N (0.0 to 1.0)
    inputBinding:
      position: 102
      prefix: -minCover
  - id: min_id
    type:
      - 'null'
      - float
    doc: Minimum identity is N.N (0.0 to 1.0)
    inputBinding:
      position: 102
      prefix: -minId
  - id: min_score
    type:
      - 'null'
      - int
    doc: Minimum score is N
    inputBinding:
      position: 102
      prefix: -minScore
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum size is N
    inputBinding:
      position: 102
      prefix: -minSize
  - id: nohead
    type:
      - 'null'
      - boolean
    doc: Don't output PSL header
    inputBinding:
      position: 102
      prefix: -nohead
  - id: non_size
    type:
      - 'null'
      - int
    doc: Minimum size of non-gap is N
    inputBinding:
      position: 102
      prefix: -nonSize
outputs:
  - id: psl_out
    type: File
    doc: Output filtered PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslfilter:482--h0b57e2e_0
