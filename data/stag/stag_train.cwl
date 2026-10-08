cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- stag
- train
label: stag_train
doc: 'Train a classifier and create a STAG database.


  Tool homepage: https://github.com/zellerlab/stag'
inputs:
- id: fasta_seqs
  type: File
  doc: sequences to be aligned (fasta format)
  inputBinding:
    position: 1
    prefix: -i
- id: protein_seqs
  type:
  - 'null'
  - File
  doc: protein sequences, corresponding to -i
  inputBinding:
    position: 1
    prefix: -p
- id: hmmfile
  type: File
  doc: hmmfile or cmfile to used as template for the alignment
  inputBinding:
    position: 1
    prefix: -a
- id: use_cmfile
  type:
  - 'null'
  - boolean
  doc: set if you are using a cmfile
  inputBinding:
    position: 1
    prefix: -c
- id: taxonomy_file
  type: File
  doc: taxonomy file (tab separated)
  inputBinding:
    position: 1
    prefix: -x
- id: output_db
  type: string
  doc: output file name (HDF5 format)
  inputBinding:
    position: 1
    prefix: -o
- id: force_rewrite
  type:
  - 'null'
  - boolean
  doc: force to rewrite output file
  inputBinding:
    position: 1
    prefix: -f
- id: save_alignment_file
  type:
  - 'null'
  - string
  doc: save intermediate alignment file
  inputBinding:
    position: 1
    prefix: -S
- id: save_cross_validation_results
  type:
  - 'null'
  - string
  doc: save intermediate cross validation results
  inputBinding:
    position: 1
    prefix: -C
- id: threads
  type:
  - 'null'
  - int
  doc: number of threads [1]
  inputBinding:
    position: 1
    prefix: -t
- id: features_threshold
  type:
  - 'null'
  - int
  doc: threshold for the number of features per sequence (percentage) [0]
  inputBinding:
    position: 1
    prefix: -m
- id: verbose_level
  type:
  - 'null'
  - int
  doc: 'verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]'
  inputBinding:
    position: 1
    prefix: -v
- id: logistic_regression_penalty
  type:
  - 'null'
  - string
  doc: penalty for the logistic regression ["l1"]
  inputBinding:
    position: 1
    prefix: -e
- id: logistic_regression_solver
  type:
  - 'null'
  - string
  doc: solver for the logistic regression ["liblinear"]
  inputBinding:
    position: 1
    prefix: -E
outputs:
- id: output_db_result
  type: File
  doc: output file name (HDF5 format)
  outputBinding:
    glob: $(inputs.output_db)
- id: save_alignment_file_result
  type:
  - 'null'
  - File
  doc: save intermediate alignment file
  outputBinding:
    glob: $(inputs.save_alignment_file)
- id: save_cross_validation_results_result
  type:
  - 'null'
  - File
  doc: save intermediate cross validation results
  outputBinding:
    glob: $(inputs.save_cross_validation_results)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/stag:0.8.3--pyhdfd78af_1
