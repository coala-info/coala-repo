---
name: epitopeprediction
description: The pipeline performs epitope prediction and annotation from variants, proteins, or peptides using tools like mhcflurry, mhcnuggets, and netmhcpan to generate binding predictions for specified HLA alleles. Use when identifying putative neo-epitopes from genomic variants, scanning proteins for binding hotspots, or analyzing immunopeptidomics data, noting that Conda is currently unsupported.
homepage: https://github.com/nf-core/epitopeprediction
---

## Overview
nf-core/epitopeprediction is a bioinformatics pipeline designed for the prediction and annotation of epitopes. It addresses the need to identify peptides that bind to Major Histocompatibility Complex (MHC) molecules, which is critical for neo-epitope discovery and immunopeptidomics.

The workflow processes genomic variants, protein sequences, or direct peptide lists alongside specific HLA alleles. It produces a set of predicted binding affinities and annotations, allowing researchers to prioritize candidates for experimental validation.

## Data preparation
Users must provide a CSV samplesheet containing sample metadata and file paths. The pipeline supports VCF files (variants), FASTA files (proteins), and TSV files (peptides).

`samplesheet.csv` example:
```csv
sample,alleles,mhc_class,filename
GBM_1,A*01:01;A*02:01;B*07:02,I,gbm_1_variants.vcf
GBM_2,A*01:01;A*24:02;B*07:02,I,gbm_1_proteins.fasta
GBM_3,A*02:01;A*24:01;B*07:02,II,gbm_3_peptides.tsv
```

*   **alleles**: A semicolon-separated string of HLA alleles or a full path to a `.txt` file where each allele is on its own row.
*   **mhc_class**: Specifies the MHC class for prediction; valid values are `I` or `II`.
*   **References**: A `genome_reference` (e.g., `grch37`, `grch38`) is required for variant input, and a `proteome_reference` FASTA file is used for self-filtering peptides derived from genomic variants.

## How to run
Run the pipeline using Nextflow with a container engine such as Docker or Singularity. Note that Conda and Mamba profiles are currently unsupported due to upstream dependency issues.

```bash
nextflow run nf-core/epitopeprediction \
   -profile docker \
   --input samplesheet.csv \
   --outdir ./results \
   --tools mhcflurry,netmhcpan \
   --genome_reference grch38
```

Key parameters include:
*   `--tools`: Comma-separated list of predictors to use (e.g., `mhcflurry`, `mhcnuggets`, `mhcnuggetsii`, `netmhcpan`, `netmhciipan`).
*   `--wide_format_output`: Set to `true` to transform the output so each predictor and allele has its own column.
*   `--binder_only`: Filter the final results to include only peptides predicted as binders by at least one tool.
*   `--fasta_output`: If true, the pipeline writes wild-type and mutated protein sequences to FASTA and skips binding predictions.
*   `-resume`: Use this Nextflow flag to restart a run from the last cached step.

## Outputs
Results are saved in the directory specified by the `--outdir` parameter. The primary deliverables include binding prediction tables and a MultiQC report for quality control.

If the analysis involves genomic variants, the pipeline can also output FASTA files containing the affected protein sequences. For a comprehensive description of all result files, refer to the official [output documentation](https://nf-co.re/epitopeprediction/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
