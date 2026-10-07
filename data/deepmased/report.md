# deepmased CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| deepmased_evaluate | PASS |  |
| deepmased_features | PASS |  |
| deepmased_predict | PASS |  |
| deepmased_train | PASS |  |

## deepmased_train

### Tool Description
Train model

### Metadata
- **Docker Image**: quay.io/biocontainers/deepmased:0.3.1--pyh5ca1d4c_0
- **Homepage**: https://github.com/leylabmpi/DeepMAsED
- **Package**: https://anaconda.org/channels/bioconda/packages/deepmased/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepmased/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/leylabmpi/DeepMAsED
- **Stars**: N/A
### Original Help Text
```text
usage: DeepMAsED train [-h] [--technology TECHNOLOGY] [--save-path SAVE_PATH]
                       [--save-name SAVE_NAME] [--filters FILTERS]
                       [--n-hid N_HID] [--n-conv N_CONV] [--n-fc N_FC]
                       [--n-epochs N_EPOCHS] [--max-len MAX_LEN]
                       [--dropout DROPOUT] [--pool-window POOL_WINDOW]
                       [--n-folds N_FOLDS] [--lr-init LR_INIT]
                       [--norm-raw NORM_RAW] [--pickle-only]
                       [--force-overwrite] [--seed SEED] [--n-procs N_PROCS]
                       feature_file_table

Train model

positional arguments:
  feature_file_table    Table listing feature table files (see DESCRIPTION)

optional arguments:
  -h, --help            show this help message and exit
  --technology TECHNOLOGY
                        Assembler name in the data_path. "all-asmbl" will use all assemblers (default: all-asmbl)
  --save-path SAVE_PATH
                        Where to save training weights and logs (default: model)
  --save-name SAVE_NAME
                        Prefix for name in the save-path (default: deepmased)
  --filters FILTERS     N of filters for first conv layer. Then x2 (default: 8)
  --n-hid N_HID         N of units in fully connected layers (default: 50)
  --n-conv N_CONV       N of conv layers (default: 5)
  --n-fc N_FC           N of fully connected layers (default: 3)
  --n-epochs N_EPOCHS   N of training epochs (default: 10)
  --max-len MAX_LEN     Max contig len, fixed input for CNN (default: 10000)
  --dropout DROPOUT     Rate of dropout (default: 0.5)
  --pool-window POOL_WINDOW
                        Window size for average pooling (default: 50)
  --n-folds N_FOLDS     How many folds for CV. Use "-1" to skip & pool all data for training (default: -1)
  --lr-init LR_INIT     Size of test set (default: 0.001)
  --norm-raw NORM_RAW   Whether to normalize the four one-hot feature of raw (default: 0)
  --pickle-only         Only pickle files (default: False)
  --force-overwrite     Force re-creation of pickle files (default: False)
  --seed SEED           Seed used for numpy.random (default: 12)
  --n-procs N_PROCS     Number of parallel processes (default: 1)

DESCRIPTION:
    #-- Recommended training flow --#
    * Partition your data into train & test, and just use
      the train data for the following 
        * see feature file table description below
    * Select a grid search of hyper-parameters to consider
      (learning rate, number of layers, etc).
    * Train with kfold = 5 (for example) for each combination of 
      hyper-parameters.
    * For each combination of hyper-parameters, check scores.pkl, 
      which contains the cross validation scores, and select the 
      hyper-parameters leading to the highest average CV
    * Re-launch the whole training with `--n-folds -1` and the best 
      hyper-parameters (this is now one single run). 

    #-- Feature File Table format --#
    * DeepMAsED-SM will generate a feature file table that lists all
      feature files and their associated metadata (eg., assembler & sim-rep).
    * The table must contain the following columns:
      * `feature_file` = the path to the feature file (created by DeepMAsED-SM, see README)
        * The files can be (gzip'ed) tab-delim or pickled (see below on `--pickle-only`)
      * `rep` = the metagenome simulation replicate 
        * Set to "1" if real data
      * `assembler` = the metadata assembler

    #-- Pickled feature files --#
    DeepMAsED-SM will generate tab-delim feature tables; however,
    DeepMAsED uses formatted & pickled versions of the tab-delim feature tables.
    `DeepMAsED train` will automatically create pickled versions of the tab-delim
    tables. These pickled versions are written to the same locations as the tab-delim
    files. If the user provides tab-delim files, but DeepMAsED finds the pickled
    versions (same name, but with `pkl` for a file extension), then DeepMAsED
    will use the pickled versions, unless `--force-overwrite=True`.
    
```

## deepmased_predict

### Tool Description
Predict values

### Metadata
- **Docker Image**: quay.io/biocontainers/deepmased:0.3.1--pyh5ca1d4c_0
- **Homepage**: https://github.com/leylabmpi/DeepMAsED
- **Package**: https://anaconda.org/channels/bioconda/packages/deepmased/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepmased/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/leylabmpi/DeepMAsED
- **Stars**: N/A
### Original Help Text
```text
usage: DeepMAsED predict [-h] [--model-path MODEL_PATH]
                         [--model-name MODEL_NAME] [--mstd-name MSTD_NAME]
                         [--save-path SAVE_PATH] [--save-name SAVE_NAME]
                         [--cpu-only] [--pickle-only] [--force-overwrite]
                         [--seed SEED] [--n-procs N_PROCS]
                         feature_file_table

Predict values

positional arguments:
  feature_file_table    Table listing feature table files (see DESCRIPTION)

optional arguments:
  -h, --help            show this help message and exit
  --model-path MODEL_PATH
                        Directory containing the model (default: /usr/local/lib/python3.7/site-packages/DeepMAsED/Model)
  --model-name MODEL_NAME
                        Model name in the model_path (default: deepmased_model.h5)
  --mstd-name MSTD_NAME
                        Data mean and std name in the model_path (default: deepmased_mean_std.pkl)
  --save-path SAVE_PATH
                        Directory where to save output (default: .)
  --save-name SAVE_NAME
                        Prefix for name in the save_path (default: deepmased)
  --cpu-only            Only use CPUs, and no GPUs (default: False)
  --pickle-only         Only pickle files (default: False)
  --force-overwrite     Force re-creation of pickle files (default: False)
  --seed SEED           Seed used for numpy.random (default: 12)
  --n-procs N_PROCS     Number of parallel processes; just used for pickling (default: 1)

DESCRIPTION:
    Predicting misassemblies by used a model generated by `DeepMAsED train`
    or the pre-trained model that comes with the DeepMAsED package.
    
    #-- feature_file_table --#
    * See `DeepMAsED train` for a description 
    * Note that the 'assembler' and 'rep' columns are not actually used, 
      so placeholder values can used. Just make sure to include unique 
      `assembler` + `rep` combinations for each row in the table.
    
```

## deepmased_evaluate

### Tool Description
Evaluate model

### Metadata
- **Docker Image**: quay.io/biocontainers/deepmased:0.3.1--pyh5ca1d4c_0
- **Homepage**: https://github.com/leylabmpi/DeepMAsED
- **Package**: https://anaconda.org/channels/bioconda/packages/deepmased/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepmased/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/leylabmpi/DeepMAsED
- **Stars**: N/A
### Original Help Text
```text
usage: DeepMAsED evaluate [-h] [--model-path MODEL_PATH]
                          [--model-name MODEL_NAME] [--mstd-name MSTD_NAME]
                          [--save-path SAVE_PATH] [--save-name SAVE_NAME]
                          [--save-plot SAVE_PLOT] [--max-len MAX_LEN]
                          [--technology TECHNOLOGY] [--norm-raw NORM_RAW]
                          [--is-synthetic IS_SYNTHETIC] [--force-overwrite]
                          [--seed SEED] [--n-procs N_PROCS]
                          feature_file_table

Evaluate model

positional arguments:
  feature_file_table    Table listing feature table files (see Train docs)

optional arguments:
  -h, --help            show this help message and exit
  --model-path MODEL_PATH
                        Directory containing the model (default: /usr/local/lib/python3.7/site-packages/DeepMAsED/Model)
  --model-name MODEL_NAME
                        Model name in the model_path (default: deepmased_model.h5)
  --mstd-name MSTD_NAME
                        Data mean and std name in the model_path (default: deepmased_mean_std.pkl)
  --save-path SAVE_PATH
                        Directory where to save output (default: .)
  --save-name SAVE_NAME
                        Prefix for name in the save_path (default: deepmased)
  --save-plot SAVE_PLOT
                        Where to save plots (default: None)
  --max-len MAX_LEN     Max contig len, fixed input for CNN (default: 10000)
  --technology TECHNOLOGY
                        Assembler name in the data_path. "all-asmbl" will use all assemblers (default: all-asmbl)
  --norm-raw NORM_RAW   Whether to normalize the four one-hot feature of raw (default: 1)
  --is-synthetic IS_SYNTHETIC
                        Whether the data is synthetic and thus has ground truth (default: 1)
  --force-overwrite     Force re-creation of pickle files (default: False)
  --seed SEED           Seed used for numpy.random (default: 12)
  --n-procs N_PROCS     Number of parallel processes (default: 1)

DESCRIPTION:
    Evaluate a trained model generated by `DeepMAsED train`.

    All feature tables must be labeled either "features.tsv" or "features.tsv.gz"
    (or "features.pkl" if already processed).
    
```

## deepmased_features

### Tool Description
Create feature tables for Predict

### Metadata
- **Docker Image**: quay.io/biocontainers/deepmased:0.3.1--pyh5ca1d4c_0
- **Homepage**: https://github.com/leylabmpi/DeepMAsED
- **Package**: https://anaconda.org/channels/bioconda/packages/deepmased/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepmased/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/leylabmpi/DeepMAsED
- **Stars**: N/A
### Original Help Text
```text
usage: DeepMAsED features [-h] [-o OUTDIR] [-n NAME] [-g] [-p PROCS] [-d]
                          bam_fasta_file

Create feature tables for Predict

positional arguments:
  bam_fasta_file        Tab-delim table matching BAM and ref-fasta files (see Description)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTDIR, --outdir OUTDIR
                        Output directory (default: .)
  -n NAME, --name NAME  Output feature-file table name (default: feature_file_table.tsv)
  -g, --gzip            gzip feature tables (default: False)
  -p PROCS, --procs PROCS
                        Number of parallel processes (default: 1)
  -d, --debug           Debug mode for testing (default: False)

DESCRIPTION:
    In order to predict misassembled contigs with DeepMAsED predict,
    one must first create the table of features used for prediction.
 
    This subcommand takes as input >=1 BAM file and the associated fasta files
    of reference contigs and converted them to a set of features for each contig.
    The input is a table that maps BAM to ref-seq fasta files. 
    The format (with header): bam<tab>fasta

    The output will be a set of tab-delim feature tables (1 per input BAM-fasta pair)
    and a table summarizing all other others (the "feature_file_table").

    Note1: for a large number of contigs, the output can be
    10's of millions of rows or larger.

    Note2: we recommend filtering out all contigs <1000 bp. 
    
```


