cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dfpl
  - traingnn
label: deepfplearn_traingnn
doc: "Train new GNN models with your data (chemprop D-MPNN). Options are read from the JSON\
  \ config file; a command-line option only overrides a key that is present in that file.\n\
  \nTool homepage: https://github.com/yigbt/deepFPlearn"
inputs:
  - id: split_key_molecule
    type:
      - 'null'
      - int
    doc: --split_key_molecule option
    inputBinding:
      position: 1
      prefix: --split_key_molecule
  - id: pytorch_seed
    type:
      - 'null'
      - int
    doc: --pytorch_seed option
    inputBinding:
      position: 1
      prefix: --pytorch_seed
  - id: cache_cutoff
    type:
      - 'null'
      - float
    doc: --cache_cutoff option
    inputBinding:
      position: 1
      prefix: --cache_cutoff
  - id: save_preds
    type:
      - 'null'
      - boolean
    doc: --save_preds option (passed as True or False)
    inputBinding:
      position: 1
      prefix: --save_preds
      valueFrom: '$(self ? "True" : "False")'
  - id: cuda
    type:
      - 'null'
      - boolean
    doc: Turn on cuda
    inputBinding:
      position: 1
      prefix: --cuda
  - id: save_smiles_splits
    type:
      - 'null'
      - boolean
    doc: Save smiles for each train/val/test splits for prediction convenience later
    inputBinding:
      position: 1
      prefix: --save_smiles_splits
  - id: test
    type:
      - 'null'
      - boolean
    doc: Whether to skip training and only test the model
    inputBinding:
      position: 1
      prefix: --test
  - id: gpu
    type:
      - 'null'
      - int
    doc: Which GPU to use
    inputBinding:
      position: 1
      prefix: --gpu
  - id: save
    type:
      - 'null'
      - boolean
    doc: --save option (passed as True or False)
    inputBinding:
      position: 1
      prefix: --save
      valueFrom: '$(self ? "True" : "False")'
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Skip non-essential print statements
    inputBinding:
      position: 1
      prefix: --quiet
  - id: log_frequency
    type:
      - 'null'
      - int
    doc: The number of batches between each logging of the training loss
    inputBinding:
      position: 1
      prefix: --log_frequency
  - id: no_cuda
    type:
      - 'null'
      - boolean
    doc: Turn off cuda
    inputBinding:
      position: 1
      prefix: --no_cuda
  - id: no_cache
    type:
      - 'null'
      - boolean
    doc: Turn off caching mol2graph computation
    inputBinding:
      position: 1
      prefix: --no_cache
  - id: configFile
    type:
      - 'null'
      - File
    doc: Input JSON file that contains all information for training/predicting.
    inputBinding:
      position: 1
      prefix: --configFile
  - id: config_path
    type:
      - 'null'
      - File
    doc: Path to a .json file containing arguments. Any arguments present in the configfile
      will override arguments specified via the command line or by the defaults.
    inputBinding:
      position: 1
      prefix: --config_path
  - id: save_dir
    type:
      - 'null'
      - string
    doc: Directory where model checkpoints will be saved
    inputBinding:
      position: 1
      prefix: --save_dir
  - id: checkpoint_dir
    type:
      - 'null'
      - Directory
    doc: Directory from which to load model checkpoints(walks directory and ensembles all
      models that are found)
    inputBinding:
      position: 1
      prefix: --checkpoint_dir
  - id: checkpoint_path
    type:
      - 'null'
      - File
    doc: Path to model checkpoint (.pt file)
    inputBinding:
      position: 1
      prefix: --checkpoint_path
  - id: checkpoint_paths
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to model checkpoint (.pt file)
    inputBinding:
      position: 1
      prefix: --checkpoint_paths
  - id: separate_val_path
    type:
      - 'null'
      - File
    doc: Path to separate val set, optional
    inputBinding:
      position: 1
      prefix: --separate_val_path
  - id: separate_val_features_path
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to file with features for separate val set
    inputBinding:
      position: 1
      prefix: --separate_val_features_path
  - id: separate_test_path
    type:
      - 'null'
      - File
    doc: Path to separate test set, optional
    inputBinding:
      position: 1
      prefix: --separate_test_path
  - id: separate_test_features_path
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to file with features for separate test set
    inputBinding:
      position: 1
      prefix: --separate_test_features_path
  - id: folds_file
    type:
      - 'null'
      - File
    doc: Optional file of fold labels
    inputBinding:
      position: 1
      prefix: --folds_file
  - id: val_fold_index
    type:
      - 'null'
      - int
    doc: Which fold to use as val for cross val
    inputBinding:
      position: 1
      prefix: --val_fold_index
  - id: test_fold_index
    type:
      - 'null'
      - int
    doc: Which fold to use as test for cross val
    inputBinding:
      position: 1
      prefix: --test_fold_index
  - id: crossval_index_dir
    type:
      - 'null'
      - Directory
    doc: Directory in which to find cross validation index files
    inputBinding:
      position: 1
      prefix: --crossval_index_dir
  - id: crossval_index_file
    type:
      - 'null'
      - File
    doc: Indices of files to use as train/val/testOverrides --num_folds and --seed.
    inputBinding:
      position: 1
      prefix: --crossval_index_file
  - id: data_weights_path
    type:
      - 'null'
      - File
    doc: Path where the data weight are saved
    inputBinding:
      position: 1
      prefix: --data_weights_path
  - id: features_path
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to features to use in FNN (instead of features_generator)
    inputBinding:
      position: 1
      prefix: --features_path
  - id: separate_val_phase_features_path
    type:
      - 'null'
      - File
    doc: --separate_val_phase_features_path option
    inputBinding:
      position: 1
      prefix: --separate_val_phase_features_path
  - id: separate_test_phase_features_path
    type:
      - 'null'
      - File
    doc: --separate_test_phase_features_path option
    inputBinding:
      position: 1
      prefix: --separate_test_phase_features_path
  - id: separate_val_atom_descriptors_path
    type:
      - 'null'
      - File
    doc: --separate_val_atom_descriptors_path option
    inputBinding:
      position: 1
      prefix: --separate_val_atom_descriptors_path
  - id: separate_test_atom_descriptors_path
    type:
      - 'null'
      - File
    doc: --separate_test_atom_descriptors_path option
    inputBinding:
      position: 1
      prefix: --separate_test_atom_descriptors_path
  - id: data_path
    type:
      - 'null'
      - File
    doc: Path to data CSV file
    inputBinding:
      position: 1
      prefix: --data_path
  - id: use_compound_names
    type:
      - 'null'
      - boolean
    doc: Use when test data file contains compound names in addition to SMILES strings
    inputBinding:
      position: 1
      prefix: --use_compound_names
  - id: max_data_size
    type:
      - 'null'
      - int
    doc: Maximum number of data points to load
    inputBinding:
      position: 1
      prefix: --max_data_size
  - id: features_only
    type:
      - 'null'
      - boolean
    doc: Use only the additional features in an FFN, no graph network
    inputBinding:
      position: 1
      prefix: --features_only
  - id: dataset_type
    type:
      - 'null'
      - string
    doc: Type of dataset, e.g. classification or regression.This determines the loss function
      used during training.
    inputBinding:
      position: 1
      prefix: --dataset_type
  - id: multiclass_num_classes
    type:
      - 'null'
      - int
    doc: Number of classes when running multiclass classification
    inputBinding:
      position: 1
      prefix: --multiclass_num_classes
  - id: split_type
    type:
      - 'null'
      - string
    doc: Method of splitting the data into train/val/test
    inputBinding:
      position: 1
      prefix: --split_type
  - id: split_sizes
    type:
      - 'null'
      - type: array
        items: float
    doc: Split proportions for train/validation/test sets
    inputBinding:
      position: 1
      prefix: --split_sizes
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed to use when splitting data into train/val/test sets.When `num_folds`
      > 1, the first fold uses this seed and allsubsequent folds add 1 to the seed.
    inputBinding:
      position: 1
      prefix: --seed
  - id: smiles_columns
    type:
      - 'null'
      - string
    doc: Name of the smiles columns
    inputBinding:
      position: 1
      prefix: --smiles_columns
  - id: target_columns
    type:
      - 'null'
      - string
    doc: Name of the target columns
    inputBinding:
      position: 1
      prefix: --target_columns
  - id: ignore_columns
    type:
      - 'null'
      - string
    doc: Names of the columns to ignore
    inputBinding:
      position: 1
      prefix: --ignore_columns
  - id: num_tasks
    type:
      - 'null'
      - int
    doc: NUmber of tasks
    inputBinding:
      position: 1
      prefix: --num_tasks
  - id: no_features_scaling
    type:
      - 'null'
      - boolean
    doc: Turn off scaling of features
    inputBinding:
      position: 1
      prefix: --no_features_scaling
  - id: features_scaling
    type:
      - 'null'
      - boolean
    doc: Turn on scaling of features
    inputBinding:
      position: 1
      prefix: --features_scaling
  - id: use_input_features
    type:
      - 'null'
      - string
    doc: Turn on scaling of features
    inputBinding:
      position: 1
      prefix: --use_input_features
  - id: ensemble_size
    type:
      - 'null'
      - int
    doc: Number of models in ensemble
    inputBinding:
      position: 1
      prefix: --ensemble_size
  - id: hidden_size
    type:
      - 'null'
      - int
    doc: Dimensionality of hidden layers in MPN
    inputBinding:
      position: 1
      prefix: --hidden_size
  - id: bias
    type:
      - 'null'
      - boolean
    doc: Whether to add bias to linear layers
    inputBinding:
      position: 1
      prefix: --bias
  - id: depth
    type:
      - 'null'
      - int
    doc: Number of message passing steps
    inputBinding:
      position: 1
      prefix: --depth
  - id: dropout
    type:
      - 'null'
      - float
    doc: Dropout probability
    inputBinding:
      position: 1
      prefix: --dropout
  - id: activation
    type:
      - 'null'
      - string
    doc: Activation function
    inputBinding:
      position: 1
      prefix: --activation
  - id: undirected
    type:
      - 'null'
      - boolean
    doc: Undirected edges (always sum the two relevant bond vectors)
    inputBinding:
      position: 1
      prefix: --undirected
  - id: ffn_hidden_size
    type:
      - 'null'
      - int
    doc: Hidden dim for higher-capacity FFN (defaults to hidden_size)
    inputBinding:
      position: 1
      prefix: --ffn_hidden_size
  - id: ffn_num_layers
    type:
      - 'null'
      - int
    doc: Number of layers in FFN after MPN encoding
    inputBinding:
      position: 1
      prefix: --ffn_num_layers
  - id: atom_messages
    type:
      - 'null'
      - boolean
    doc: Use messages on atoms instead of messages on bonds
    inputBinding:
      position: 1
      prefix: --atom_messages
  - id: num_lrs
    type:
      - 'null'
      - int
    doc: Number of layers in FFN after MPN encoding
    inputBinding:
      position: 1
      prefix: --num_lrs
  - id: checkpoint_frzn
    type:
      - 'null'
      - string
    doc: --checkpoint_frzn option
    inputBinding:
      position: 1
      prefix: --checkpoint_frzn
  - id: mpn_shared
    type:
      - 'null'
      - boolean
    doc: --mpn_shared option (passed as True or False)
    inputBinding:
      position: 1
      prefix: --mpn_shared
      valueFrom: '$(self ? "True" : "False")'
  - id: show_individual_scores
    type:
      - 'null'
      - boolean
    doc: Show all scores for individual targets, not just average, at the end
    inputBinding:
      position: 1
      prefix: --show_individual_scores
  - id: aggregation
    type:
      - 'null'
      - string
    doc: --aggregation option
    inputBinding:
      position: 1
      prefix: --aggregation
  - id: aggregation_norm
    type:
      - 'null'
      - int
    doc: --aggregation_norm option
    inputBinding:
      position: 1
      prefix: --aggregation_norm
  - id: explicit_h
    type:
      - 'null'
      - boolean
    doc: --explicit_h option (passed as True or False)
    inputBinding:
      position: 1
      prefix: --explicit_h
      valueFrom: '$(self ? "True" : "False")'
  - id: adding_h
    type:
      - 'null'
      - boolean
    doc: --adding_h option (passed as True or False)
    inputBinding:
      position: 1
      prefix: --adding_h
      valueFrom: '$(self ? "True" : "False")'
  - id: class_balance
    type:
      - 'null'
      - boolean
    doc: --class_balance option (passed as True or False)
    inputBinding:
      position: 1
      prefix: --class_balance
      valueFrom: '$(self ? "True" : "False")'
  - id: evidential_regularization
    type:
      - 'null'
      - float
    doc: --evidential_regularization option
    inputBinding:
      position: 1
      prefix: --evidential_regularization
  - id: overwrite_default_atom_features
    type:
      - 'null'
      - boolean
    doc: --overwrite_default_atom_features option (passed as True or False)
    inputBinding:
      position: 1
      prefix: --overwrite_default_atom_features
      valueFrom: '$(self ? "True" : "False")'
  - id: no_atom_descriptor_scaling
    type:
      - 'null'
      - boolean
    doc: --no_atom_descriptor_scaling option (passed as True or False)
    inputBinding:
      position: 1
      prefix: --no_atom_descriptor_scaling
      valueFrom: '$(self ? "True" : "False")'
  - id: overwrite_default_bond_features
    type:
      - 'null'
      - boolean
    doc: --overwrite_default_bond_features option (passed as True or False)
    inputBinding:
      position: 1
      prefix: --overwrite_default_bond_features
      valueFrom: '$(self ? "True" : "False")'
  - id: frzn_ffn_layers
    type:
      - 'null'
      - int
    doc: --frzn_ffn_layers option
    inputBinding:
      position: 1
      prefix: --frzn_ffn_layers
  - id: freeze_first_only
    type:
      - 'null'
      - boolean
    doc: --freeze_first_only option (passed as True or False)
    inputBinding:
      position: 1
      prefix: --freeze_first_only
      valueFrom: '$(self ? "True" : "False")'
  - id: epochs
    type:
      - 'null'
      - int
    doc: Number of epochs to run
    inputBinding:
      position: 1
      prefix: --epochs
  - id: total_epochs
    type:
      - 'null'
      - int
    doc: Number of total epochs to run
    inputBinding:
      position: 1
      prefix: --total_epochs
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size
    inputBinding:
      position: 1
      prefix: --batch_size
  - id: warmup_epochs
    type:
      - 'null'
      - int
    doc: Number of epochs during which learning rate increases linearly frominit_lr to max_lr.
      Afterwards, learning rate decreases exponentiallyfrom max_lr to final_lr.
    inputBinding:
      position: 1
      prefix: --warmup_epochs
  - id: init_lr
    type:
      - 'null'
      - float
    doc: Initial learning rate
    inputBinding:
      position: 1
      prefix: --init_lr
  - id: max_lr
    type:
      - 'null'
      - float
    doc: Maximum learning rate
    inputBinding:
      position: 1
      prefix: --max_lr
  - id: final_lr
    type:
      - 'null'
      - float
    doc: Final learning rate
    inputBinding:
      position: 1
      prefix: --final_lr
  - id: extra_metrics
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra metrics to use
    inputBinding:
      position: 1
      prefix: --extra_metrics
  - id: loss_function
    type:
      - 'null'
      - string
    doc: --loss_function option
    inputBinding:
      position: 1
      prefix: --loss_function
  - id: grad_clip
    type:
      - 'null'
      - float
    doc: --grad_clip option
    inputBinding:
      position: 1
      prefix: --grad_clip
  - id: metric
    type:
      - 'null'
      - string
    doc: 'Metric to use during evaluation.Note: Does NOT affect loss function used during
      training(loss is determined by the `dataset_type` argument).Note: Defaults to "auc"
      for classification and "rmse" for regression.'
    inputBinding:
      position: 1
      prefix: --metric
  - id: num_folds
    type:
      - 'null'
      - int
    doc: Number of folds when performing cross validation
    inputBinding:
      position: 1
      prefix: --num_folds
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: save_dir_out
    type:
      - 'null'
      - Directory
    doc: Model checkpoints and scores (the save_dir key must be present in the config file)
    outputBinding:
      glob: $(inputs.save_dir)
  - id: log
    type: File
    doc: traingnn.log
    outputBinding:
      glob: traingnn.log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepfplearn:2.1--pyh42286b9_1
stdout: deepfplearn_traingnn.out
