cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - stag
  - train
label: stag_train
doc: "Train a STAG database\n\nTool homepage: https://github.com/zellerlab/stag"
inputs:
  - id: fasta_seqs
    type: File
    doc: sequences to be aligned (fasta format)
    inputBinding:
      position: 101
      prefix: -i
  - id: features_threshold
    type:
      - 'null'
      - int
    doc: threshold for the number of features per sequence (percentage)
    inputBinding:
      position: 101
      prefix: -m
  - id: force_rewrite
    type:
      - 'null'
      - boolean
    doc: force to rewrite output file
    inputBinding:
      position: 101
      prefix: -f
  - id: hmmfile
    type: File
    doc: hmmfile or cmfile to used as template for the alignment
    inputBinding:
      position: 101
      prefix: -a
  - id: logistic_regression_penalty
    type:
      - 'null'
      - string
    doc: penalty for the logistic regression
    inputBinding:
      position: 101
      prefix: -e
  - id: logistic_regression_solver
    type:
      - 'null'
      - string
    doc: solver for the logistic regression
    inputBinding:
      position: 101
      prefix: -E
  - id: protein_seqs
    type:
      - 'null'
      - File
    doc: protein sequences, corresponding to -i
    inputBinding:
      position: 101
      prefix: -p
  - id: save_alignment_file
    type:
      - 'null'
      - File
    doc: save intermediate alignment file
    inputBinding:
      position: 101
      prefix: -S
  - id: save_cross_validation_results
    type:
      - 'null'
      - File
    doc: save intermediate cross validation results
    inputBinding:
      position: 101
      prefix: -C
  - id: taxonomy_file
    type: File
    doc: taxonomy file (tab separated)
    inputBinding:
      position: 101
      prefix: -x
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: use_cmfile
    type:
      - 'null'
      - boolean
    doc: set if you are using a cmfile
    inputBinding:
      position: 101
      prefix: -c
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: 'verbose level: 1=error, 2=warning, 3=message, 4+=debugging'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_db
    type: File
    doc: output file name (HDF5 format)
    outputBinding:
      glob: $(inputs.output_db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stag:0.8.3--pyhdfd78af_1
