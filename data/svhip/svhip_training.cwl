cwlVersion: v1.2
class: CommandLineTool
baseCommand: svhip.py
label: svhip_training
doc: "svhip.py\n\nTool homepage: https://github.com/chrisBioInf/Svhip"
inputs:
  - id: high_c
    type:
      - 'null'
      - float
    doc: 'SVM hyperparameter search: Highest value of the cost (C) parameter to optimize.
      Does nothing if no SVM classifier is used.'
    inputBinding:
      position: 101
      prefix: --high-c
  - id: high_gamma
    type:
      - 'null'
      - float
    doc: 'SVM hyperparameter search: Highest value of the gamma parameter to optimize.
      Does nothing if no SVM classifier is used.'
    inputBinding:
      position: 101
      prefix: --high-gamma
  - id: hyperparameter_steps
    type:
      - 'null'
      - int
    doc: 'Number of values to try out for EACH hyperparameter. Values will be evenly
      spaced. Default: 10'
    default: 10
    inputBinding:
      position: 101
      prefix: --hyperparameter-steps
  - id: input_file
    type: File
    doc: The input directory or file (Required).
    inputBinding:
      position: 101
      prefix: --input
  - id: logbase
    type:
      - 'null'
      - float
    doc: 'The logarithmic base if a log scale is used in hyperparameter search. Default:
      10.'
    default: 10
    inputBinding:
      position: 101
      prefix: --logbase
  - id: logscale
    type:
      - 'null'
      - boolean
    doc: Flag that decides if a logarithmic scale should be used for the 
      hyperparameter grid. If set, a log base can be set with --logbase.
    inputBinding:
      position: 101
      prefix: --logscale
  - id: low_c
    type:
      - 'null'
      - float
    doc: 'SVM hyperparameter search: Lowest value of the cost (C) parameter to optimize.
      Does nothing if no SVM classifier is used.'
    inputBinding:
      position: 101
      prefix: --low-c
  - id: low_gamma
    type:
      - 'null'
      - float
    doc: 'SVM hyperparameter search: Lowest value of the gamma parameter to optimize.
      Does nothing if no SVM classifier is used.'
    inputBinding:
      position: 101
      prefix: --low-gamma
  - id: max_samples_leaf
    type:
      - 'null'
      - int
    doc: 'Random hyperparameter search: Maximum number of samples for splitting a
      leaf node in the forest. Does nothing if no RF classifier is used.'
    inputBinding:
      position: 101
      prefix: --max-samples-leaf
  - id: max_samples_split
    type:
      - 'null'
      - int
    doc: 'Random hyperparameter search:  Maximum number of samples for splitting an
      internal node in the forest. Does nothing if no RF classifier is used.'
    inputBinding:
      position: 101
      prefix: --max-samples-split
  - id: max_trees
    type:
      - 'null'
      - int
    doc: 'Random hyperparameter search: Maximum number of trees before optimization.
      Does nothing if no RF classifier is used.'
    inputBinding:
      position: 101
      prefix: --max-trees
  - id: min_samples_leaf
    type:
      - 'null'
      - int
    doc: 'Random Forest hyperparameter search: Minimum number of samples for splitting
      a leaf node in the forest. Does nothing if no RF classifier is used.'
    inputBinding:
      position: 101
      prefix: --min-samples-leaf
  - id: min_samples_split
    type:
      - 'null'
      - int
    doc: 'Random Forest hyperparameter search: Minimum number of samples for splitting
      an internal node in the forest. Does nothing if no RF classifier is used.'
    inputBinding:
      position: 101
      prefix: --min-samples-split
  - id: min_trees
    type:
      - 'null'
      - int
    doc: 'Random Forest hyperparameter search: Minimum number of trees before optimization.
      Does nothing if no RF classifier is used.'
    inputBinding:
      position: 101
      prefix: --min-trees
  - id: model
    type:
      - 'null'
      - string
    doc: 'The model type to be trained. You can choose LR (Logistic regression), SVM
      (Support vector machine) or RF (Random Forest). (Default: SVM)'
    default: SVM
    inputBinding:
      position: 101
      prefix: --model
  - id: optimize_hyperparameters
    type:
      - 'null'
      - boolean
    doc: Select if a parameter optimization should be performed for the ML 
      model. Default is on.
    default: on
    inputBinding:
      position: 101
      prefix: --optimize-hyperparameters
  - id: optimizer
    type:
      - 'null'
      - string
    doc: Select the optimizer for hyperparameter search. Search will be 
      conducted with 5-fold crossvalidation and either of 'gridsearch' (default,
      more precise) or 'randomwalk' (faster).
    default: gridsearch
    inputBinding:
      position: 101
      prefix: --optimizer
  - id: structure
    type:
      - 'null'
      - string
    doc: 'Flag determining if only secondary structure conservation features should
      be considered. If True, protein coding features will be included (Default: False).'
    default: 'False'
    inputBinding:
      position: 101
      prefix: --structure
outputs:
  - id: outfile
    type: Directory
    doc: Name for the output directory (Required).
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
