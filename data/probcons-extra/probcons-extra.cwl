cwlVersion: v1.2
class: CommandLineTool
baseCommand: probcons
label: probcons-extra
doc: "PROBCONS is a tool for generating multiple alignments of protein sequences using
  probabilistic modeling and consistency-based alignment techniques.\n\nTool homepage:
  http://probcons.stanford.edu/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input sequences in MFA format
    inputBinding:
      position: 1
  - id: alignment_order
    type:
      - 'null'
      - boolean
    doc: print sequences in alignment order rather than input order
    inputBinding:
      position: 102
      prefix: --alignment-order
  - id: clustalw
    type:
      - 'null'
      - boolean
    doc: use CLUSTALW output format instead of MFA
    inputBinding:
      position: 102
      prefix: -clustalw
  - id: consistency
    type:
      - 'null'
      - int
    doc: use 0 <= REPS <= 5 passes of consistency transformation
    inputBinding:
      position: 102
      prefix: --consistency
  - id: epochs
    type:
      - 'null'
      - int
    doc: estimate parameters using REPS epochs
    inputBinding:
      position: 102
      prefix: --epochs
  - id: iterative_refinement
    type:
      - 'null'
      - int
    doc: use 0 <= REPS <= 1000 passes of iterative-refinement
    inputBinding:
      position: 102
      prefix: --iterative-refinement
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: generate all-pairs pairwise alignments
    inputBinding:
      position: 102
      prefix: -pairs
  - id: paramfile
    type:
      - 'null'
      - File
    doc: read parameters from FILENAME
    inputBinding:
      position: 102
      prefix: --paramfile
  - id: pre_training
    type:
      - 'null'
      - int
    doc: use 0 <= REPS <= 20 passes of EM pre-training
    inputBinding:
      position: 102
      prefix: --pre-training
  - id: train
    type:
      - 'null'
      - File
    doc: compute EM transitions using parameter file
    inputBinding:
      position: 102
      prefix: --train
  - id: viterbi
    type:
      - 'null'
      - boolean
    doc: 'use Viterbi algorithm to generate all pairs (default: posterior decoding)'
    inputBinding:
      position: 102
      prefix: -viterbi
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/probcons-extra:v1.12-12-deb_cv1
stdout: probcons-extra.out
