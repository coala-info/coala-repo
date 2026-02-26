# chopin2 CWL Generation Report

## chopin2

### Tool Description
Supervised Classification with Hyperdimensional Computing.

### Metadata
- **Docker Image**: quay.io/biocontainers/chopin2:1.0.9.post1
- **Homepage**: https://github.com/cumbof/chopin2
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/chopin2/overview
- **Total Downloads**: 330.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cumbof/chopin2
- **Stars**: N/A
### Original Help Text
```text
usage: chopin2 [-h] [--dimensionality DIMENSIONALITY] [--levels LEVELS]
               [--retrain RETRAIN] [--stop] [--dataset DATASET]
               [--fieldsep FIELDSEP] [--psplit_training PSPLIT_TRAINING]
               [--crossv_k CROSSV_K] [--seed SEED] [--pickle PICKLE]
               [--features FEATURES] [--select_features]
               [--group_min GROUP_MIN] [--dump] [--cleanup] [--keep_levels]
               [--accuracy_threshold ACCURACY_THRESHOLD]
               [--accuracy_uncertainty_perc ACCURACY_UNCERTAINTY_PERC]
               [--spark] [--slices SLICES] [--master MASTER] [--memory MEMORY]
               [--gpu] [--tblock TBLOCK] [--nproc NPROC] [--verbose] [--cite]
               [-v]

Supervised Classification with Hyperdimensional Computing.

options:
  -h, --help            show this help message and exit
  --dimensionality DIMENSIONALITY
                        Dimensionality of the HD model (default: 10000)
  --levels LEVELS       Number of level hypervectors (default: None)
  --retrain RETRAIN     Number of retraining iterations (default: 0)
  --stop                Stop retraining if the error rate does not change
                        (default: False)
  --dataset DATASET     Path to the dataset file (default: None)
  --fieldsep FIELDSEP   Field separator (default: ,)
  --psplit_training PSPLIT_TRAINING
                        Percentage of observations that will be used to train
                        the model. The remaining percentage will be used to
                        test the classification model (default: 0.0)
  --crossv_k CROSSV_K   Number of folds for cross validation. Cross validate
                        HD models if --crossv_k greater than 1 (default: 0)
  --seed SEED           Random seed (default: 0)
  --pickle PICKLE       Path to the pickle file. If specified, "--dataset" and
                        "--fieldsep" parameters are not used (default: None)
  --features FEATURES   Path to a file with a single column containing the
                        whole set or a subset of feature (default: None)
  --select_features     This triggers the backward variable selection method
                        for the identification of the most significant
                        features. Warning: computationally intense! (default:
                        False)
  --group_min GROUP_MIN
                        Minimum number of features among those specified with
                        the --features argument (default: 1)
  --dump                Build a summary and log files (default: False)
  --cleanup             Delete the classification model as soon as it produces
                        the prediction accuracy (default: False)
  --keep_levels         Do not delete the level hypervectors. It works in
                        conjunction with --cleanup only (default: False)
  --accuracy_threshold ACCURACY_THRESHOLD
                        Stop the execution if the best accuracy achieved
                        during the previous group of runs is lower than this
                        number (default: 60.0)
  --accuracy_uncertainty_perc ACCURACY_UNCERTAINTY_PERC
                        Take a run into account if its accuracy is lower than
                        the best accuracy achieved in the same group, but
                        greaterthan the best accuracy minus its
                        "accuracy_uncertainty_perc" percent (default: 5.0)
  --spark               Build the classification model in a Apache Spark
                        distributed environment (default: False)
  --slices SLICES       Number of slices in case --spark argument is enabled.
                        This argument is ignored if --gpu is enabled (default:
                        None)
  --master MASTER       Master node address (default: None)
  --memory MEMORY       Executor memory (default: 1024m)
  --gpu                 Build the classification model on an NVidia powered
                        GPU. This argument is ignored if --spark is specified
                        (default: False)
  --tblock TBLOCK       Number of threads per block in case --gpu argument is
                        enabled. This argument is ignored if --spark is
                        enabled (default: 32)
  --nproc NPROC         Number of parallel jobs for the creation of the HD
                        model. This argument is ignored if --spark is enabled
                        (default: 1)
  --verbose             Print results in real time (default: False)
  --cite                Print references and exit (default: None)
  -v, --version         Print the current chopin2.py version and exit
```

