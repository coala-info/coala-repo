cwlVersion: v1.2
class: CommandLineTool
baseCommand: recgraph
label: recgraph
doc: "RecGraph\n\nTool homepage: https://github.com/AlgoLab/RecGraph"
inputs:
  - id: graph_path
    type: File
    doc: Input graph (in .gfa format)
    inputBinding:
      position: 1
  - id: sequence_path
    type: File
    doc: Input sequences (in .fasta format)
    inputBinding:
      position: 2
  - id: aln_mode
    type:
      - 'null'
      - int
    doc: "0: global POA, 1: local POA, 2: affine gap POA, 3: local gap POA,\n    \
      \        4: global pathwise alignment, 5: semiglobal pathwise alignment,\n \
      \           6: global pathwise alignment with affine gap (EXPERIMENTAL),\n \
      \           7: semiglobal pathwise alignment with affine gap (EXPERIMENTAL),\n\
      \            8: global recombination alignment, 9: semiglobal recombination
      alignment"
    default: 0
    inputBinding:
      position: 103
      prefix: --aln-mode
  - id: amb_strand
    type:
      - 'null'
      - boolean
    doc: "Ambigous strand mode (experimental): try reverse complement if alignment
      score is too\n            low"
    default: false
    inputBinding:
      position: 103
      prefix: --amb-strand
  - id: base_rec_cost
    type:
      - 'null'
      - int
    doc: Recombination cost, determined with -r as R + r*(displacement_length)
    default: 4
    inputBinding:
      position: 103
      prefix: --base-rec-cost
  - id: extra_b
    type:
      - 'null'
      - int
    doc: First adaptive banding par, set < 0 to disable adaptive banded
    default: 1
    inputBinding:
      position: 103
      prefix: --extra-b
  - id: extra_f
    type:
      - 'null'
      - float
    doc: "Second adaptive banding par, number of basis added to both side of\n   \
      \                            the band = b+f*L, l = length of the sequence"
    default: 0.01
    inputBinding:
      position: 103
      prefix: --extra-f
  - id: gap_ext
    type:
      - 'null'
      - int
    doc: Gap extension penalty
    default: 2
    inputBinding:
      position: 103
      prefix: --gap-ext
  - id: gap_open
    type:
      - 'null'
      - int
    doc: Gap opening penalty
    default: 4
    inputBinding:
      position: 103
      prefix: --gap-open
  - id: match_score
    type:
      - 'null'
      - int
    doc: Match score
    default: 2
    inputBinding:
      position: 103
      prefix: --match
  - id: matrix
    type:
      - 'null'
      - File
    doc: "Scoring matrix file, if '-t' is used, '-M' and '-X' are not used and you
      should set gap\n            penalties in this case"
    default: none
    inputBinding:
      position: 103
      prefix: --matrix
  - id: mismatch_score
    type:
      - 'null'
      - int
    doc: Mismatch penalty
    default: 4
    inputBinding:
      position: 103
      prefix: --mismatch
  - id: multi_rec_cost
    type:
      - 'null'
      - float
    doc: Displacement multiplier
    default: 0.1
    inputBinding:
      position: 103
      prefix: --multi-rec-cost
  - id: rec_band_width
    type:
      - 'null'
      - int
    doc: Recombination band width
    default: 1
    inputBinding:
      position: 103
      prefix: --rec-band-width
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output alignment file
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recgraph:1.0.0--h7b50bb2_1
