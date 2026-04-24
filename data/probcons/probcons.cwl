cwlVersion: v1.2
class: CommandLineTool
baseCommand: probcons
label: probcons
doc: "PROBCONS is a tool for generating multiple alignments of protein sequences.
  It uses a combination of probabilistic modeling and consistency-based alignment
  techniques.\n\nTool homepage: http://probcons.stanford.edu/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input sequences in MFA (Multi-Fasta) format
    inputBinding:
      position: 1
  - id: alignment_order
    type:
      - 'null'
      - boolean
    doc: Print sequences in alignment order rather than input order
    inputBinding:
      position: 102
      prefix: --alignment-order
  - id: clustalw
    type:
      - 'null'
      - boolean
    doc: Use CLUSTALW output format instead of MFA
    inputBinding:
      position: 102
      prefix: -clustalw
  - id: consistency
    type:
      - 'null'
      - int
    doc: Use 0 <= REPS <= 5 passes of consistency transformation
    inputBinding:
      position: 102
      prefix: --consistency
  - id: epochs
    type:
      - 'null'
      - int
    doc: Number of EM epochs
    inputBinding:
      position: 102
      prefix: --epochs
  - id: iterative_refinement
    type:
      - 'null'
      - int
    doc: Use 0 <= REPS <= 1000 passes of iterative-refinement
    inputBinding:
      position: 102
      prefix: --iterative-refinement
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: Generate all-pairs pairwise alignments
    inputBinding:
      position: 102
      prefix: -pairs
  - id: paramfile
    type:
      - 'null'
      - File
    doc: Read parameters from FILENAME
    inputBinding:
      position: 102
      prefix: --paramfile
  - id: pre_training
    type:
      - 'null'
      - int
    doc: Use 0 <= REPS <= 20 rounds of pre-training
    inputBinding:
      position: 102
      prefix: --pre-training
  - id: viterbi
    type:
      - 'null'
      - boolean
    doc: Use Viterbi algorithm to generate all pairs (default is posterior 
      decoding)
    inputBinding:
      position: 102
      prefix: -viterbi
outputs:
  - id: train
    type:
      - 'null'
      - File
    doc: Compute EM transition probabilities, store in FILENAME
    outputBinding:
      glob: $(inputs.train)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/probcons:v1.12-12-deb_cv1
