---
name: geno2phenotb
description: geno2phenotb predicts drug resistance in *Mycobacterium tuberculosis* by processing raw genomic data through an automated machine learning pipeline. Use when user asks to predict drug resistance from FASTQ files, extract resistance-related genomic features, or perform targeted drug analysis for tuberculosis isolates.
homepage: https://github.com/msmdev/geno2phenoTB
metadata:
  docker_image: "quay.io/biocontainers/geno2phenotb:1.0.1--pyhdfd78af_1"
---

# geno2phenotb

## Overview

geno2phenotb is a specialized bioinformatics tool designed to automate the prediction of drug resistance in *Mycobacterium tuberculosis*. It bridges the gap between raw genomic data and clinical phenotypes by integrating a complete NGS processing pipeline (MTBseq) with trained machine learning models (Random Forests, Gradient Boosted Trees, and Rule-Based Classifiers). Use this skill to process raw FASTQ files, extract resistance-related features, and generate comprehensive resistance reports for clinical or research isolates.

## Installation and Verification

Ensure the environment is correctly configured before running analyses.

- **Verify Installation**: Run a complete self-test to ensure all dependencies (like MTBseq) are functional.
  ```bash
  geno2phenotb test -c
  ```
- **Fast Check**: Use the fast test to verify the Python environment without running the full alignment pipeline.
  ```bash
  geno2phenotb test -f
  ```

## Input Requirements

The tool is strict regarding file naming. FASTQ files must follow this pattern:
`[SampleID]_[LibID]_[*]_[Direction].f(ast)q.gz`

- **SampleID**: Must match the `--sample-id` argument.
- **Direction**: Must be `R1` (forward/single-end) or `R2` (reverse).
- **Example**: `ERR551304_L001_R1.fastq.gz`

## Command Line Interface (CLI) Patterns

### Standard Resistance Prediction
Run the full pipeline (alignment, feature extraction, and ML prediction) for all 12 supported drugs.
```bash
geno2phenotb run -i ./input_fastq/ -o ./results/ --sample-id ERR551304
```

### Targeted Drug Analysis
Specify one or more drugs using the `-d` flag to limit the scope of the prediction.
Supported codes: `AMK, CAP, DCS, EMB, ETH, FQ, INH, KAN, PAS, PZA, RIF, STR`.
```bash
geno2phenotb run -i ./input_fastq/ -o ./results/ --sample-id ERR551304 -d RIF -d INH -d PZA
```

### High-Efficiency Re-analysis
If MTBseq has already been run on the sample, skip the computationally intensive alignment step.
```bash
geno2phenotb run -i ./precomputed_mtbseq/ -o ./results/ --sample-id ERR551304 --skip-mtbseq
```

### Feature Extraction Only
Generate genotype and variant tables without running the machine learning prediction models.
```bash
geno2phenotb run -i ./input_fastq/ -o ./results/ --sample-id ERR551304 -p
```

## Python Interface Usage

For integration into custom pipelines, use the `predict` module.

```python
from geno2phenotb.predict import predict

results, features, rules = predict(
    fastq_dir="path/to/fastq",
    output_dir="path/to/output",
    sample_id="Sample_01",
    drugs=["RIF", "INH"],
    skip_mtbseq=False
)
```

## Interpreting Outputs

The tool generates several key files in the output directory:
- **`<sample_id>_resistance_report.txt`**: Summary of resistance status for each drug.
- **`<sample_id>_feature_importance_evaluation.tsv`**: Detailed breakdown of which mutations drove the ML prediction.
- **`<sample_id>_resistant_genotype_variants.tsv`**: List of specific variants identified that are associated with resistance.

## Best Practices

- **Resource Management**: The MTBseq step is computationally intensive. When processing large batches, ensure the host system has sufficient CPU and memory for alignment.
- **Drug Codes**: Always use the 2-3 letter uppercase codes (e.g., `FQ` for fluoroquinolones, `ETH` for thioamides).
- **Pre-processing**: If you have already performed variant calling using the FZB (Research Center Borstel) pipeline, always use `--skip-mtbseq` to save time.



## Subcommands

| Command | Description |
|---------|-------------|
| geno2phenotb run | Run the geno2phenotb pipeline. |
| geno2phenotb test | Test the installation of geno2phenoTB. |

## Reference documentation
- [Command Line Interface](./references/geno2phenotb_readthedocs_io_en_latest_cli.html.md)
- [Python Interface API](./references/geno2phenotb_readthedocs_io_en_latest_api_modules.html.md)
- [General Overview and Usage](./references/geno2phenotb_readthedocs_io_en_latest_readme.html.md)