---
name: mhcquant
description: This pipeline identifies and quantifies immunopeptides from DDA mass spectrometry data in mzML, RAW, or .d formats using a protein FASTA database and the Comet search engine. Use when analyzing immunopeptidomics data for T-cell immunotherapy research to perform peptide-spectrum matching, rescoring with MS²Rescore, and optional label-free quantification or spectral library generation.
homepage: https://github.com/nf-core/mhcquant
---

# mhcquant

## Overview
nf-core/mhcquant is a bioinformatics pipeline designed for the analysis of data-dependent acquisition (DDA) immunopeptidomics data. It identifies peptides presented on major histocompatibility complex (MHC) molecules, which are critical for T-cell immunosurveillance and clinical immunotherapy research. The workflow utilizes the OpenMS framework for computational mass spectrometry, performing database searches and peptide-spectrum-match rescoring.

The pipeline processes raw mass spectrometry spectra to produce filtered peptide identification lists and quantification matrices. It supports both local and global FDR control strategies and can optionally generate spectrum libraries for DIA-based searches or compute consensus epitopes using epicore.

## Data preparation
The pipeline requires a tab-separated samplesheet and a protein FASTA database. The samplesheet must contain information about the mass spectrometry runs, including their experimental conditions and replicates.

**Samplesheet columns:**
*   `ID`: A unique numeric identifier for the replicate.
*   `Sample`: The name of the sample (no spaces).
*   `Condition`: The experimental condition (no spaces).
*   `ReplicateFileName`: Path to the mass spectrometry run file. Supported formats include `.raw`, `.mzML`, `.mzML.gz`, `.d`, `.d.tar.gz`, and `.d.zip`.

**Example `samplesheet.tsv`:**
```tsv
ID	Sample	Condition	ReplicateFileName
1	tumor	treated	/path/to/msrun1.mzML
2	tumor	treated	/path/to/msrun2.mzML
3	tumor	untreated	/path/to/msrun3.mzML
```

**Reference files:**
*   `--fasta`: A protein database in FASTA format used for the Comet search. The pipeline automatically generates a decoy database unless `--skip_decoy_generation` is specified.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to specify a pipeline version with `-r` and use a container profile like `docker` or `singularity`.

**Basic command:**
```bash
nextflow run nf-core/mhcquant \
    -r 2.6.0 \
    -profile docker \
    --input 'samplesheet.tsv' \
    --fasta 'reference.fasta' \
    --outdir ./results
```

**Advanced command with quantification and epitope analysis:**
```bash
nextflow run nf-core/mhcquant \
    -profile docker \
    --input 'samplesheet.tsv' \
    --fasta 'reference.fasta' \
    --quantify \
    --global_fdr \
    --generate_speclib \
    --epicore \
    --annotate_ions \
    --outdir ./results
```

Use `-resume` to restart a run from the last successful step if it was interrupted.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverables include:

*   **Peptide Identifications**: Tab-separated files containing identified peptides, scores, and FDR filtering results.
*   **Quantification**: If `--quantify` is enabled, results include retention time alignment data and feature extraction matrices.
*   **Spectrum Libraries**: If `--generate_speclib` is enabled, libraries suitable for DIA searches are produced.
*   **Reports**: A MultiQC report summarizing the pipeline run and quality control metrics.
*   **Epitopes**: If `--epicore` is enabled, files containing core epitopes from overlapping peptides.

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/mhcquant/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)