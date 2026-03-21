---
name: drugresponseeval
description: This pipeline evaluates drug response prediction models using standardized protocols on datasets like CTRPv2, CCLE, or custom viability measurements to produce performance metrics and summary plots. Use when comparing model performance across different evaluation modes like Leave-Cell-line-Out (LCO) or Leave-Drug-Out (LDO) and performing robustness or randomization tests to ensure statistically sound results.
homepage: https://github.com/nf-core/drugresponseeval
---

## Overview
nf-core/drugresponseeval is a bioinformatics framework designed to evaluate drug response prediction models in a statistically sound and reproducible manner. It automates standardized evaluation protocols, including cross-validation, hyperparameter tuning, and preprocessing workflows, supporting model types ranging from simple statistical models to complex neural networks.

The pipeline takes drug response datasets and model definitions as input to perform systematic benchmarking. It outputs comprehensive evaluation metrics, such as RMSE and Pearson correlation, along with visualization plots that summarize model performance, robustness, and stability across different biological contexts.

## Data preparation
The pipeline supports several pre-supplied datasets (CTRPv2, CTRPv1, CCLE, GDSC1, GDSC2, BeatAML2, PDX_Bruna, TOYv1, TOYv2) which are automatically downloaded from Zenodo. For custom data, users must provide files in a specific directory structure.

*   **Custom Dataset Layout**: Place files at `<path_data>/<dataset_name>/<dataset_name>_raw.csv`.
*   **Response Measures**: The input CSV must contain a column for the drug response measure (e.g., `LN_IC50`, `AUC`, `IC50`).
*   **Curve Fitting**: By default, the pipeline uses CurveCurator to refit raw viability data for better comparability; this can be disabled with `--no_refitting`.

Example directory structure for a custom dataset named `my_data`:
```text
data/
└── my_data/
    └── my_data_raw.csv
```

## How to run
Run the pipeline by specifying the models to test, the baseline predictors, and the target dataset. Use `-profile` to define the execution environment (e.g., `docker`, `singularity`).

```bash
nextflow run nf-core/drugresponseeval \
   -r 1.0.0 \
   -profile docker \
   --models RandomForest,XGBoost \
   --baselines NaiveMeanEffectsPredictor \
   --dataset_name CTRPv2 \
   --outdir ./results \
   --run_id evaluation_v1
```

Key parameters include:
*   `--test_mode`: Evaluation setting such as `LCO` (Leave-Cell-line-Out), `LDO` (Leave-Drug-Out), `LPO` (Leave-random-Pairs-Out), or `LTO` (Leave-Tissue-Out).
*   `--randomization_mode`: Enables randomization tests (e.g., `SVCC`, `SVRC`).
*   `--n_trials_robustness`: Number of trials for stability testing with varying seeds.
*   `-resume`: Use this Nextflow flag to restart a run from the last cached step.

## Outputs
Results are saved in the directory specified by `--outdir` (default is `results/`), within a subfolder named after the `--run_id`.

*   **Evaluation Metrics**: CSV files containing performance scores like RMSE, MSE, MAE, R^2, Pearson, Spearman, and Kendall correlations.
*   **Plots**: Visual summaries of model performance and comparison against baselines.
*   **Model Checkpoints**: Saved model states if `--final_model_on_full_data` is enabled.
*   **Reports**: Standard Nextflow execution reports (HTML) for pipeline traceability.

For detailed information on result interpretation, refer to the official [output documentation](https://nf-co.re/drugresponseeval/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
