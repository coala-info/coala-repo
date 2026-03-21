---
name: ribomsqc
description: This pipeline performs automated quality control of ribonucleoside mass spectrometry data by processing Thermo RAW files using a samplesheet and a specific analytes TSV file to generate extracted ion chromatograms and MultiQC reports. Use when monitoring mass spectrometer performance for ribonucleoside analysis to visualize QC metrics and verify compound retention times across multiple samples.
homepage: https://github.com/nf-core/ribomsqc
---

## Overview
The ribomsqc pipeline solves the problem of manual quality control in ribonucleoside analysis by mass spectrometry. It automates the extraction of ion chromatograms (XIC) and the calculation of QC metrics to ensure mass spectrometer performance remains consistent across experimental runs.

In practice, users provide raw instrument data and a list of target compounds with their expected mass-to-charge ratios and retention times. The pipeline converts proprietary formats, extracts relevant peaks based on user-defined tolerances, and aggregates these findings into a visual report for rapid assessment of data quality.

## Data preparation
The pipeline requires two primary input files: a samplesheet and an analytes definition file.

**Samplesheet**
A CSV file containing the paths to your Thermo RAW files. It must have a header with exactly two columns: `id` (a unique sample name) and `raw_file` (the full path to the `.raw` file).

```csv
id,raw_file
Day_5,path/to/Day_5.raw
```

**Analytes TSV**
A tab-separated file describing the compounds for peak extraction. It must include `short_name`, `long_name`, `mz_M0`, and `rt_teoretical` (in seconds). Other columns like `mz_M1`, `mz_M2`, and `ms2_mz` are optional but the header structure must be maintained.

```tsv
short_name	long_name	mz_M0	mz_M1	mz_M2	ms2_mz	rt_teoretical
C	Cytidine	244.0928			112.0505	555
U	Uridine	245.0768			113.0346	1566
```

## How to run
Run the pipeline using the `nextflow run` command. You must specify the input samplesheet, the analytes TSV, and the target analyte (use `all` for the entire list).

```bash
nextflow run nf-core/ribomsqc \
  -r 1.0.0 \
  -profile <docker/singularity/conda> \
  --input samplesheet.csv \
  --analytes_tsv qcn1.tsv \
  --analyte all \
  --rt_tolerance 120 \
  --mz_tolerance 7 \
  --ms_level 1 \
  --outdir results
```

Use `-resume` to restart a run from the last successful step if it was interrupted. Pipeline-specific parameters use double dashes (`--`), while Nextflow core parameters use a single dash (`-`).

## Outputs
Results are saved in the directory specified by `--outdir`. The primary deliverable is the `multiqc/` folder, which contains the `multiqc_report.html` summarizing all QC metrics and visualizations.

Other key outputs include:
- **XIC Plots**: PDF files (default `xic_plot.pdf`) containing the extracted ion chromatograms for the analyzed compounds.
- **Merged Data**: JSON files containing the processed metrics used to generate the reports.

For a detailed description of all output files, refer to the official [output documentation](https://nf-co.re/ribomsqc/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
