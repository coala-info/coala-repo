cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainFilter
label: ucsc-chainfilter_chainFilter
doc: "Filter chain files. Output goes to standard out.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input chain file(s)
    inputBinding:
      position: 1
  - id: id
    type:
      - 'null'
      - int
    doc: only get one with ID number matching N
    inputBinding:
      position: 102
      prefix: -id=
      separate: false
  - id: long_format
    type:
      - 'null'
      - boolean
    doc: output in long format
    inputBinding:
      position: 102
      prefix: -long
  - id: max_score
    type:
      - 'null'
      - int
    doc: restrict to those scoring less than N
    inputBinding:
      position: 102
      prefix: -maxScore=
      separate: false
  - id: min_gapless
    type:
      - 'null'
      - int
    doc: pass those with minimum gapless block of at least N
    inputBinding:
      position: 102
      prefix: -minGapless=
      separate: false
  - id: min_score
    type:
      - 'null'
      - int
    doc: restrict to those scoring at least N
    inputBinding:
      position: 102
      prefix: -minScore=
      separate: false
  - id: no_hap
    type:
      - 'null'
      - boolean
    doc: suppress chains involving '_hap|_alt' chromosomes
    inputBinding:
      position: 102
      prefix: -noHap
  - id: no_random
    type:
      - 'null'
      - boolean
    doc: suppress chains involving '_random' chromosomes
    inputBinding:
      position: 102
      prefix: -noRandom
  - id: q_end_max
    type:
      - 'null'
      - int
    doc: restrict to those with qEnd less than N
    inputBinding:
      position: 102
      prefix: -qEndMax=
      separate: false
  - id: q_end_min
    type:
      - 'null'
      - int
    doc: restrict to those with qEnd at least N
    inputBinding:
      position: 102
      prefix: -qEndMin=
      separate: false
  - id: q_max_gap
    type:
      - 'null'
      - int
    doc: pass those with maximum gap size no larger than N
    inputBinding:
      position: 102
      prefix: -qMaxGap=
      separate: false
  - id: q_max_size
    type:
      - 'null'
      - int
    doc: maximum size of spanned query region
    inputBinding:
      position: 102
      prefix: -qMaxSize=
      separate: false
  - id: q_min_gap
    type:
      - 'null'
      - int
    doc: pass those with minimum gap size of at least N
    inputBinding:
      position: 102
      prefix: -qMinGap=
      separate: false
  - id: q_min_size
    type:
      - 'null'
      - int
    doc: minimum size of spanned query region
    inputBinding:
      position: 102
      prefix: -qMinSize=
      separate: false
  - id: q_overlap_end
    type:
      - 'null'
      - int
    doc: restrict to those where the query overlaps a region ending here
    inputBinding:
      position: 102
      prefix: -qOverlapEnd=
      separate: false
  - id: q_overlap_start
    type:
      - 'null'
      - int
    doc: restrict to those where the query overlaps a region starting here
    inputBinding:
      position: 102
      prefix: -qOverlapStart=
      separate: false
  - id: q_start_max
    type:
      - 'null'
      - int
    doc: restrict to those with qStart less than N
    inputBinding:
      position: 102
      prefix: -qStartMax=
      separate: false
  - id: q_start_min
    type:
      - 'null'
      - int
    doc: restrict to those with qStart at least N
    inputBinding:
      position: 102
      prefix: -qStartMin=
      separate: false
  - id: restrict_query_named
    type:
      - 'null'
      - type: array
        items: string
    doc: restrict query side sequence to those named
    inputBinding:
      position: 102
      prefix: -q=
      separate: false
  - id: restrict_query_not_named
    type:
      - 'null'
      - type: array
        items: string
    doc: restrict query side sequence to those not named
    inputBinding:
      position: 102
      prefix: -notQ=
      separate: false
  - id: restrict_target_named
    type:
      - 'null'
      - type: array
        items: string
    doc: restrict target side sequence to those named
    inputBinding:
      position: 102
      prefix: -t=
      separate: false
  - id: restrict_target_not_named
    type:
      - 'null'
      - type: array
        items: string
    doc: restrict target side sequence to those not named
    inputBinding:
      position: 102
      prefix: -notT=
      separate: false
  - id: strand
    type:
      - 'null'
      - string
    doc: restrict strand (to + or -)
    inputBinding:
      position: 102
      prefix: -strand=
      separate: false
  - id: t_end_max
    type:
      - 'null'
      - int
    doc: restrict to those with tEnd less than N
    inputBinding:
      position: 102
      prefix: -tEndMax=
      separate: false
  - id: t_end_min
    type:
      - 'null'
      - int
    doc: restrict to those with tEnd at least N
    inputBinding:
      position: 102
      prefix: -tEndMin=
      separate: false
  - id: t_max_gap
    type:
      - 'null'
      - int
    doc: pass those with maximum gap size no larger than N
    inputBinding:
      position: 102
      prefix: -tMaxGap=
      separate: false
  - id: t_max_size
    type:
      - 'null'
      - int
    doc: maximum size of spanned target region
    inputBinding:
      position: 102
      prefix: -tMaxSize=
      separate: false
  - id: t_min_gap
    type:
      - 'null'
      - int
    doc: pass those with minimum gap size of at least N
    inputBinding:
      position: 102
      prefix: -tMinGap=
      separate: false
  - id: t_min_size
    type:
      - 'null'
      - int
    doc: minimum size of spanned target region
    inputBinding:
      position: 102
      prefix: -tMinSize=
      separate: false
  - id: t_overlap_end
    type:
      - 'null'
      - int
    doc: restrict to those where the target overlaps a region ending here
    inputBinding:
      position: 102
      prefix: -tOverlapEnd=
      separate: false
  - id: t_overlap_start
    type:
      - 'null'
      - int
    doc: restrict to those where the target overlaps a region starting here
    inputBinding:
      position: 102
      prefix: -tOverlapStart=
      separate: false
  - id: t_start_max
    type:
      - 'null'
      - int
    doc: restrict to those with tStart less than N
    inputBinding:
      position: 102
      prefix: -tStartMax=
      separate: false
  - id: t_start_min
    type:
      - 'null'
      - int
    doc: restrict to those with tStart at least N
    inputBinding:
      position: 102
      prefix: -tStartMin=
      separate: false
  - id: zero_gap
    type:
      - 'null'
      - boolean
    doc: get rid of gaps of length zero
    inputBinding:
      position: 102
      prefix: -zeroGap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainfilter:482--h0b57e2e_0
stdout: ucsc-chainfilter_chainFilter.out
