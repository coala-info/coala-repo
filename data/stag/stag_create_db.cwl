cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- stag
- create_db
label: stag_create_db
doc: 'Create a STAG database from aligned sequences (1-hot encoding result of stag align).


  Tool homepage: https://github.com/zellerlab/stag'
inputs:
- id: aligned_file
  type: File
  doc: file with 1-hot encoding MSA (result from stag align)
  inputBinding:
    position: 1
    prefix: -s
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
- id: save_cross_validation_results
  type:
  - 'null'
  - string
  doc: save intermediate cross validation results
  inputBinding:
    position: 1
    prefix: -C
- id: protein_seqs
  type:
  - 'null'
  - File
  doc: protein sequences, if they were used for the alignment
  inputBinding:
    position: 1
    prefix: -p
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
- id: threads
  type:
  - 'null'
  - int
  doc: number of threads [1]
  inputBinding:
    position: 1
    prefix: -t
- id: verbose_level
  type:
  - 'null'
  - int
  doc: 'verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]'
  inputBinding:
    position: 1
    prefix: -v
outputs:
- id: output_db_result
  type: File
  doc: output file name (HDF5 format)
  outputBinding:
    glob: $(inputs.output_db)
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
