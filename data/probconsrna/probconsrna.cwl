cwlVersion: v1.2
class: CommandLineTool
baseCommand: probconsrna
label: probconsrna
doc: "PROBCONS RNA is a tool for probabilistic consistency-based multiple alignment
  of RNA sequences.\n\nTool homepage: http://probcons.stanford.edu/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input MFA (Multi-Fasta) files to be aligned
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
    doc: Use ClustalW output format instead of MFA
    inputBinding:
      position: 102
      prefix: -clustalw
  - id: consistency
    type:
      - 'null'
      - int
    doc: Use REPS passes of consistency transformation
    default: 2
    inputBinding:
      position: 102
      prefix: --consistency
  - id: iterative_refinement
    type:
      - 'null'
      - int
    doc: Use REPS passes of iterative-refinement
    default: 100
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
    doc: Use REPS passes of pre-training
    default: 0
    inputBinding:
      position: 102
      prefix: --pre-training
  - id: train
    type:
      - 'null'
      - File
    doc: Compute EM transition probabilities and store in FILENAME
    inputBinding:
      position: 102
      prefix: --train
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Report progress while aligning
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/probconsrna:1.10--h9f5acd7_4
stdout: probconsrna.out
