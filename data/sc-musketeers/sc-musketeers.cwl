cwlVersion: v1.2
class: CommandLineTool
baseCommand: sc-musketeers
label: sc-musketeers
doc: "Single-cell gene expression atlases are now central in biology. Their integration
  and annotation currently face two challenges : unbalanced proportions of cell types
  and large batch effects. scMusketeers, a deep learning model, optimizes the latent
  data representation and solves all at once these challenges. scMusketeers features
  three neural modules: (1) an autoencoder for noise and dimensionality reductions;(2)
  a focal loss classifier to enhance rare cell type predictions; and (3) an adversarial
  domain adaptation (DANN) module for batch effect correc- tion. Benchmarking against
  state-of-the-art tools, including the UCE foundation model, showed that scMusketeers
  performs on par or better, particularly in iden- tifying rare cell types. It also
  allows to transfer cell labels from single-cell RNA sequencing to spatial transcriptomics.
  With its modular and adaptable design, scMusketeers offers a versatile framework
  that can be generalized to other large- scale biological projects requiring deep
  learning approaches, establishing itself as a valuable tool for single-cell data
  integration and analysis.\n\nTool homepage: https://sc-musketeers.readthedocs.io/"
inputs:
  - id: process
    type: string
    doc: "Type of process to run : Training, Hyperparameter optimization among ['transfer',
      'optim']"
    inputBinding:
      position: 1
  - id: ref_path
    type: File
    doc: 'Path of the referent adata file (example : data/ajrccm.h5ad'
    inputBinding:
      position: 2
  - id: ae_activation
    type:
      - 'null'
      - string
    doc: Autoencoder activation function
    inputBinding:
      position: 103
      prefix: --ae_activation
  - id: ae_batchnorm
    type:
      - 'null'
      - boolean
    doc: Whether to use batch normalization in the autoencoder
    inputBinding:
      position: 103
      prefix: --ae_batchnorm
  - id: ae_bottleneck_activation
    type:
      - 'null'
      - string
    doc: activation of the bottleneck layer
    inputBinding:
      position: 103
      prefix: --ae_bottleneck_activation
  - id: ae_hidden_dropout
    type:
      - 'null'
      - float
    doc: Autoencoder hidden layer dropout
    inputBinding:
      position: 103
      prefix: --ae_hidden_dropout
  - id: ae_hidden_size
    type:
      - 'null'
      - type: array
        items: int
    doc: Hidden sizes of the successive ae layers
    inputBinding:
      position: 103
      prefix: --ae_hidden_size
  - id: ae_init
    type:
      - 'null'
      - string
    doc: Autoencoder initialization
    inputBinding:
      position: 103
      prefix: --ae_init
  - id: ae_l1_enc_coef
    type:
      - 'null'
      - float
    doc: L1 regularization coefficient for the encoder
    inputBinding:
      position: 103
      prefix: --ae_l1_enc_coef
  - id: ae_l2_enc_coef
    type:
      - 'null'
      - float
    doc: L2 regularization coefficient for the encoder
    inputBinding:
      position: 103
      prefix: --ae_l2_enc_coef
  - id: ae_output_activation
    type:
      - 'null'
      - string
    doc: Autoencoder output activation function
    inputBinding:
      position: 103
      prefix: --ae_output_activation
  - id: balance_classes
    type:
      - 'null'
      - boolean
    doc: Add balance to weight to the loss
    inputBinding:
      position: 103
      prefix: --balance_classes
  - id: batch_key
    type:
      - 'null'
      - string
    doc: Key of the batches
    inputBinding:
      position: 103
      prefix: --batch_key
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Training batch size
    inputBinding:
      position: 103
      prefix: --batch_size
  - id: bottleneck
    type:
      - 'null'
      - int
    doc: size of the bottleneck layer. If specified, overwrites ae_hidden_size
    inputBinding:
      position: 103
      prefix: --bottleneck
  - id: clas_loss_name
    type:
      - 'null'
      - string
    doc: Loss of the classification branch
    inputBinding:
      position: 103
      prefix: --clas_loss_name
  - id: clas_w
    type:
      - 'null'
      - float
    doc: Weight of the classification loss
    inputBinding:
      position: 103
      prefix: --clas_w
  - id: class_activation
    type:
      - 'null'
      - string
    doc: Classification activation function
    inputBinding:
      position: 103
      prefix: --class_activation
  - id: class_batchnorm
    type:
      - 'null'
      - boolean
    doc: Whether to use batch normalization in the classifier
    inputBinding:
      position: 103
      prefix: --class_batchnorm
  - id: class_hidden_dropout
    type:
      - 'null'
      - float
    doc: Classification hidden layer dropout
    inputBinding:
      position: 103
      prefix: --class_hidden_dropout
  - id: class_hidden_size
    type:
      - 'null'
      - type: array
        items: int
    doc: Hidden sizes of the successive classification layers
    inputBinding:
      position: 103
      prefix: --class_hidden_size
  - id: class_key
    type:
      - 'null'
      - string
    doc: Key of the celltype to classify
    inputBinding:
      position: 103
      prefix: --class_key
  - id: class_output_activation
    type:
      - 'null'
      - string
    doc: Classification output activation function
    inputBinding:
      position: 103
      prefix: --class_output_activation
  - id: classifier_epoch
    type:
      - 'null'
      - int
    doc: Number of epoch to train te classifier only
    inputBinding:
      position: 103
      prefix: --classifier_epoch
  - id: dann_activation
    type:
      - 'null'
      - string
    doc: DANN activation function
    inputBinding:
      position: 103
      prefix: --dann_activation
  - id: dann_batchnorm
    type:
      - 'null'
      - boolean
    doc: Whether to use batch normalization in DANN
    inputBinding:
      position: 103
      prefix: --dann_batchnorm
  - id: dann_hidden_dropout
    type:
      - 'null'
      - float
    doc: DANN hidden layer dropout
    inputBinding:
      position: 103
      prefix: --dann_hidden_dropout
  - id: dann_hidden_size
    type:
      - 'null'
      - int
    doc: DANN hidden layer size
    inputBinding:
      position: 103
      prefix: --dann_hidden_size
  - id: dann_loss_name
    type:
      - 'null'
      - string
    doc: Loss of the DANN branch
    inputBinding:
      position: 103
      prefix: --dann_loss_name
  - id: dann_output_activation
    type:
      - 'null'
      - string
    doc: DANN output activation function
    inputBinding:
      position: 103
      prefix: --dann_output_activation
  - id: dann_w
    type:
      - 'null'
      - float
    doc: Weight of the DANN loss
    inputBinding:
      position: 103
      prefix: --dann_w
  - id: dropout
    type:
      - 'null'
      - float
    doc: dropout applied to every layers of the model. If specified, overwrites 
      other dropout arguments
    inputBinding:
      position: 103
      prefix: --dropout
  - id: false_celltype
    type:
      - 'null'
      - string
    doc: False cell type
    inputBinding:
      position: 103
      prefix: --false_celltype
  - id: filter_min_counts
    type:
      - 'null'
      - int
    doc: Filters genes with <1 counts
    inputBinding:
      position: 103
      prefix: --filter_min_counts
  - id: fullmodel_epoch
    type:
      - 'null'
      - int
    doc: Number of epoch to train full model
    inputBinding:
      position: 103
      prefix: --fullmodel_epoch
  - id: hparam_path
    type:
      - 'null'
      - File
    doc: Hyperparameter path
    inputBinding:
      position: 103
      prefix: --hparam_path
  - id: keep_obs
    type:
      - 'null'
      - type: array
        items: string
    doc: Observations to keep
    inputBinding:
      position: 103
      prefix: --keep_obs
  - id: layer1
    type:
      - 'null'
      - int
    doc: size of the first layer for a 2-layers model. If specified, overwrites 
      ae_hidden_size
    inputBinding:
      position: 103
      prefix: --layer1
  - id: layer2
    type:
      - 'null'
      - int
    doc: size of the second layer for a 2-layers model. If specified, overwrites
      ae_hidden_size
    inputBinding:
      position: 103
      prefix: --layer2
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: Starting learning rate for training
    inputBinding:
      position: 103
      prefix: --learning_rate
  - id: log_neptune
    type:
      - 'null'
      - boolean
    doc: Log to Neptune
    inputBinding:
      position: 103
      prefix: --log_neptune
  - id: logtrans_input
    type:
      - 'null'
      - boolean
    doc: Weither to log transform count values
    inputBinding:
      position: 103
      prefix: --logtrans_input
  - id: make_fake
    type:
      - 'null'
      - boolean
    doc: Make fake data
    inputBinding:
      position: 103
      prefix: --make_fake
  - id: mode
    type:
      - 'null'
      - string
    doc: Train test split mode to be used by Dataset.train_split
    inputBinding:
      position: 103
      prefix: --mode
  - id: n_keep
    type:
      - 'null'
      - type: array
        items: int
    doc: batches from obs_key to use as train
    inputBinding:
      position: 103
      prefix: --n_keep
  - id: neptune_name
    type:
      - 'null'
      - string
    doc: 'Name of the neptune project : Exemple sc-permut- packaging'
    inputBinding:
      position: 103
      prefix: --neptune_name
  - id: normalize_size_factors
    type:
      - 'null'
      - boolean
    doc: Weither to normalize dataset or not
    inputBinding:
      position: 103
      prefix: --normalize_size_factors
  - id: obs_key
    type:
      - 'null'
      - string
    doc: Observation key
    inputBinding:
      position: 103
      prefix: --obs_key
  - id: obs_subsample
    type:
      - 'null'
      - int
    doc: Subsample observations
    inputBinding:
      position: 103
      prefix: --obs_subsample
  - id: opt_metric
    type:
      - 'null'
      - string
    doc: The metric top optimize in hp search as it appears in neptune 
      (split-metricname)
    inputBinding:
      position: 103
      prefix: --opt_metric
  - id: optimizer_type
    type:
      - 'null'
      - string
    doc: Name of the optimizer to use
    inputBinding:
      position: 103
      prefix: --optimizer_type
  - id: out_name
    type:
      - 'null'
      - string
    doc: The output naming
    inputBinding:
      position: 103
      prefix: --out_name
  - id: pct_false
    type:
      - 'null'
      - float
    doc: Percentage of false cell types
    inputBinding:
      position: 103
      prefix: --pct_false
  - id: pct_split
    type:
      - 'null'
      - float
    doc: Percentage of data to split
    inputBinding:
      position: 103
      prefix: --pct_split
  - id: permonly_epoch
    type:
      - 'null'
      - int
    doc: Number of epoch to train in permutation only mode
    inputBinding:
      position: 103
      prefix: --permonly_epoch
  - id: query_path
    type:
      - 'null'
      - File
    doc: Optional query dataset
    inputBinding:
      position: 103
      prefix: --query_path
  - id: rec_loss_name
    type:
      - 'null'
      - string
    doc: Reconstruction loss of the autoencoder
    inputBinding:
      position: 103
      prefix: --rec_loss_name
  - id: rec_w
    type:
      - 'null'
      - float
    doc: Weight of the reconstruction loss
    inputBinding:
      position: 103
      prefix: --rec_w
  - id: scale_input
    type:
      - 'null'
      - boolean
    doc: Weither to scale input the count values
    inputBinding:
      position: 103
      prefix: --scale_input
  - id: size_factor
    type:
      - 'null'
      - string
    doc: '"default" computes size factor on the chosen level of preprocessing. "raw"
      uses size factor computed on raw data as n_counts/median(n_counts). "constant"
      uses a size factor of 1 for every cells'
    inputBinding:
      position: 103
      prefix: --size_factor
  - id: split_strategy
    type:
      - 'null'
      - string
    doc: Split strategy
    inputBinding:
      position: 103
      prefix: --split_strategy
  - id: test_index_name
    type:
      - 'null'
      - type: array
        items: string
    doc: indexes to be used as test. Overwrites test_obs
    inputBinding:
      position: 103
      prefix: --test_index_name
  - id: test_obs
    type:
      - 'null'
      - type: array
        items: string
    doc: batches from batch_key to use as test
    inputBinding:
      position: 103
      prefix: --test_obs
  - id: test_split_key
    type:
      - 'null'
      - string
    doc: key of obs containing the test split
    inputBinding:
      position: 103
      prefix: --test_split_key
  - id: train_test_random_seed
    type:
      - 'null'
      - int
    doc: Random seed for train/test split
    inputBinding:
      position: 103
      prefix: --train_test_random_seed
  - id: training_scheme
    type:
      - 'null'
      - string
    doc: Training scheme
    inputBinding:
      position: 103
      prefix: --training_scheme
  - id: true_celltype
    type:
      - 'null'
      - string
    doc: True cell type
    inputBinding:
      position: 103
      prefix: --true_celltype
  - id: unlabeled_category
    type:
      - 'null'
      - string
    doc: Mandatory if only one dataset is passed. Tag of the cells to predict.
    inputBinding:
      position: 103
      prefix: --unlabeled_category
  - id: use_hvg
    type:
      - 'null'
      - int
    doc: Number of hvg to use. If no tag, don't use hvg.
    inputBinding:
      position: 103
      prefix: --use_hvg
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 103
      prefix: --verbose
  - id: warmup_epoch
    type:
      - 'null'
      - int
    doc: Number of epoch to warmup DANN
    inputBinding:
      position: 103
      prefix: --warmup_epoch
  - id: weight_decay
    type:
      - 'null'
      - float
    doc: Weight decay applied by th optimizer
    inputBinding:
      position: 103
      prefix: --weight_decay
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: The output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc-musketeers:0.4.2--pyhdfd78af_0
