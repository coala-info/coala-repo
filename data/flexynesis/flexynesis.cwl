cwlVersion: v1.2
class: CommandLineTool
baseCommand: flexynesis
label: flexynesis
doc: "Flexynesis model training interface\n\nTool homepage: https://github.com/BIMSBbioinfo/flexynesis"
inputs:
  - id: artifacts
    type:
      - 'null'
      - File
    doc: Path to artifacts .joblib saved during training
    inputBinding:
      position: 101
      prefix: --artifacts
  - id: config_path
    type:
      - 'null'
      - File
    doc: Optional path to an external hyperparameter configuration file in YAML 
      format.
    inputBinding:
      position: 101
      prefix: --config_path
  - id: correlation_threshold
    type:
      - 'null'
      - float
    doc: Correlation threshold to drop highly redundant features (default is 
      0.8; set to 1 for no redundancy filtering)
    inputBinding:
      position: 101
      prefix: --correlation_threshold
  - id: covariates
    type:
      - 'null'
      - string
    doc: Which variables in 'clin.csv' to be used as feature covariates, 
      comma-separated if multiple
    inputBinding:
      position: 101
      prefix: --covariates
  - id: data_path
    type:
      - 'null'
      - Directory
    doc: Path to the folder with train/test data files
    inputBinding:
      position: 101
      prefix: --data_path
  - id: data_path_test
    type:
      - 'null'
      - Directory
    doc: Folder with test-only dataset for inference
    inputBinding:
      position: 101
      prefix: --data_path_test
  - id: data_types
    type:
      - 'null'
      - string
    doc: "Which omic data matrices to work on, comma-separated: e.g. 'gex,cnv'"
    inputBinding:
      position: 101
      prefix: --data_types
  - id: device
    type:
      - 'null'
      - string
    doc: "Device type: 'auto' (automatic detection), 'cuda' (NVIDIA GPU), 'mps' (Apple
      Silicon), 'cpu'"
    inputBinding:
      position: 101
      prefix: --device
  - id: disable_marker_finding
    type:
      - 'null'
      - boolean
    doc: (Optional) If set, marker discovery after model training is disabled.
    inputBinding:
      position: 101
      prefix: --disable_marker_finding
  - id: early_stop_patience
    type:
      - 'null'
      - int
    doc: How many epochs to wait when no improvements in validation loss is 
      observed (default 10; set to -1 to disable early stopping)
    inputBinding:
      position: 101
      prefix: --early_stop_patience
  - id: evaluate_baseline_performance
    type:
      - 'null'
      - boolean
    doc: whether to run Random Forest + SVMs to see the performance of 
      off-the-shelf tools on the same dataset
    inputBinding:
      position: 101
      prefix: --evaluate_baseline_performance
  - id: feature_importance_method
    type:
      - 'null'
      - string
    doc: Choose feature importance score method
    inputBinding:
      position: 101
      prefix: --feature_importance_method
  - id: features_min
    type:
      - 'null'
      - int
    doc: Minimum number of features to retain after feature selection
    inputBinding:
      position: 101
      prefix: --features_min
  - id: features_top_percentile
    type:
      - 'null'
      - int
    doc: Top percentile features (among the features remaining after variance 
      filtering and data cleanup) to retain after feature selection
    inputBinding:
      position: 101
      prefix: --features_top_percentile
  - id: finetuning_samples
    type:
      - 'null'
      - int
    doc: Number of samples from the test dataset to use for fine-tuning the 
      model. Set to 0 to disable fine-tuning
    inputBinding:
      position: 101
      prefix: --finetuning_samples
  - id: fusion_type
    type:
      - 'null'
      - string
    doc: How to fuse the omics layers
    inputBinding:
      position: 101
      prefix: --fusion_type
  - id: gnn_conv_type
    type:
      - 'null'
      - string
    doc: If model_class is set to GNN, choose which graph convolution type to 
      use
    inputBinding:
      position: 101
      prefix: --gnn_conv_type
  - id: hpo_iter
    type:
      - 'null'
      - int
    doc: Number of iterations for hyperparameter optimisation
    inputBinding:
      position: 101
      prefix: --hpo_iter
  - id: hpo_patience
    type:
      - 'null'
      - int
    doc: How many hyperparamater optimisation iterations to wait for when no 
      improvements are observed (default is 10; set to 0 to disable early 
      stopping)
    inputBinding:
      position: 101
      prefix: --hpo_patience
  - id: input_layers
    type:
      - 'null'
      - string
    doc: If model_class is set to CrossModalPred, choose which data types to use
      as input/encoded layers. Comma- separated if multiple
    inputBinding:
      position: 101
      prefix: --input_layers
  - id: join_key
    type:
      - 'null'
      - string
    doc: Column name in 'clin.csv' (test metadata) used to join sample IDs
    inputBinding:
      position: 101
      prefix: --join_key
  - id: log_transform
    type:
      - 'null'
      - boolean
    doc: whether to apply log-transformation to input data matrices
    inputBinding:
      position: 101
      prefix: --log_transform
  - id: model_class
    type:
      - 'null'
      - string
    doc: The kind of model class to instantiate
    inputBinding:
      position: 101
      prefix: --model_class
  - id: num_workers
    type:
      - 'null'
      - int
    doc: (Optional) How many workers to use for model training (default is 0)
    inputBinding:
      position: 101
      prefix: --num_workers
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Path to the output folder to save the model outputs
    inputBinding:
      position: 101
      prefix: --outdir
  - id: output_layers
    type:
      - 'null'
      - string
    doc: If model_class is set to CrossModalPred, choose which data types to use
      as output/decoded layers. Comma- separated if multiple
    inputBinding:
      position: 101
      prefix: --output_layers
  - id: prefix
    type:
      - 'null'
      - string
    doc: Job prefix to use for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: pretrained_model
    type:
      - 'null'
      - File
    doc: Path to a saved model (.pth) to use for inference
    inputBinding:
      position: 101
      prefix: --pretrained_model
  - id: restrict_to_features
    type:
      - 'null'
      - string
    doc: Restrict the analyis to the list of features provided by the user 
      (default is None)
    inputBinding:
      position: 101
      prefix: --restrict_to_features
  - id: safetensors
    type:
      - 'null'
      - boolean
    doc: If set, the model will be saved in the SafeTensors format. Default is 
      False.
    inputBinding:
      position: 101
      prefix: --safetensors
  - id: string_node_name
    type:
      - 'null'
      - string
    doc: Type of node name.
    inputBinding:
      position: 101
      prefix: --string_node_name
  - id: string_organism
    type:
      - 'null'
      - string
    doc: STRING DB organism id.
    inputBinding:
      position: 101
      prefix: --string_organism
  - id: subsample
    type:
      - 'null'
      - int
    doc: Downsample training set to randomly drawn N samples for training. 
      Disabled when set to 0
    inputBinding:
      position: 101
      prefix: --subsample
  - id: surv_event_var
    type:
      - 'null'
      - string
    doc: Which column in 'clin.csv' to use as event/status indicator for 
      survival modeling
    inputBinding:
      position: 101
      prefix: --surv_event_var
  - id: surv_time_var
    type:
      - 'null'
      - string
    doc: Which column in 'clin.csv' to use as time/duration indicator for 
      survival modeling
    inputBinding:
      position: 101
      prefix: --surv_time_var
  - id: target_variables
    type:
      - 'null'
      - string
    doc: (Optional if survival variables are not set to None). Which variables 
      in 'clin.csv' to use for predictions, comma-separated if multiple
    inputBinding:
      position: 101
      prefix: --target_variables
  - id: threads
    type:
      - 'null'
      - int
    doc: (Optional) How many threads to use when using CPU (default is 4)
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_cv
    type:
      - 'null'
      - boolean
    doc: (Optional) If set, the a 5-fold cross-validation training will be done.
      Otherwise, a single trainig on 80 percent of the dataset is done.
    inputBinding:
      position: 101
      prefix: --use_cv
  - id: use_gpu
    type:
      - 'null'
      - boolean
    doc: '(Optional) DEPRECATED: Use --device instead. If set, attempts to use CUDA/GPU
      if available.'
    inputBinding:
      position: 101
      prefix: --use_gpu
  - id: use_loss_weighting
    type:
      - 'null'
      - boolean
    doc: whether to apply loss-balancing using uncertainty weights method
    inputBinding:
      position: 101
      prefix: --use_loss_weighting
  - id: user_graph
    type:
      - 'null'
      - File
    doc: 'Path to user-provided gene-gene interaction network file. Must have at least
      3 columns: GeneA, GeneB, Score. If provided, this will be used instead of STRING
      DB.'
    inputBinding:
      position: 101
      prefix: --user_graph
  - id: val_size
    type:
      - 'null'
      - float
    doc: 'Proportion of training data to be used as validation split (default: 0.2)'
    inputBinding:
      position: 101
      prefix: --val_size
  - id: variance_threshold
    type:
      - 'null'
      - float
    doc: Variance threshold (as percentile) to drop low variance features 
      (default is 1; set to 0 for no variance filtering)
    inputBinding:
      position: 101
      prefix: --variance_threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexynesis:1.1.7--pyhdfd78af_0
stdout: flexynesis.out
