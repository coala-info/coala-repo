# pymochi CWL Generation Report

## pymochi_run_mochi.py

### Tool Description
MoCHI Command Line tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymochi:1.1--pyhdfd78af_0
- **Homepage**: https://github.com/lehner-lab/MoCHI
- **Package**: https://anaconda.org/channels/bioconda/packages/pymochi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pymochi/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lehner-lab/MoCHI
- **Stars**: N/A
### Original Help Text
```text
usage: run_mochi.py [-h] [--model_design MODEL_DESIGN]
                    [--output_directory OUTPUT_DIRECTORY]
                    [--project_name PROJECT_NAME] [--seed SEED]
                    [--temperature TEMPERATURE]
                    [--seq_position_offset SEQ_POSITION_OFFSET]
                    [--order_subset ORDER_SUBSET]
                    [--downsample_observations DOWNSAMPLE_OBSERVATIONS]
                    [--downsample_interactions DOWNSAMPLE_INTERACTIONS]
                    [--max_interaction_order MAX_INTERACTION_ORDER]
                    [--min_observed MIN_OBSERVED] [--k_folds K_FOLDS]
                    [--validation_factor VALIDATION_FACTOR]
                    [--holdout_minobs HOLDOUT_MINOBS]
                    [--holdout_orders HOLDOUT_ORDERS] [--holdout_WT]
                    [--features FEATURES] [--ensemble]
                    [--custom_transformations CUSTOM_TRANSFORMATIONS]
                    [--batch_size BATCH_SIZE] [--learn_rate LEARN_RATE]
                    [--num_epochs NUM_EPOCHS]
                    [--num_epochs_grid NUM_EPOCHS_GRID]
                    [--l1_regularization_factor L1_REGULARIZATION_FACTOR]
                    [--l2_regularization_factor L2_REGULARIZATION_FACTOR]
                    [--training_resample TRAINING_RESAMPLE]
                    [--early_stopping EARLY_STOPPING]
                    [--scheduler_gamma SCHEDULER_GAMMA]
                    [--loss_function_name LOSS_FUNCTION_NAME]
                    [--sos_architecture SOS_ARCHITECTURE] [--sos_outputlinear]
                    [--init_weights_directory INIT_WEIGHTS_DIRECTORY]
                    [--init_weights_task_id INIT_WEIGHTS_TASK_ID]
                    [--fix_weights FIX_WEIGHTS]
                    [--sparse_method SPARSE_METHOD] [--predict PREDICT]

MoCHI Command Line tool.

optional arguments:
  -h, --help            show this help message and exit
  --model_design MODEL_DESIGN
                        path to model design file
  --output_directory OUTPUT_DIRECTORY
                        output directory
  --project_name PROJECT_NAME
                        project name (output will be saved to
                        output_directory/project_name) (default:
                        'mochi_project')
  --seed SEED           random seed for training target data resampling
                        (default: 1)
  --temperature TEMPERATURE
                        temperature in degrees celsius (default: 30.0)
  --seq_position_offset SEQ_POSITION_OFFSET
                        sequence position offset (default: 0)
  --order_subset ORDER_SUBSET
                        comma-separated list of integer mutation orders to
                        consider (default: all variants considered)
  --downsample_observations DOWNSAMPLE_OBSERVATIONS
                        number (if integer) or proportion (if float) of
                        observations to retain including WT (default: no
                        downsampling)
  --downsample_interactions DOWNSAMPLE_INTERACTIONS
                        number (if integer) or proportion (if float) or list
                        of integer numbers (if string) of interaction terms to
                        retain (default: no downsampling)
  --max_interaction_order MAX_INTERACTION_ORDER
                        maximum interaction order (default: 1)
  --min_observed MIN_OBSERVED
                        minimum number of observations required to include
                        interaction term (default:2)
  --k_folds K_FOLDS     number of cross-validation folds where test set% =
                        100/k_folds (default: 10)
  --validation_factor VALIDATION_FACTOR
                        validation factor where validation set% =
                        100/k_folds*validation_factor (default: 2 i.e. 20%)
  --holdout_minobs HOLDOUT_MINOBS
                        minimum number of observations of additive trait
                        weights to be held out (default: 0)
  --holdout_orders HOLDOUT_ORDERS
                        comma-separated list of integer mutation orders
                        corresponding to retained variants (default: variants
                        of all mutation orders can be held out)
  --holdout_WT          WT variant can be held out (default: False)
  --features FEATURES   path to features file (default: None)
  --ensemble            use ensemble feature encoding (default: False)
  --custom_transformations CUSTOM_TRANSFORMATIONS
                        path to custom transformations file (default: None)
  --batch_size BATCH_SIZE
                        comma-separated list of minibatch sizes to consider
                        during grid search (default: '512,1024,2048')
  --learn_rate LEARN_RATE
                        comma-separated list of learning rates to consider
                        during grid search (default: 0.05)
  --num_epochs NUM_EPOCHS
                        maximum number of training epochs (default: 1000)
  --num_epochs_grid NUM_EPOCHS_GRID
                        number of grid search epochs (default: 100)
  --l1_regularization_factor L1_REGULARIZATION_FACTOR
                        lambda factor applied to L1 norm (default: 0)
  --l2_regularization_factor L2_REGULARIZATION_FACTOR
                        lambda factor applied to L2 norm (default: 0.000001)
  --training_resample TRAINING_RESAMPLE
                        whether or not to add random noise to training target
                        data proportional to target error (default:True)
  --early_stopping EARLY_STOPPING
                        whether or not to stop training early if validation
                        loss not decreasing (default:True)
  --scheduler_gamma SCHEDULER_GAMMA
                        multiplicative factor of learning rate decay
                        (default:0.98)
  --loss_function_name LOSS_FUNCTION_NAME
                        loss function name: one of 'WeightedL1', 'GaussianNLL'
                        (default:'WeightedL1')
  --sos_architecture SOS_ARCHITECTURE
                        comma-separated list of integers corresponding to
                        number of neurons per fully-connected sumOfSigmoids
                        hidden layer (default: '20')
  --sos_outputlinear    final sumOfSigmoids should be linear rather than
                        sigmoidal (default:False)
  --init_weights_directory INIT_WEIGHTS_DIRECTORY
                        path to project directory for model weight
                        initialization (default: random model weight
                        initialization)
  --init_weights_task_id INIT_WEIGHTS_TASK_ID
                        task identifier to use for model weight initialization
                        (default:1)
  --fix_weights FIX_WEIGHTS
                        path to file of layer names to fix weights (default:
                        no layers fixed)
  --sparse_method SPARSE_METHOD
                        sparse model inference method: one of
                        'sig_highestorder_step' (default: no sparse inference)
  --predict PREDICT     path to supplementary variants file for prediction
                        (default: None)
```


## pymochi_demo_mochi.py

### Tool Description
MoCHI Command Line tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/pymochi:1.1--pyhdfd78af_0
- **Homepage**: https://github.com/lehner-lab/MoCHI
- **Package**: https://anaconda.org/channels/bioconda/packages/pymochi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: demo_mochi.py [-h] [--output_directory OUTPUT_DIRECTORY]
                     [--project_name PROJECT_NAME] [--seed SEED]
                     [--temperature TEMPERATURE]
                     [--seq_position_offset SEQ_POSITION_OFFSET]
                     [--order_subset ORDER_SUBSET]
                     [--downsample_observations DOWNSAMPLE_OBSERVATIONS]
                     [--downsample_interactions DOWNSAMPLE_INTERACTIONS]
                     [--max_interaction_order MAX_INTERACTION_ORDER]
                     [--min_observed MIN_OBSERVED] [--k_folds K_FOLDS]
                     [--validation_factor VALIDATION_FACTOR]
                     [--holdout_minobs HOLDOUT_MINOBS]
                     [--holdout_orders HOLDOUT_ORDERS] [--holdout_WT]
                     [--features FEATURES] [--ensemble]
                     [--custom_transformations CUSTOM_TRANSFORMATIONS]
                     [--batch_size BATCH_SIZE] [--learn_rate LEARN_RATE]
                     [--num_epochs NUM_EPOCHS]
                     [--num_epochs_grid NUM_EPOCHS_GRID]
                     [--l1_regularization_factor L1_REGULARIZATION_FACTOR]
                     [--l2_regularization_factor L2_REGULARIZATION_FACTOR]
                     [--training_resample TRAINING_RESAMPLE]
                     [--early_stopping EARLY_STOPPING]
                     [--scheduler_gamma SCHEDULER_GAMMA]
                     [--loss_function_name LOSS_FUNCTION_NAME]
                     [--sos_architecture SOS_ARCHITECTURE]
                     [--sos_outputlinear]
                     [--init_weights_directory INIT_WEIGHTS_DIRECTORY]
                     [--init_weights_task_id INIT_WEIGHTS_TASK_ID]
                     [--fix_weights FIX_WEIGHTS]
                     [--sparse_method SPARSE_METHOD] [--predict PREDICT]

MoCHI Command Line tool.

optional arguments:
  -h, --help            show this help message and exit
  --output_directory OUTPUT_DIRECTORY
                        output directory
  --project_name PROJECT_NAME
                        project name (output will be saved to
                        output_directory/project_name) (default:
                        'mochi_project')
  --seed SEED           random seed for training target data resampling
                        (default: 1)
  --temperature TEMPERATURE
                        temperature in degrees celsius (default: 30.0)
  --seq_position_offset SEQ_POSITION_OFFSET
                        sequence position offset (default: 0)
  --order_subset ORDER_SUBSET
                        comma-separated list of integer mutation orders to
                        consider (default: all variants considered)
  --downsample_observations DOWNSAMPLE_OBSERVATIONS
                        number (if integer) or proportion (if float) of
                        observations to retain including WT (default: no
                        downsampling)
  --downsample_interactions DOWNSAMPLE_INTERACTIONS
                        number (if integer) or proportion (if float) or list
                        of integer numbers (if string) of interaction terms to
                        retain (default: no downsampling)
  --max_interaction_order MAX_INTERACTION_ORDER
                        maximum interaction order (default: 1)
  --min_observed MIN_OBSERVED
                        minimum number of observations required to include
                        interaction term (default:2)
  --k_folds K_FOLDS     number of cross-validation folds where test set% =
                        100/k_folds (default: 10)
  --validation_factor VALIDATION_FACTOR
                        validation factor where validation set% =
                        100/k_folds*validation_factor (default: 2 i.e. 20%)
  --holdout_minobs HOLDOUT_MINOBS
                        minimum number of observations of additive trait
                        weights to be held out (default: 0)
  --holdout_orders HOLDOUT_ORDERS
                        comma-separated list of integer mutation orders
                        corresponding to retained variants (default: variants
                        of all mutation orders can be held out)
  --holdout_WT          WT variant can be held out (default: False)
  --features FEATURES   path to features file (default: None)
  --ensemble            use ensemble feature encoding (default: False)
  --custom_transformations CUSTOM_TRANSFORMATIONS
                        path to custom transformations file (default: None)
  --batch_size BATCH_SIZE
                        comma-separated list of minibatch sizes to consider
                        during grid search (default: '512,1024,2048')
  --learn_rate LEARN_RATE
                        comma-separated list of learning rates to consider
                        during grid search (default: 0.05)
  --num_epochs NUM_EPOCHS
                        maximum number of training epochs (default: 1000)
  --num_epochs_grid NUM_EPOCHS_GRID
                        number of grid search epochs (default: 100)
  --l1_regularization_factor L1_REGULARIZATION_FACTOR
                        lambda factor applied to L1 norm (default: 0)
  --l2_regularization_factor L2_REGULARIZATION_FACTOR
                        lambda factor applied to L2 norm (default: 0.000001)
  --training_resample TRAINING_RESAMPLE
                        whether or not to add random noise to training target
                        data proportional to target error (default:True)
  --early_stopping EARLY_STOPPING
                        whether or not to stop training early if validation
                        loss not decreasing (default:True)
  --scheduler_gamma SCHEDULER_GAMMA
                        multiplicative factor of learning rate decay
                        (default:0.98)
  --loss_function_name LOSS_FUNCTION_NAME
                        loss function name: one of 'WeightedL1', 'GaussianNLL'
                        (default:'WeightedL1')
  --sos_architecture SOS_ARCHITECTURE
                        comma-separated list of integers corresponding to
                        number of neurons per fully-connected sumOfSigmoids
                        hidden layer (default: '20')
  --sos_outputlinear    final sumOfSigmoids should be linear rather than
                        sigmoidal (default:False)
  --init_weights_directory INIT_WEIGHTS_DIRECTORY
                        path to project directory for model weight
                        initialization (default: random model weight
                        initialization)
  --init_weights_task_id INIT_WEIGHTS_TASK_ID
                        task identifier to use for model weight initialization
                        (default:1)
  --fix_weights FIX_WEIGHTS
                        path to file of layer names to fix weights (default:
                        no layers fixed)
  --sparse_method SPARSE_METHOD
                        sparse model inference method: one of
                        'sig_highestorder_step' (default: no sparse inference)
  --predict PREDICT     path to supplementary variants file for prediction
                        (default: None)
```


## Metadata
- **Skill**: generated
