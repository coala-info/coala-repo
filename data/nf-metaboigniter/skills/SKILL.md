---
name: metaboigniter
description: This pipeline ingests raw mass spectrometry data in mzML format to perform centroiding, feature detection, alignment, and compound identification using MS2Query and SIRIUS. Use when processing metabolomics datasets that require comprehensive peak processing, adduct detection, and metabolite quantification across multiple samples or ionization modes.
homepage: https://github.com/nf-core/metaboigniter
---

# metaboigniter

## Overview
nf-core/metaboigniter is a bioinformatics pipeline designed for the pre-processing and analysis of mass spectrometry-based metabolomics data. It handles raw mzML files to extract biological insights through a series of refinement steps including feature detection, adduct detection, and alignment to match features across different samples.

The pipeline produces a refined list of metabolites, filling in missing values via optional requantification and providing potential identifications based on MS2 spectral data. It is suitable for various experimental designs, supporting MS1, MS2, or combined MS12 data levels and both positive and negative ionization polarities.

## Data preparation
The pipeline requires a comma-separated (CSV) samplesheet containing paths to mzML files and their associated metadata. Each row represents a unique sample and must include the following columns:

- `sample`: Unique name for each sample (no spaces).
- `level`: The mass spectrometry data level, which must be `MS1`, `MS2`, or `MS12`.
- `type`: A group descriptor or classification (e.g., `control`, `treatment`).
- `msfile`: The absolute or relative path to the raw data file in `.mzML` format.

Example `samplesheet.csv`:
```csv
sample,level,type,msfile
CONTROL_REP1,MS1,normal,mzML_POS_Quant/X2_Rep1.mzML
CONTROL_REP2,MS1,normal,mzML_POS_Quant/X2_Rep2.mzML
POOL_MS2,MS2,normal,mzML_POS_ID/POOL_MS2.mzML
```

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to specify a pipeline version with `-r` and use a container profile for reproducibility.

```bash
nextflow run nf-core/metaboigniter \
   -r 1.1.0 \
   -profile docker \
   --input samplesheet.csv \
   --outdir ./results \
   --polarity positive
```

Key parameters include:
- `--polarity`: Set to `positive` (default) or `negative`.
- `--requantification`: Set to `true` to perform missing value imputation.
- `--identification`: Set to `true` to enable compound identification using MS2Query or SIRIUS.
- `-resume`: Use this flag to restart a run from the last successful process.

## Outputs
Results are saved in the directory specified by the `--outdir` parameter. The primary deliverables include:

- A comprehensive list of detected and potentially identified metabolites.
- `multiqc/`: A MultiQC report aggregating quality control metrics from various stages of the pipeline.
- Intermediate files such as centroided spectra or feature lists if `--save_intermeds` is enabled.

For a detailed description of all output files and how to interpret them, refer to the official [output documentation](https://nf-co.re/metaboigniter/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)