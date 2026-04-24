cwlVersion: v1.2
class: CommandLineTool
baseCommand: segment
label: mosaicatcher_segment
doc: "Find a segmentation across multiple cells.\n\nTool homepage: https://github.com/friendsofstrandseq/mosaicatcher/"
inputs:
  - id: counts_file
    type: File
    doc: Input counts file
    inputBinding:
      position: 1
  - id: do_not_normalize_cells
    type:
      - 'null'
      - boolean
    doc: Instead of using cell-normalized counts for each strand, use the raw 
      numbers.
    inputBinding:
      position: 102
      prefix: --do-not-normalize-cells
  - id: do_not_remove_bad_cells
    type:
      - 'null'
      - boolean
    doc: Keep all cells (by default, cells which are marked 'None' in all bins 
      get removed
    inputBinding:
      position: 102
      prefix: --do-not-remove-bad-cells
  - id: forbid_small_segments
    type:
      - 'null'
      - int
    doc: Penalize segments shorter that this number of bins
    inputBinding:
      position: 102
      prefix: --forbid-small-segments
  - id: max_bp_intercept
    type:
      - 'null'
      - int
    doc: max. number of cp, add this constant
    inputBinding:
      position: 102
      prefix: --max_bp_intercept
  - id: max_bp_per_Mb
    type:
      - 'null'
      - float
    doc: max. number of change points per Mb
    inputBinding:
      position: 102
      prefix: --max_bp_per_Mb
  - id: max_segment
    type:
      - 'null'
      - int
    doc: maximum segment length
    inputBinding:
      position: 102
      prefix: --max_segment
  - id: penalize_none
    type:
      - 'null'
      - int
    doc: Penalize segments through removed bins (which are marked by 'None' in 
      the counts table).
    inputBinding:
      position: 102
      prefix: --penalize-none
  - id: remove_none
    type:
      - 'null'
      - boolean
    doc: Remove segments through removed bins before segmentation. Mutually 
      exclusive with --penalize-none.
    inputBinding:
      position: 102
      prefix: --remove-none
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output file for counts
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosaicatcher:0.3.1--h66ab1b6_2
