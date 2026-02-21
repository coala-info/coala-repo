cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pwalign
label: treebest_pwalign
doc: "PairWise ALIGNment tool for nt2nt, aa2aa, nt2aa, or splice alignments\n\nTool
  homepage: https://github.com/lh3/treebest"
inputs:
  - id: mode
    type: string
    doc: 'Alignment mode: nt2nt, aa2aa, nt2aa, or splice'
    inputBinding:
      position: 1
  - id: seq1
    type: File
    doc: First sequence file
    inputBinding:
      position: 2
  - id: seq2
    type: File
    doc: Second sequence file
    inputBinding:
      position: 3
  - id: bad_splicing_penalty
    type:
      - 'null'
      - int
    doc: bad splicing penalty
    inputBinding:
      position: 104
      prefix: -b
  - id: band_width
    type:
      - 'null'
      - int
    doc: band-width
    inputBinding:
      position: 104
      prefix: -w
  - id: boundaries_only
    type:
      - 'null'
      - boolean
    doc: just calculate alignment boundaries
    inputBinding:
      position: 104
      prefix: -d
  - id: frame_shift_penalty
    type:
      - 'null'
      - int
    doc: frame-shift penalty for aa2nt
    inputBinding:
      position: 104
      prefix: -s
  - id: full_alignment
    type:
      - 'null'
      - boolean
    doc: generate full alignment
    inputBinding:
      position: 104
      prefix: -f
  - id: gap_end_penalty
    type:
      - 'null'
      - int
    doc: gap end penalty for nt2nt or aa2aa
    inputBinding:
      position: 104
      prefix: -n
  - id: gap_extension_penalty
    type:
      - 'null'
      - int
    doc: gap extension penalty
    inputBinding:
      position: 104
      prefix: -e
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: gap open penalty
    inputBinding:
      position: 104
      prefix: -o
  - id: good_splicing_penalty
    type:
      - 'null'
      - int
    doc: good splicing penalty
    inputBinding:
      position: 104
      prefix: -g
  - id: no_matrix_mean
    type:
      - 'null'
      - boolean
    doc: do not apply matrix mean in local alignment
    inputBinding:
      position: 104
      prefix: -a
  - id: output_misc
    type:
      - 'null'
      - boolean
    doc: output miscellaneous information
    inputBinding:
      position: 104
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_pwalign.out
