---
name: nf-core-meerpipe
description: This pipeline processes MeerKAT pulsar data using observation filters or CSV inputs to perform RFI cleaning, polarization calibration, and flux calibration while incorporating ephemerides and template files. Use when analyzing pulsar timing data from the MeerTime project to generate calibrated archives, dispersion/rotation measure calculations, and Time of Arrivals (ToA) for upload to the MeerTime data portal.
homepage: https://github.com/nf-core/meerpipe
---

# nf-core-meerpipe

## Overview
nf-core/meerpipe is designed for the processing of MeerKAT pulsar data as part of the MeerTime project. It automates the transition from raw observation archives to high-quality data products required for pulsar timing analysis, including RFI-cleaned archives and precise Time of Arrivals (ToA).

The pipeline handles complex calibration tasks such as polarization correction using Jones matrices and flux calibration via a bootstrap method. Results are formatted for integration with the MeerTime data portal, allowing researchers to verify observation quality and retrieve residuals for timing models.

## Data preparation
The pipeline identifies observations by querying the MeerTime database using specific filters or a provided CSV file. It automatically retrieves necessary metadata, ephemerides, and template files from internal repositories unless user-provided paths are specified via `--ephemeris` or `--template`.

Input selection parameters:
- `--pulsar`: Pulsar name for database search (e.g., J1410-7404).
- `--utcs` / `--utce`: Start and end UTC timestamps for filtering observations.
- `--project`: Project short code (e.g., PTA).
- `--obs_csv`: Path to a CSV file containing the observations to process.

The documentation also references a standard samplesheet format for input data:
```csv
sample,fastq_1,fastq_2
CONTROL_REP1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
```

## How to run
Execute the pipeline using the `nextflow run` command. Specify the target pulsar and time window along with the required execution profile and output directory.

```bash
nextflow run nf-core/meerpipe \
   -profile docker \
   --outdir ./results \
   --pulsar J1410-7404 \
   --utcs 2020-09-05-10:00:47 \
   --utce 2020-09-05-10:00:47
```

Key flags include:
- `-profile`: Choose a configuration profile (e.g., `docker`, `singularity`, `conda`).
- `--outdir`: The directory where results will be saved.
- `-resume`: Restarts the pipeline from the last cached step if it was interrupted.
- `-r`: Pin a specific version or release of the pipeline.

## Outputs
Final results are placed in the directory defined by `--outdir`. The primary deliverables include:
- `results.json`: A consolidated file containing analysis results and metadata.
- **Calibrated archives**: Cleaned and flux-calibrated data files in PSRCHIVE format.
- **Visualizations**: Pulse profiles and dynamic spectrum images created for quality control.
- **ToAs and Residuals**: Data products for timing analysis, which are typically uploaded to the MeerTime portal.

If `--upload` is enabled (default), results and images are automatically pushed to the MeerTime data portal. For more details about the output files, refer to the [official output documentation](https://nf-co.re/meerpipe/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)