cwlVersion: v1.2
class: CommandLineTool
baseCommand: drevalpy
label: drevalpy
doc: "Run the drug response prediction model test suite.\n\nTool homepage: https://github.com/daisybio/drevalpy"
inputs:
  - id: baselines
    type:
      - 'null'
      - type: array
        items: string
    doc: "baseline or list of baselines. The baselines are also\n                \
      \        hpam-tuned and compared to the models, but no\n                   \
      \     randomization or robustness tests are run.\n                        NaiveMeanEffectsPredictor
      is always runas it is\n                        required for evaluation"
    inputBinding:
      position: 101
      prefix: --baselines
  - id: cross_study_datasets
    type:
      - 'null'
      - type: array
        items: string
    doc: List of datasets to use to evaluate predictions across studies. Default
      is empty list which means no cross- study datasets are used.
    inputBinding:
      position: 101
      prefix: --cross_study_datasets
  - id: curve_curator_cores
    type:
      - 'null'
      - int
    doc: 'Max. number of cores used to fit curves with CurveCurator following min(cores,
      #curves to fit).'
    inputBinding:
      position: 101
      prefix: --curve_curator_cores
  - id: curve_curator_normalize
    type:
      - 'null'
      - boolean
    doc: Whether to normalize the response values to [0, 1] for CurveCurator. 
      Default is False.
    default: false
    inputBinding:
      position: 101
      prefix: --curve_curator_normalize
  - id: dataset_name
    type:
      - 'null'
      - string
    doc: Name of the drug response dataset
    inputBinding:
      position: 101
      prefix: --dataset_name
  - id: final_model_on_full_data
    type:
      - 'null'
      - boolean
    doc: If True, saves a final model, trained/tuned on the union of all folds 
      after CV
    inputBinding:
      position: 101
      prefix: --final_model_on_full_data
  - id: measure
    type:
      - 'null'
      - string
    doc: The drug response measure used as prediction target. Can be one of 
      ['LN_IC50', 'response']
    inputBinding:
      position: 101
      prefix: --measure
  - id: model_checkpoint_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save model checkpoints
    inputBinding:
      position: 101
      prefix: --model_checkpoint_dir
  - id: models
    type:
      - 'null'
      - type: array
        items: string
    doc: model to evaluate or list of models to compare
    inputBinding:
      position: 101
      prefix: --models
  - id: multiprocessing
    type:
      - 'null'
      - boolean
    doc: Whether to use multiprocessing for the evaluation. Default is False
    default: false
    inputBinding:
      position: 101
      prefix: --multiprocessing
  - id: n_cv_splits
    type:
      - 'null'
      - int
    doc: Number of cross-validation splits to use for the evaluation
    inputBinding:
      position: 101
      prefix: --n_cv_splits
  - id: n_trials_robustness
    type:
      - 'null'
      - int
    doc: Number of trials to run for the robustness test. Default is 0, which 
      means no robustness test is run. The robustness test is a test where the 
      model is trained with varying seeds. This is done multiple times to see 
      how stable the model is.
    default: 0
    inputBinding:
      position: 101
      prefix: --n_trials_robustness
  - id: no_hyperparameter_tuning
    type:
      - 'null'
      - boolean
    doc: Disable hyperparameter tuning and use first hyperparameter set.
    inputBinding:
      position: 101
      prefix: --no_hyperparameter_tuning
  - id: no_refitting
    type:
      - 'null'
      - boolean
    doc: Whether to run CurveCurator to sort out non-reactive curves. By 
      default, curve curator is applied and curve-curated metrics are used.
    inputBinding:
      position: 101
      prefix: --no_refitting
  - id: optim_metric
    type:
      - 'null'
      - string
    doc: Metric for hyperparameter tuning choose from ['MSE', 'RMSE', 'MAE', 
      'R^2', 'Pearson', 'Spearman', 'Kendall'] Default is RMSE.
    default: RMSE
    inputBinding:
      position: 101
      prefix: --optim_metric
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing results with the same path out and run_id?
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: path_data
    type:
      - 'null'
      - Directory
    doc: Path to the data directory
    inputBinding:
      position: 101
      prefix: --path_data
  - id: randomization_mode
    type:
      - 'null'
      - type: array
        items: string
    doc: "Which randomization tests to run, additionally to the normal run. Default
      is None, which means no randomization tests are run.Modes: SVCC, SVRC, SVCD,
      SVRD. Can be a list of randomization tests e.g. 'SCVC SCVD' to run two tests.SVCC:
      Single View Constant for Cell Lines: in this mode, one experiment is done for
      every cell line view the model uses (e.g. gene expression, mutation, ..). For
      each experiment one cell line view is held constant while the others are randomized.
      SVRC Single View Random for Cell Lines: in this mode, one experiment is done
      for every cell line view the model uses (e.g. gene expression, mutation, ..).
      For each experiment one cell line view is randomized while the others are held
      constant. SVCD: Single View Constant for Drugs: in this mode, one experiment
      is done for every drug view the model uses (e.g. fingerprints, target_information,
      ..). For each experiment one drug view is held constant while the others are
      randomized. SVRD: Single View Random for Drugs: in this mode, one experiment
      is done for every drug view the model uses (e.g. gene expression, target_information,
      ..). For each experiment one drug view is randomized while the others are held
      constant."
    default: None
    inputBinding:
      position: 101
      prefix: --randomization_mode
  - id: randomization_type
    type:
      - 'null'
      - string
    doc: 'type of randomization to use. Choose from "permutation" or "invariant".
      Default is "permutation" "permutation": permute the features over the instances,
      keeping the distribution of the features the same but dissolving the relationship
      to the target "invariant": the randomization is done in a way that a key characteristic
      of the feature is preserved. In case of matrices, this is the mean and standard
      deviation of the feature view for this instance, for networks it is the degree
      distribution.'
    default: permutation
    inputBinding:
      position: 101
      prefix: --randomization_type
  - id: response_transformation
    type:
      - 'null'
      - string
    doc: 'Transformation to apply to the response variable during training and prediction.
      Will be retransformed after the final predictions. Possible values: standard,
      minmax, robust'
    inputBinding:
      position: 101
      prefix: --response_transformation
  - id: run_id
    type:
      - 'null'
      - string
    doc: identifier to save the results
    inputBinding:
      position: 101
      prefix: --run_id
  - id: test_mode
    type:
      - 'null'
      - type: array
        items: string
    doc: Which tests to run (LPO=Leave-random-Pairs-Out, 
      LCO=Leave-Cell-line-Out, LDO=Leave-Drug-Out). Can be a list of test runs 
      e.g. 'LPO LCO LDO' to run all tests. Default is LPO
    default: LPO
    inputBinding:
      position: 101
      prefix: --test_mode
outputs:
  - id: path_out
    type:
      - 'null'
      - Directory
    doc: Path to the output directory
    outputBinding:
      glob: $(inputs.path_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drevalpy:1.4.1--pyhdfd78af_0
