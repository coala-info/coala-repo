cwlVersion: v1.2
class: CommandLineTool
baseCommand: demo_mochi.py
label: pymochi_demo_mochi.py
doc: "MoCHI Command Line tool.\n\nTool homepage: https://github.com/lehner-lab/MoCHI"
inputs:
  - id: batch_size
    type:
      - 'null'
      - string
    doc: "comma-separated list of minibatch sizes to consider\n                  \
      \      during grid search"
    default: 512,1024,2048
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: custom_transformations
    type:
      - 'null'
      - File
    doc: path to custom transformations file
    default: None
    inputBinding:
      position: 101
      prefix: --custom_transformations
  - id: downsample_interactions
    type:
      - 'null'
      - string
    doc: "number (if integer) or proportion (if float) or list\n                 \
      \       of integer numbers (if string) of interaction terms to\n           \
      \             retain (default: no downsampling)"
    inputBinding:
      position: 101
      prefix: --downsample_interactions
  - id: downsample_observations
    type:
      - 'null'
      - string
    doc: "number (if integer) or proportion (if float) of\n                      \
      \  observations to retain including WT (default: no\n                      \
      \  downsampling)"
    inputBinding:
      position: 101
      prefix: --downsample_observations
  - id: early_stopping
    type:
      - 'null'
      - boolean
    doc: "whether or not to stop training early if validation\n                  \
      \      loss not decreasing"
    default: true
    inputBinding:
      position: 101
      prefix: --early_stopping
  - id: ensemble
    type:
      - 'null'
      - boolean
    doc: 'use ensemble feature encoding (default: False)'
    default: false
    inputBinding:
      position: 101
      prefix: --ensemble
  - id: features
    type:
      - 'null'
      - File
    doc: path to features file
    default: None
    inputBinding:
      position: 101
      prefix: --features
  - id: fix_weights
    type:
      - 'null'
      - File
    doc: "path to file of layer names to fix weights (default:\n                 \
      \       no layers fixed)"
    inputBinding:
      position: 101
      prefix: --fix_weights
  - id: holdout_minobs
    type:
      - 'null'
      - int
    doc: "minimum number of observations of additive trait\n                     \
      \   weights to be held out"
    default: 0
    inputBinding:
      position: 101
      prefix: --holdout_minobs
  - id: holdout_orders
    type:
      - 'null'
      - string
    doc: "comma-separated list of integer mutation orders\n                      \
      \  corresponding to retained variants (default: variants\n                 \
      \       of all mutation orders can be held out)"
    inputBinding:
      position: 101
      prefix: --holdout_orders
  - id: holdout_wt
    type:
      - 'null'
      - boolean
    doc: 'WT variant can be held out (default: False)'
    default: false
    inputBinding:
      position: 101
      prefix: --holdout_WT
  - id: init_weights_directory
    type:
      - 'null'
      - Directory
    doc: "path to project directory for model weight\n                        initialization
      (default: random model weight\n                        initialization)"
    inputBinding:
      position: 101
      prefix: --init_weights_directory
  - id: init_weights_task_id
    type:
      - 'null'
      - int
    doc: task identifier to use for model weight initialization
    default: 1
    inputBinding:
      position: 101
      prefix: --init_weights_task_id
  - id: k_folds
    type:
      - 'null'
      - int
    doc: "number of cross-validation folds where test set% =\n                   \
      \     100/k_folds"
    default: 10
    inputBinding:
      position: 101
      prefix: --k_folds
  - id: l1_regularization_factor
    type:
      - 'null'
      - float
    doc: lambda factor applied to L1 norm
    default: 0
    inputBinding:
      position: 101
      prefix: --l1_regularization_factor
  - id: l2_regularization_factor
    type:
      - 'null'
      - float
    doc: lambda factor applied to L2 norm
    default: 1e-06
    inputBinding:
      position: 101
      prefix: --l2_regularization_factor
  - id: learn_rate
    type:
      - 'null'
      - string
    doc: "comma-separated list of learning rates to consider\n                   \
      \     during grid search"
    default: '0.05'
    inputBinding:
      position: 101
      prefix: --learn_rate
  - id: loss_function_name
    type:
      - 'null'
      - string
    doc: "loss function name: one of 'WeightedL1', 'GaussianNLL'"
    default: WeightedL1
    inputBinding:
      position: 101
      prefix: --loss_function_name
  - id: max_interaction_order
    type:
      - 'null'
      - int
    doc: maximum interaction order
    default: 1
    inputBinding:
      position: 101
      prefix: --max_interaction_order
  - id: min_observed
    type:
      - 'null'
      - int
    doc: "minimum number of observations required to include\n                   \
      \     interaction term"
    default: 2
    inputBinding:
      position: 101
      prefix: --min_observed
  - id: num_epochs
    type:
      - 'null'
      - int
    doc: maximum number of training epochs
    default: 1000
    inputBinding:
      position: 101
      prefix: --num_epochs
  - id: num_epochs_grid
    type:
      - 'null'
      - int
    doc: number of grid search epochs
    default: 100
    inputBinding:
      position: 101
      prefix: --num_epochs_grid
  - id: order_subset
    type:
      - 'null'
      - string
    doc: "comma-separated list of integer mutation orders to\n                   \
      \     consider (default: all variants considered)"
    inputBinding:
      position: 101
      prefix: --order_subset
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: predict
    type:
      - 'null'
      - File
    doc: path to supplementary variants file for prediction
    default: None
    inputBinding:
      position: 101
      prefix: --predict
  - id: project_name
    type:
      - 'null'
      - string
    doc: "project name (output will be saved to\n                        output_directory/project_name)"
    default: mochi_project
    inputBinding:
      position: 101
      prefix: --project_name
  - id: scheduler_gamma
    type:
      - 'null'
      - float
    doc: multiplicative factor of learning rate decay
    default: 0.98
    inputBinding:
      position: 101
      prefix: --scheduler_gamma
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed for training target data resampling
    default: 1
    inputBinding:
      position: 101
      prefix: --seed
  - id: seq_position_offset
    type:
      - 'null'
      - int
    doc: sequence position offset
    default: 0
    inputBinding:
      position: 101
      prefix: --seq_position_offset
  - id: sos_architecture
    type:
      - 'null'
      - string
    doc: "comma-separated list of integers corresponding to\n                    \
      \    number of neurons per fully-connected sumOfSigmoids\n                 \
      \       hidden layer"
    default: '20'
    inputBinding:
      position: 101
      prefix: --sos_architecture
  - id: sos_outputlinear
    type:
      - 'null'
      - boolean
    doc: "final sumOfSigmoids should be linear rather than\n                     \
      \   sigmoidal (default:False)"
    default: false
    inputBinding:
      position: 101
      prefix: --sos_outputlinear
  - id: sparse_method
    type:
      - 'null'
      - string
    doc: "sparse model inference method: one of\n                        'sig_highestorder_step'
      (default: no sparse inference)"
    inputBinding:
      position: 101
      prefix: --sparse_method
  - id: temperature
    type:
      - 'null'
      - float
    doc: temperature in degrees celsius
    default: 30.0
    inputBinding:
      position: 101
      prefix: --temperature
  - id: training_resample
    type:
      - 'null'
      - boolean
    doc: "whether or not to add random noise to training target\n                \
      \        data proportional to target error"
    default: true
    inputBinding:
      position: 101
      prefix: --training_resample
  - id: validation_factor
    type:
      - 'null'
      - int
    doc: "validation factor where validation set% =\n                        100/k_folds*validation_factor
      (default: 2 i.e. 20%)"
    default: 2
    inputBinding:
      position: 101
      prefix: --validation_factor
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymochi:1.1--pyhdfd78af_0
stdout: pymochi_demo_mochi.py.out
