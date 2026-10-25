cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslFilter
label: ucsc-pslfilter
doc: "filter out psl file\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: "Input PSL file (a directory of PSL files with -dir)."
    inputBinding:
      position: 1
  - id: out_psl
    type: string
    doc: "Output PSL file name."
    inputBinding:
      position: 2
  - id: dir
    type:
      - 'null'
      - boolean
    doc: "Input files are directories rather than single files."
    inputBinding:
      position: 0
      prefix: "-dir"
  - id: reward
    type:
      - 'null'
      - int
    doc: "Bonus to score for match (default 1)."
    inputBinding:
      position: 0
      prefix: "-reward="
      separate: false
  - id: cost
    type:
      - 'null'
      - int
    doc: "Penalty to score for mismatch (default 1)."
    inputBinding:
      position: 0
      prefix: "-cost="
      separate: false
  - id: gap_open_cost
    type:
      - 'null'
      - int
    doc: "Penalty for gap opening (default 4)."
    inputBinding:
      position: 0
      prefix: "-gapOpenCost="
      separate: false
  - id: gap_size_log_mod
    type:
      - 'null'
      - float
    doc: "Penalty for gap sizes (default 1.00)."
    inputBinding:
      position: 0
      prefix: "-gapSizeLogMod="
      separate: false
  - id: min_score
    type:
      - 'null'
      - int
    doc: "Minimum score to pass filter (default 15)."
    inputBinding:
      position: 0
      prefix: "-minScore="
      separate: false
  - id: min_match
    type:
      - 'null'
      - int
    doc: "Minimum match, including repeats, to pass (default 30)."
    inputBinding:
      position: 0
      prefix: "-minMatch="
      separate: false
  - id: min_unique_match
    type:
      - 'null'
      - int
    doc: "Minimum non-repeats to pass (default 20)."
    inputBinding:
      position: 0
      prefix: "-minUniqueMatch="
      separate: false
  - id: max_bad_ppt
    type:
      - 'null'
      - int
    doc: "Maximum divergence in parts per thousand (default 700)."
    inputBinding:
      position: 0
      prefix: "-maxBadPpt="
      separate: false
  - id: min_ali
    type:
      - 'null'
      - int
    doc: "Minimum ratio of query in alignment in ppt (default 600)."
    inputBinding:
      position: 0
      prefix: "-minAli="
      separate: false
  - id: no_head
    type:
      - 'null'
      - boolean
    doc: "Don't output psl header."
    inputBinding:
      position: 0
      prefix: "-noHead"
  - id: min_ali_t
    type:
      - 'null'
      - int
    doc: "Like minAli for target (default 0)."
    inputBinding:
      position: 0
      prefix: "-minAliT="
      separate: false
outputs:
  - id: out_file
    type: File
    doc: "Filtered PSL file."
    outputBinding:
      glob: $(inputs.out_psl)
  - id: stderr
    type: stderr
    doc: "Standard error"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslfilter:482--h0b57e2e_0
stderr: ucsc-pslfilter.err
