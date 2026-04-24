cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - filter
label: treebest_filter
doc: "Filter alignments using TreeBest\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: alignment
    type: File
    doc: Input alignment file
    inputBinding:
      position: 1
  - id: collapse_alternative_splicing
    type:
      - 'null'
      - boolean
    doc: collapse alternative splicing
    inputBinding:
      position: 102
      prefix: -g
  - id: no_alignment_mask
    type:
      - 'null'
      - boolean
    doc: do not apply alignment mask
    inputBinding:
      position: 102
      prefix: -M
  - id: no_mask_low_scoring
    type:
      - 'null'
      - boolean
    doc: do not mask low-scoring segments
    inputBinding:
      position: 102
      prefix: -N
  - id: nucleotide_alignment
    type:
      - 'null'
      - boolean
    doc: nucleotide alignment
    inputBinding:
      position: 102
      prefix: -n
  - id: quality_cutoff
    type:
      - 'null'
      - int
    doc: quality cut-off
    inputBinding:
      position: 102
      prefix: -F
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_filter.out
