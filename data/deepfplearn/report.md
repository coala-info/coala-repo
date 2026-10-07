# deepfplearn CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| deepfplearn_convert | PASS |  |
| deepfplearn_predict | PASS |  |
| deepfplearn_predictgnn | PASS |  |
| deepfplearn_train | PASS |  |
| deepfplearn_traingnn | PASS |  |

## deepfplearn_train

### Tool Description
Train new models with your data.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepfplearn:2.1--pyh42286b9_1
- **Homepage**: https://github.com/yigbt/deepFPlearn
- **Package**: https://anaconda.org/channels/bioconda/packages/deepfplearn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepfplearn/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yigbt/deepFPlearn
- **Stars**: N/A
### Original Help Text
```text
usage: deepFPlearn train [-h] [-f FILE] [-i FILE] [-o DIR] [-t STRING]
                         [-thr FLOAT] [-gpu INT] [-k STR] [-s FPSIZE]
                         [-c BOOL] [--visualizeLatent BOOL] [-m BOOL]
                         [-a FILE] [--ecModelDir DIR] [--aeType STRING]
                         [--aeEpochs INT] [--aeBatchSize INT]
                         [--aeActivationFunction STRING]
                         [--aeLearningRate FLOAT]
                         [--aeLearningRateDecay FLOAT] [--aeSplitType STRING]
                         [-d INT] [--split_type STRING] [-l FLOAT] [-K INT]
                         [-v INT] [--trainAC BOOL] [--trainFNN BOOL]
                         [--sampleFractionOnes FLOAT] [--sampleDown BOOL]
                         [-e INT] [--lossFunction STRING] [--optimizer STRING]
                         [--batchSize INT] [--l2reg FLOAT] [--dropout FLOAT]
                         [--learningRate FLOAT] [--learningRateDecay FLOAT]
                         [--activationFunction STRING] [--aeWabTracking BOOL]
                         [--wabTracking BOOL] [--wabTarget STRING]

optional arguments:
  -h, --help            show this help message and exit

Model Configuration:
  -f FILE, --configFile FILE
                        Input JSON file that contains all information for
                        training/predicting.
  -i FILE, --inputFile FILE
                        The file containing the data for training in comma
                        separated CSV format.The first column should be
                        smiles.
  -o DIR, --outputDir DIR
                        Prefix of output file name. Trained model and
                        respective stats will be returned in this directory.
  -t STRING, --type STRING
                        Type of the chemical representation. Choices: 'fp',
                        'smiles'.
  -thr FLOAT, --threshold FLOAT
                        Threshold for binary classification.
  -gpu INT, --gpu INT   Select which gpu to use. If not available, leave
                        empty.
  -k STR, --fpType STR  The type of fingerprint to be generated/used in input
                        file.
  -s FPSIZE, --fpSize FPSIZE
                        Size of fingerprint that should be generated.
  -c BOOL, --compressFeatures BOOL
                        Should the fingerprints be compressed or not.
                        Activates the autoencoder.
  --visualizeLatent BOOL
                        Visualize the latent space of the autoencoder.
  -m BOOL, --enableMultiLabel BOOL
                        Train multi-label classification model in addition to
                        the individual models.

Autoencoder Configuration:
  -a FILE, --ecWeightsFile FILE
                        The .hdf5 file of a trained encoder
  --ecModelDir DIR      The directory where the full model of the encoder will
                        be saved
  --aeType STRING       Autoencoder type, variational or deterministic.
  --aeEpochs INT        Number of epochs for autoencoder training.
  --aeBatchSize INT     Batch size in autoencoder training.
  --aeActivationFunction STRING
                        The activation function for the hidden layers in the
                        autoencoder.
  --aeLearningRate FLOAT
                        Learning rate for autoencoder training.
  --aeLearningRateDecay FLOAT
                        Learning rate decay for autoencoder training.
  --aeSplitType STRING  Set how the data is going to be split for the
                        autoencoder
  -d INT, --encFPSize INT
                        Size of encoded fingerprint (z-layer of autoencoder).

Training Configuration:
  --split_type STRING   Set how the data is going to be split for the
                        feedforward neural network
  -l FLOAT, --testSize FLOAT
                        Fraction of the dataset that should be used for
                        testing. Value in [0,1].
  -K INT, --kFolds INT  K that is used for K-fold cross-validation in the
                        training procedure.
  -v INT, --verbose INT
                        Verbosity level. O: No additional output, 1: Some
                        additional output, 2: full additional output
  --trainAC BOOL        Choose to train or not, the autoencoder based on the
                        input file
  --trainFNN BOOL       Train the feedforward network either with provided
                        weights.
  --sampleFractionOnes FLOAT
                        This is the fraction of positive target associations
                        (1s) in comparison to the majority class(0s).only
                        works if --sampleDown is enabled
  --sampleDown BOOL     Enable automatic down sampling of the 0 valued
                        samples.
  -e INT, --epochs INT  Number of epochs that should be used for the FNN
                        training
  --lossFunction STRING
                        Loss function to use during training. mse - mean
                        squared error, bce - binary cross entropy.
  --optimizer STRING    Optimizer to use for backpropagation in the FNN.
                        Possible values: "Adam", "SGD"
  --batchSize INT       Batch size in FNN training.
  --l2reg FLOAT         Value for l2 kernel regularizer.
  --dropout FLOAT       The fraction of data that is dropped out in each
                        dropout layer.
  --learningRate FLOAT  Learning rate size in FNN training.
  --learningRateDecay FLOAT
                        Learning rate decay in FNN training.
  --activationFunction STRING
                        The activation function for hidden layers in the FNN.

Tracking Configuration:
  --aeWabTracking BOOL  Track autoencoder performance via Weights & Biases,
                        see https://wandb.ai.
  --wabTracking BOOL    Track FNN performance via Weights & Biases, see
                        https://wandb.ai.
  --wabTarget STRING    Which target to use for tracking performance via
                        Weights & Biases, see https://wandb.ai.
```

## deepfplearn_predict

### Tool Description
Predict your data with existing models.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepfplearn:2.1--pyh42286b9_1
- **Homepage**: https://github.com/yigbt/deepFPlearn
- **Package**: https://anaconda.org/channels/bioconda/packages/deepfplearn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepfplearn/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yigbt/deepFPlearn
- **Stars**: N/A
### Original Help Text
```text
usage: deepFPlearn predict [-h] [-f FILE] [-i FILE] [-o DIR]
                           [--outputFile FILE] [-t STR] [-k STR]
                           [--ecModelDir DIR] [--fnnModelDir DIR]
                           [--compressFeatures BOOL] [--aeType STRING]

optional arguments:
  -h, --help            show this help message and exit

General Configuration:
  -t STR, --type STR    Type of the chemical representation. Choices: 'fp',
                        'smiles'.
  -k STR, --fpType STR  The type of fingerprint to be generated/used in input
                        file.
  --compressFeatures BOOL
  --aeType STRING

Files:
  -f FILE, --configFile FILE
                        Input JSON file that contains all information for
                        training/predicting.
  -i FILE, --inputFile FILE
                        The file containing the data for the prediction in
                        (unquoted) comma separated CSV format. The column
                        named 'smiles' or 'fp'contains the field to be
                        predicted. Please adjust the type that should be
                        predicted (fp or smile) with -t option
                        appropriately.An optional column 'id' is used to
                        assign the outcomes to theoriginal identifiers. If
                        this column is missing, the results arenumbered in the
                        order of their appearance in the input file.A header
                        is expected and respective column names are used.
  -o DIR, --outputDir DIR
                        Prefix of output directory. It will contain a log file
                        and the file specifiedwith --outputFile.
  --outputFile FILE     Output .CSV file name which will contain one
                        prediction per input line. Default: prefix of input
                        file name.
  --ecModelDir DIR      The directory where the full model of the encoder will
                        be saved (if trainAE=True) or loaded from (if
                        trainAE=False). Provide a full path here.
  --fnnModelDir DIR     The directory where the full model of the fnn is
                        loaded from. Provide a full path here.
```

## deepfplearn_convert

### Tool Description
Convert known data files to pickle serialization files.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepfplearn:2.1--pyh42286b9_1
- **Homepage**: https://github.com/yigbt/deepFPlearn
- **Package**: https://anaconda.org/channels/bioconda/packages/deepfplearn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepfplearn/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yigbt/deepFPlearn
- **Stars**: N/A
### Original Help Text
```text
usage: deepFPlearn convert [-h] -f FILE

optional arguments:
  -h, --help  show this help message and exit
  -f FILE     Input directory where your CSV/TSV files are stored.
```

## deepfplearn_traingnn

### Tool Description
Train new GNN models with your data.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepfplearn:2.1--pyh42286b9_1
- **Homepage**: https://github.com/yigbt/deepFPlearn
- **Package**: https://anaconda.org/channels/bioconda/packages/deepfplearn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepfplearn/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yigbt/deepFPlearn
- **Stars**: N/A
### Original Help Text
```text
usage: deepFPlearn traingnn [-h] [--split_key_molecule SPLIT_KEY_MOLECULE]
                            [--pytorch_seed PYTORCH_SEED]
                            [--cache_cutoff CACHE_CUTOFF]
                            [--save_preds SAVE_PREDS] [--cuda]
                            [--save_smiles_splits] [--test] [--gpu {}]
                            [--save SAVE] [--quiet] [--log_frequency INT]
                            [--no_cuda] [--no_cache] [-f FILE]
                            [--config_path FILE] [--save_dir DIR]
                            [--checkpoint_dir DIR] [--checkpoint_path FILE]
                            [--checkpoint_paths [FILE [FILE ...]]]
                            [--separate_val_path FILE]
                            [--separate_val_features_path [FILE [FILE ...]]]
                            [--separate_test_path FILE]
                            [--separate_test_features_path [FILE [FILE ...]]]
                            [--folds_file FILE] [--val_fold_index INT]
                            [--test_fold_index INT] [--crossval_index_dir DIR]
                            [--crossval_index_file FILE]
                            [--data_weights_path FILE]
                            [--features_path [FILE [FILE ...]]]
                            [--separate_val_phase_features_path FILE]
                            [--separate_test_phase_features_path FILE]
                            [--separate_val_atom_descriptors_path FILE]
                            [--separate_test_atom_descriptors_path FILE]
                            [--data_path FILE] [--use_compound_names]
                            [--max_data_size INT] [--features_only]
                            [--dataset_type STRING]
                            [--multiclass_num_classes INT]
                            [--split_type STRING]
                            [--split_sizes FLOAT FLOAT FLOAT] [--seed SEED]
                            [--smiles_columns STRING]
                            [--target_columns STRING]
                            [--ignore_columns STRING] [--num_tasks INT]
                            [--no_features_scaling] [--features_scaling]
                            [--use_input_features STRING]
                            [--ensemble_size INT] [--hidden_size INT] [--bias]
                            [--depth INT] [--dropout FLOAT]
                            [--activation STRING] [--undirected]
                            [--ffn_hidden_size INT] [--ffn_num_layers INT]
                            [--atom_messages] [--num_lrs INT]
                            [--checkpoint_frzn STRING] [--mpn_shared BOOL]
                            [--show_individual_scores]
                            [--aggregation {mean,sum,norm}]
                            [--aggregation_norm AGGREGATION_NORM]
                            [--explicit_h BOOL] [--adding_h BOOL]
                            [--class_balance BOOL]
                            [--evidential_regularization FLOAT]
                            [--overwrite_default_atom_features BOOL]
                            [--no_atom_descriptor_scaling BOOL]
                            [--overwrite_default_bond_features BOOL]
                            [--frzn_ffn_layers INT] [--freeze_first_only BOOL]
                            [--epochs INT] [--total_epochs INT]
                            [--batch_size INT] [--warmup_epochs INT]
                            [--init_lr FLOAT] [--max_lr FLOAT]
                            [--final_lr FLOAT]
                            [--extra_metrics [STRING [STRING ...]]]
                            [--loss_function STRING] [--grad_clip GRAD_CLIP]
                            [--metric STRING] [--num_folds INT]

optional arguments:
  -h, --help            show this help message and exit

General Configuration:
  --split_key_molecule SPLIT_KEY_MOLECULE
  --pytorch_seed PYTORCH_SEED
  --cache_cutoff CACHE_CUTOFF
  --save_preds SAVE_PREDS
  --cuda                Turn on cuda
  --save_smiles_splits  Save smiles for each train/val/test splits for
                        prediction convenience later
  --test                Whether to skip training and only test the model
  --gpu {}              Which GPU to use
  --save SAVE
  --quiet               Skip non-essential print statements
  --log_frequency INT   The number of batches between each logging of the
                        training loss
  --no_cuda             Turn off cuda
  --no_cache            Turn off caching mol2graph computation

Data Configuration:
  --data_path FILE      Path to data CSV file
  --use_compound_names  Use when test data file contains compound names in
                        addition to SMILES strings
  --max_data_size INT   Maximum number of data points to load
  --features_only       Use only the additional features in an FFN, no graph
                        network
  --dataset_type STRING
                        Type of dataset, e.g. classification or
                        regression.This determines the loss function used
                        during training.
  --multiclass_num_classes INT
                        Number of classes when running multiclass
                        classification
  --split_type STRING   Method of splitting the data into train/val/test
  --split_sizes FLOAT FLOAT FLOAT
                        Split proportions for train/validation/test sets
  --seed SEED           Random seed to use when splitting data into
                        train/val/test sets.When `num_folds` > 1, the first
                        fold uses this seed and allsubsequent folds add 1 to
                        the seed.
  --smiles_columns STRING
                        Name of the smiles columns
  --target_columns STRING
                        Name of the target columns
  --ignore_columns STRING
                        Names of the columns to ignore
  --num_tasks INT       NUmber of tasks
  --no_features_scaling
                        Turn off scaling of features
  --features_scaling    Turn on scaling of features
  --use_input_features STRING
                        Turn on scaling of features

Files:
  -f FILE, --configFile FILE
                        Input JSON file that contains all information for
                        training/predicting.
  --config_path FILE    Path to a .json file containing arguments. Any
                        arguments present in the configfile will override
                        arguments specified via the command line or by the
                        defaults.
  --save_dir DIR        Directory where model checkpoints will be saved
  --checkpoint_dir DIR  Directory from which to load model checkpoints(walks
                        directory and ensembles all models that are found)
  --checkpoint_path FILE
                        Path to model checkpoint (.pt file)
  --checkpoint_paths [FILE [FILE ...]]
                        Path to model checkpoint (.pt file)
  --separate_val_path FILE
                        Path to separate val set, optional
  --separate_val_features_path [FILE [FILE ...]]
                        Path to file with features for separate val set
  --separate_test_path FILE
                        Path to separate test set, optional
  --separate_test_features_path [FILE [FILE ...]]
                        Path to file with features for separate test set
  --folds_file FILE     Optional file of fold labels
  --val_fold_index INT  Which fold to use as val for cross val
  --test_fold_index INT
                        Which fold to use as test for cross val
  --crossval_index_dir DIR
                        Directory in which to find cross validation index
                        files
  --crossval_index_file FILE
                        Indices of files to use as train/val/testOverrides
                        --num_folds and --seed.
  --data_weights_path FILE
                        Path where the data weight are saved
  --features_path [FILE [FILE ...]]
                        Path to features to use in FNN (instead of
                        features_generator)
  --separate_val_phase_features_path FILE
  --separate_test_phase_features_path FILE
  --separate_val_atom_descriptors_path FILE
  --separate_test_atom_descriptors_path FILE

Model arguments:
  --ensemble_size INT   Number of models in ensemble
  --hidden_size INT     Dimensionality of hidden layers in MPN
  --bias                Whether to add bias to linear layers
  --depth INT           Number of message passing steps
  --dropout FLOAT       Dropout probability
  --activation STRING   Activation function
  --undirected          Undirected edges (always sum the two relevant bond
                        vectors)
  --ffn_hidden_size INT
                        Hidden dim for higher-capacity FFN (defaults to
                        hidden_size)
  --ffn_num_layers INT  Number of layers in FFN after MPN encoding
  --atom_messages       Use messages on atoms instead of messages on bonds
  --num_lrs INT         Number of layers in FFN after MPN encoding
  --checkpoint_frzn STRING
  --mpn_shared BOOL
  --show_individual_scores
                        Show all scores for individual targets, not just
                        average, at the end
  --aggregation {mean,sum,norm}
  --aggregation_norm AGGREGATION_NORM
  --explicit_h BOOL
  --adding_h BOOL
  --class_balance BOOL
  --evidential_regularization FLOAT
  --overwrite_default_atom_features BOOL
  --no_atom_descriptor_scaling BOOL
  --overwrite_default_bond_features BOOL
  --frzn_ffn_layers INT
  --freeze_first_only BOOL

Training Configuration:
  --epochs INT          Number of epochs to run
  --total_epochs INT    Number of total epochs to run
  --batch_size INT      Batch size
  --warmup_epochs INT   Number of epochs during which learning rate increases
                        linearly frominit_lr to max_lr. Afterwards, learning
                        rate decreases exponentiallyfrom max_lr to final_lr.
  --init_lr FLOAT       Initial learning rate
  --max_lr FLOAT        Maximum learning rate
  --final_lr FLOAT      Final learning rate
  --extra_metrics [STRING [STRING ...]]
                        Extra metrics to use
  --loss_function STRING
  --grad_clip GRAD_CLIP
  --metric STRING       Metric to use during evaluation.Note: Does NOT affect
                        loss function used during training(loss is determined
                        by the `dataset_type` argument).Note: Defaults to
                        "auc" for classification and "rmse" for regression.
  --num_folds INT       Number of folds when performing cross validation
```

## deepfplearn_predictgnn

### Tool Description
Predict with your GNN models.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepfplearn:2.1--pyh42286b9_1
- **Homepage**: https://github.com/yigbt/deepFPlearn
- **Package**: https://anaconda.org/channels/bioconda/packages/deepfplearn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepfplearn/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yigbt/deepFPlearn
- **Stars**: N/A
### Original Help Text
```text
usage: deepFPlearn predictgnn [-h] [-f FILE] [--gpu INT] [--no_cuda]
                              [--num_workers INT] [--no_cache BOOL]
                              [--no_cache_mol BOOL] [--empty_cache BOOL]
                              [--preds_path FILE] [--checkpoint_dir DIR]
                              [--checkpoint_path DIR]
                              [--checkpoint_paths [FILE [FILE ...]]]
                              [--data_path FILE] [--test_path FILE]
                              [--features_path [FILE [FILE ...]]]
                              [--atom_descriptors_path FILE]
                              [--use_compound_names] [--no_features_scaling]
                              [--max_data_size INT] [--smiles_columns STRING]
                              [--number_of_molecules INT]
                              [--atom_descriptors Bool]
                              [--bond_features_size INT] [--batch_size INT]

optional arguments:
  -h, --help            show this help message and exit

General Configuration:
  --gpu INT             Which GPU to use
  --no_cuda             Turn off cuda
  --num_workers INT     Number of workers for the parallel data loading 0
                        means sequential
  --no_cache BOOL       Turn off caching mol2graph computation
  --no_cache_mol BOOL   Whether to not cache the RDKit molecule for each
                        SMILES string to reduce memory usage cached by default
  --empty_cache BOOL    Whether to empty all caches before training or
                        predicting. This is necessary if multiple jobs are run
                        within a single script and the atom or bond features
                        change

Data Configuration:
  --use_compound_names  Use when test data file contains compound names in
                        addition to SMILES strings
  --no_features_scaling
                        Turn off scaling of features
  --max_data_size INT   Maximum number of data points to load
  --smiles_columns STRING
                        List of names of the columns containing SMILES
                        strings.By default, uses the first number_of_molecules
                        columns.
  --number_of_molecules INT
                        Number of molecules in each input to the model.This
                        must equal the length of smiles_columns if not None
  --atom_descriptors Bool
                        Use or not atom descriptors
  --bond_features_size INT
                        Size of the extra bond descriptors that will be used
                        as bond features to featurize a given molecule

Files:
  -f FILE, --configFile FILE
                        Input JSON file that contains all information for
                        training/predicting.
  --preds_path FILE     Path to CSV file where predictions will be saved
  --checkpoint_dir DIR  Directory from which to load model checkpoints(walks
                        directory and ensembles all models that are found)
  --checkpoint_path DIR
                        Path to model checkpoint (.pt file)
  --checkpoint_paths [FILE [FILE ...]]
                        Path to model checkpoint (.pt file)
  --data_path FILE      Path to CSV file containing testing data for which
                        predictions will be made
  --test_path FILE      Path to CSV file containing testing data for which
                        predictions will be made
  --features_path [FILE [FILE ...]]
                        Path to features to use in FNN (instead of
                        features_generator)
  --atom_descriptors_path FILE
                        Path to the extra atom descriptors.

Training Configuration:
  --batch_size INT      Batch size
```


