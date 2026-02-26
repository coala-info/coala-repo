# drevalpy CWL Generation Report

## drevalpy

### Tool Description
Run the drug response prediction model test suite.

### Metadata
- **Docker Image**: quay.io/biocontainers/drevalpy:1.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/daisybio/drevalpy
- **Package**: https://anaconda.org/channels/bioconda/packages/drevalpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/drevalpy/overview
- **Total Downloads**: 74
- **Last updated**: 2026-01-14
- **GitHub**: https://github.com/daisybio/drevalpy
- **Stars**: N/A
### Original Help Text
```text
usage: drevalpy [-h] [--run_id RUN_ID] [--path_data PATH_DATA]
                [--models MODELS [MODELS ...]]
                [--baselines BASELINES [BASELINES ...]]
                [--test_mode TEST_MODE [TEST_MODE ...]]
                [--randomization_mode RANDOMIZATION_MODE [RANDOMIZATION_MODE ...]]
                [--randomization_type RANDOMIZATION_TYPE]
                [--n_trials_robustness N_TRIALS_ROBUSTNESS]
                [--dataset_name DATASET_NAME]
                [--cross_study_datasets CROSS_STUDY_DATASETS [CROSS_STUDY_DATASETS ...]]
                [--path_out PATH_OUT] [--no_refitting]
                [--curve_curator_cores CURVE_CURATOR_CORES]
                [--curve_curator_normalize] [--measure MEASURE] [--overwrite]
                [--optim_metric OPTIM_METRIC] [--n_cv_splits N_CV_SPLITS]
                [--response_transformation RESPONSE_TRANSFORMATION]
                [--multiprocessing]
                [--model_checkpoint_dir MODEL_CHECKPOINT_DIR]
                [--final_model_on_full_data] [--no_hyperparameter_tuning]

Run the drug response prediction model test suite.

options:
  -h, --help            show this help message and exit
  --run_id RUN_ID       identifier to save the results
  --path_data PATH_DATA
                        Path to the data directory
  --models MODELS [MODELS ...]
                        model to evaluate or list of models to compare
  --baselines BASELINES [BASELINES ...]
                        baseline or list of baselines. The baselines are also
                        hpam-tuned and compared to the models, but no
                        randomization or robustness tests are run.
                        NaiveMeanEffectsPredictor is always runas it is
                        required for evaluation
  --test_mode TEST_MODE [TEST_MODE ...]
                        Which tests to run (LPO=Leave-random-Pairs-Out,
                        LCO=Leave-Cell-line-Out, LDO=Leave-Drug-Out). Can be a
                        list of test runs e.g. 'LPO LCO LDO' to run all tests.
                        Default is LPO
  --randomization_mode RANDOMIZATION_MODE [RANDOMIZATION_MODE ...]
                        Which randomization tests to run, additionally to the
                        normal run. Default is None, which means no
                        randomization tests are run.Modes: SVCC, SVRC, SVCD,
                        SVRD. Can be a list of randomization tests e.g. 'SCVC
                        SCVD' to run two tests.SVCC: Single View Constant for
                        Cell Lines: in this mode, one experiment is done for
                        every cell line view the model uses (e.g. gene
                        expression, mutation, ..). For each experiment one
                        cell line view is held constant while the others are
                        randomized. SVRC Single View Random for Cell Lines: in
                        this mode, one experiment is done for every cell line
                        view the model uses (e.g. gene expression, mutation,
                        ..). For each experiment one cell line view is
                        randomized while the others are held constant. SVCD:
                        Single View Constant for Drugs: in this mode, one
                        experiment is done for every drug view the model uses
                        (e.g. fingerprints, target_information, ..). For each
                        experiment one drug view is held constant while the
                        others are randomized. SVRD: Single View Random for
                        Drugs: in this mode, one experiment is done for every
                        drug view the model uses (e.g. gene expression,
                        target_information, ..). For each experiment one drug
                        view is randomized while the others are held constant.
  --randomization_type RANDOMIZATION_TYPE
                        type of randomization to use. Choose from
                        "permutation" or "invariant". Default is "permutation"
                        "permutation": permute the features over the
                        instances, keeping the distribution of the features
                        the same but dissolving the relationship to the target
                        "invariant": the randomization is done in a way that a
                        key characteristic of the feature is preserved. In
                        case of matrices, this is the mean and standard
                        deviation of the feature view for this instance, for
                        networks it is the degree distribution.
  --n_trials_robustness N_TRIALS_ROBUSTNESS
                        Number of trials to run for the robustness test.
                        Default is 0, which means no robustness test is run.
                        The robustness test is a test where the model is
                        trained with varying seeds. This is done multiple
                        times to see how stable the model is.
  --dataset_name DATASET_NAME
                        Name of the drug response dataset
  --cross_study_datasets CROSS_STUDY_DATASETS [CROSS_STUDY_DATASETS ...]
                        List of datasets to use to evaluate predictions across
                        studies. Default is empty list which means no cross-
                        study datasets are used.
  --path_out PATH_OUT   Path to the output directory
  --no_refitting        Whether to run CurveCurator to sort out non-reactive
                        curves. By default, curve curator is applied and
                        curve-curated metrics are used.
  --curve_curator_cores CURVE_CURATOR_CORES
                        Max. number of cores used to fit curves with
                        CurveCurator following min(cores, #curves to fit).
  --curve_curator_normalize
                        Whether to normalize the response values to [0, 1] for
                        CurveCurator. Default is False.
  --measure MEASURE     The drug response measure used as prediction target.
                        Can be one of ['LN_IC50', 'response']
  --overwrite           Overwrite existing results with the same path out and
                        run_id?
  --optim_metric OPTIM_METRIC
                        Metric for hyperparameter tuning choose from ['MSE',
                        'RMSE', 'MAE', 'R^2', 'Pearson', 'Spearman',
                        'Kendall'] Default is RMSE.
  --n_cv_splits N_CV_SPLITS
                        Number of cross-validation splits to use for the
                        evaluation
  --response_transformation RESPONSE_TRANSFORMATION
                        Transformation to apply to the response variable
                        during training and prediction. Will be retransformed
                        after the final predictions. Possible values:
                        standard, minmax, robust
  --multiprocessing     Whether to use multiprocessing for the evaluation.
                        Default is False
  --model_checkpoint_dir MODEL_CHECKPOINT_DIR
                        Directory to save model checkpoints
  --final_model_on_full_data
                        If True, saves a final model, trained/tuned on the
                        union of all folds after CV
  --no_hyperparameter_tuning
                        Disable hyperparameter tuning and use first
                        hyperparameter set.
```

