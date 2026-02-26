# sc-musketeers CWL Generation Report

## sc-musketeers

### Tool Description
Single-cell gene expression atlases are now central in biology. Their integration and annotation currently face two challenges : unbalanced proportions of cell types and large batch effects. scMusketeers, a deep learning model, optimizes the latent data representation and solves all at once these challenges. scMusketeers features three neural modules: (1) an autoencoder for noise and dimensionality reductions;(2) a focal loss classifier to enhance rare cell type predictions; and (3) an adversarial domain adaptation (DANN) module for batch effect correc- tion. Benchmarking against state-of-the-art tools, including the UCE foundation model, showed that scMusketeers performs on par or better, particularly in iden- tifying rare cell types. It also allows to transfer cell labels from single-cell RNA sequencing to spatial transcriptomics. With its modular and adaptable design, scMusketeers offers a versatile framework that can be generalized to other large- scale biological projects requiring deep learning approaches, establishing itself as a valuable tool for single-cell data integration and analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/sc-musketeers:0.4.2--pyhdfd78af_0
- **Homepage**: https://sc-musketeers.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/sc-musketeers/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sc-musketeers/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin
Tried import scmusketeers.workflow but AX Platform not installed
Please consider installing AxPlatform for hyperparameters optimization
poetry install --with workflow
usage: sc-musketeers transfer ref_path [OPTIONS]

Single-cell gene expression atlases are now central in biology. Their
integration and annotation currently face two challenges : unbalanced
proportions of cell types and large batch effects. scMusketeers, a deep
learning model, optimizes the latent data representation and solves all at
once these challenges. scMusketeers features three neural modules: (1) an
autoencoder for noise and dimensionality reductions;(2) a focal loss
classifier to enhance rare cell type predictions; and (3) an adversarial
domain adaptation (DANN) module for batch effect correc- tion. Benchmarking
against state-of-the-art tools, including the UCE foundation model, showed
that scMusketeers performs on par or better, particularly in iden- tifying
rare cell types. It also allows to transfer cell labels from single-cell RNA
sequencing to spatial transcriptomics. With its modular and adaptable design,
scMusketeers offers a versatile framework that can be generalized to other
large- scale biological projects requiring deep learning approaches,
establishing itself as a valuable tool for single-cell data integration and
analysis.

positional arguments:
  process               Type of process to run : Training, Hyperparameter
                        optimization among ['transfer', 'optim']
  ref_path              Path of the referent adata file (example :
                        data/ajrccm.h5ad

options:
  -h, --help            show this help message and exit
  --class_key CLASS_KEY
                        Key of the celltype to classify
  --batch_key BATCH_KEY
                        Key of the batches

Worklow parameters:
  --query_path [QUERY_PATH]
                        Optional query dataset
  --out_dir [OUT_DIR]   The output directory
  --out_name [OUT_NAME]
                        The output naming
  --training_scheme [TRAINING_SCHEME]
  --log_neptune [LOG_NEPTUNE]
  --neptune_name [NEPTUNE_NAME]
                        Name of the neptune project : Exemple sc-permut-
                        packaging
  --hparam_path [HPARAM_PATH]
  --opt_metric [OPT_METRIC]
                        The metric top optimize in hp search as it appears in
                        neptune (split-metricname)
  --verbose VERBOSE

Dataset Parameters:
  --unlabeled_category [UNLABELED_CATEGORY]
                        Mandatory if only one dataset is passed. Tag of the
                        cells to predict.
  --filter_min_counts [FILTER_MIN_COUNTS]
                        Filters genes with <1 counts
  --normalize_size_factors [NORMALIZE_SIZE_FACTORS]
                        Weither to normalize dataset or not
  --size_factor [SIZE_FACTOR]
                        Which size factor to use. "default" computes size
                        factor on the chosen level of preprocessing. "raw"
                        uses size factor computed on raw data as
                        n_counts/median(n_counts). "constant" uses a size
                        factor of 1 for every cells
  --scale_input [SCALE_INPUT]
                        Weither to scale input the count values
  --logtrans_input [LOGTRANS_INPUT]
                        Weither to log transform count values
  --use_hvg [USE_HVG]   Number of hvg to use. If no tag, don't use hvg.

Training Parameters:
  --batch_size [BATCH_SIZE]
                        Training batch size
  --test_split_key TEST_SPLIT_KEY
                        key of obs containing the test split
  --test_obs TEST_OBS [TEST_OBS ...]
                        batches from batch_key to use as test
  --test_index_name TEST_INDEX_NAME [TEST_INDEX_NAME ...]
                        indexes to be used as test. Overwrites test_obs
  --mode MODE           Train test split mode to be used by
                        Dataset.train_split
  --pct_split [PCT_SPLIT]
  --obs_key [OBS_KEY]
  --n_keep [N_KEEP]     batches from obs_key to use as train
  --split_strategy [SPLIT_STRATEGY]
  --keep_obs KEEP_OBS [KEEP_OBS ...]
  --train_test_random_seed [TRAIN_TEST_RANDOM_SEED]
  --obs_subsample [OBS_SUBSAMPLE]
  --make_fake [MAKE_FAKE]
  --true_celltype [TRUE_CELLTYPE]
  --false_celltype [FALSE_CELLTYPE]
  --pct_false [PCT_FALSE]
  --weight_decay [WEIGHT_DECAY]
                        Weight decay applied by th optimizer
  --learning_rate [LEARNING_RATE]
                        Starting learning rate for training
  --optimizer_type [{adam,adamw,rmsprop}]
                        Name of the optimizer to use

Epoch Parameters:
  --warmup_epoch [WARMUP_EPOCH]
                        Number of epoch to warmup DANN
  --fullmodel_epoch [FULLMODEL_EPOCH]
                        Number of epoch to train full model
  --permonly_epoch [PERMONLY_EPOCH]
                        Number of epoch to train in permutation only mode
  --classifier_epoch [CLASSIFIER_EPOCH]
                        Number of epoch to train te classifier only

Loss function Parameters:
  --balance_classes [BALANCE_CLASSES]
                        Add balance to weight to the loss
  --clas_loss_name [{MSE,categorical_crossentropy,categorical_focal_crossentropy}]
                        Loss of the classification branch
  --dann_loss_name [{categorical_crossentropy}]
                        Loss of the DANN branch
  --rec_loss_name [{MSE}]
                        Reconstruction loss of the autoencoder
  --clas_w [CLAS_W]     Weight of the classification loss
  --dann_w [DANN_W]     Weight of the DANN loss
  --rec_w [REC_W]       Weight of the reconstruction loss

Model Architecture:
  --dropout [DROPOUT]   dropout applied to every layers of the model. If
                        specified, overwrites other dropout arguments
  --layer1 [LAYER1]     size of the first layer for a 2-layers model. If
                        specified, overwrites ae_hidden_size
  --layer2 [LAYER2]     size of the second layer for a 2-layers model. If
                        specified, overwrites ae_hidden_size
  --bottleneck [BOTTLENECK]
                        size of the bottleneck layer. If specified, overwrites
                        ae_hidden_size

Autoencoder Architecture:
  --ae_hidden_size AE_HIDDEN_SIZE [AE_HIDDEN_SIZE ...]
                        Hidden sizes of the successive ae layers
  --ae_hidden_dropout [AE_HIDDEN_DROPOUT]
  --ae_activation [AE_ACTIVATION]
  --ae_bottleneck_activation [AE_BOTTLENECK_ACTIVATION]
                        activation of the bottleneck layer
  --ae_output_activation [AE_OUTPUT_ACTIVATION]
  --ae_init [AE_INIT]
  --ae_batchnorm [AE_BATCHNORM]
  --ae_l1_enc_coef [AE_L1_ENC_COEF]
  --ae_l2_enc_coef [AE_L2_ENC_COEF]

Classification Architecture:
  --class_hidden_size CLASS_HIDDEN_SIZE [CLASS_HIDDEN_SIZE ...]
                        Hidden sizes of the successive classification layers
  --class_hidden_dropout [CLASS_HIDDEN_DROPOUT]
  --class_batchnorm [CLASS_BATCHNORM]
  --class_activation [CLASS_ACTIVATION]
  --class_output_activation [CLASS_OUTPUT_ACTIVATION]

DANN Architecture:
  --dann_hidden_size [DANN_HIDDEN_SIZE]
  --dann_hidden_dropout [DANN_HIDDEN_DROPOUT]
  --dann_batchnorm [DANN_BATCHNORM]
  --dann_activation [DANN_ACTIVATION]
  --dann_output_activation [DANN_OUTPUT_ACTIVATION]

Enjoy scMusketeers!
```

