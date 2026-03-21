---
name: diaproteomics
description: This pipeline performs automated quantitative analysis of DIA proteomics mass spectrometry data using raw or mzML files, spectral libraries, and optional iRT standards to produce peptide quantities and MSstats-based protein statistics. Use when processing data-independent acquisition (DIA) proteomics or peptidomics measurements, especially if you need to generate spectral libraries from DDA data or perform chromatogram alignment and FDR rescoring.
homepage: https://github.com/nf-core/diaproteomics
---

## Overview
The diaproteomics pipeline provides an automated solution for the quantitative processing of data-independent acquisition (DIA) proteomics mass spectrometry measurements. It addresses the complexity of DIA data by integrating targeted extraction, false discovery rate (FDR) estimation, and chromatogram alignment to ensure high-quality protein and peptide quantification.

The workflow accepts DIA RAW or mzML files and requires a spectral library, which can either be provided by the user or generated internally from matched DDA measurements. The final deliverables include comprehensive peptide quantity matrices, statistical protein analysis via MSstats, and various diagnostic visualizations such as volcano plots and heatmaps.

## Data preparation
The pipeline requires several TSV-formatted sample sheets depending on the analysis mode. All file paths in these sheets should be absolute or relative to the execution directory.

*   **Input Sample Sheet (`--input`)**: Required for DIA analysis.
    | Sample | BatchID | MSstats_Condition | MSstats_BioReplicate | Spectra_Filepath |
    | :--- | :--- | :--- | :--- | :--- |
    | 1 | StudyA | Malignant | BioRep1 | data/sample1.mzML |
*   **Spectral Library Sheet (`--input_spectral_library`)**: Required if not generating a library. Supports `.tsv`, `.pqp`, or `.TraML`.
    | Sample | BatchID | Library_Filepath |
    | :--- | :--- | :--- |
    | 1 | StudyA | data/library.pqp |
*   **DDA Sample Sheet (`--input_sheet_dda`)**: Required only if `--generate_spectral_library` is set.
    | Sample | BatchID | Spectra_Filepath | Id_Filepath |
    | :--- | :--- | :--- | :--- |
    | 1 | StudyA | data/dda_rep1.mzML | data/dda_rep1.pepXML |
*   **iRT Sample Sheet (`--irts`)**: Optional sheet for internal retention time standards.

## How to run
Run the pipeline using Nextflow with the appropriate profile (e.g., `docker`, `singularity`). Use `-r` to pin a specific version and `-resume` to continue a previous run.

```bash
# Standard run with existing library
nextflow run nf-core/diaproteomics \
    -profile docker \
    --input 'sample_sheet.tsv' \
    --input_spectral_library 'library_sheet.tsv' \
    --irts 'irt_sheet.tsv' \
    --outdir ./results

# Run with library generation from DDA data
nextflow run nf-core/diaproteomics \
    -profile docker \
    --input 'sample_sheet.tsv' \
    --generate_spectral_library \
    --input_sheet_dda 'dda_sheet.tsv' \
    --generate_pseudo_irts \
    --merge_libraries \
    --align_libraries \
    --outdir ./results
```

Key parameters include `--mz_extraction_window` (default 30 ppm), `--rt_extraction_window` (default 600s), and `--pyprophet_global_fdr_level` (e.g., 'protein').

## Outputs
Results are saved in the directory specified by `--outdir` (default is `./results`).

*   **Quantification Results**: CSV files containing peptide quantities and MSstats-based protein statistics.
*   **Visualizations**: If `--generate_plots` is enabled, the pipeline produces bar charts for protein/peptide counts, peptide charge distribution pie charts, RT deviation scatter plots, and heatmaps of peptide quantities.
*   **Reports**: Pyprophet score plots and optional mzTab exports (via `--mztab_export`).
*   **Pipeline Info**: Execution metrics and logs are stored in the `pipeline_info` subfolder.

For a detailed description of all output files, refer to the official [nf-core/diaproteomics output documentation](https://nf-co.re/diaproteomics/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
