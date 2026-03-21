---
name: methylarray
description: This pipeline processes Illumina methylation array data from raw IDAT files using a samplesheet to perform quality control, normalization, and probe filtering for SNPs, cross-reactivity, or sex chromosomes. Use when analyzing DNA methylation patterns to identify differentially methylated probes (DMPs), regions (DMRs), or blocks while optionally adjusting for cell composition and batch effects.
homepage: https://github.com/nf-core/methylarray
---

## Overview
The pipeline provides an end-to-end solution for the analysis of methylation data generated from Illumina arrays. It addresses the biological challenge of identifying epigenetic variations by processing raw intensity data into normalized methylation values and performing statistical testing for differential methylation across sample groups.

In practice, the workflow ingests paired red and green channel IDAT files and applies rigorous filtering to remove confounding factors such as cross-reactive probes or gender-related biases. The final deliverables include quality control reports, adjusted methylation matrices, and identified differentially methylated positions or regions suitable for downstream biological interpretation.

## Data preparation
The pipeline requires a comma-separated samplesheet provided via the `--input` parameter. This file defines the relationship between sample identifiers, their raw data files, and experimental groups.

**Samplesheet columns:**
- `sample_id`: Unique identifier for the sample (no spaces).
- `idat_red`: Path to the red channel IDAT file (must end in `.idat.gz`).
- `idat_green`: Path to the green channel IDAT file (must end in `.idat.gz`).
- `group`: Experimental group or condition for differential analysis.

Example `samplesheet.csv`:
```csv
sample_id,idat_red,idat_green,group
Sample1,S1_Red.idat.gz,S1_Grn.idat.gz,control
Sample2,S2_Red.idat.gz,S2_Grn.idat.gz,treatment
```

Additional reference data may include a FASTA genome file or an iGenomes identifier (e.g., `--genome GRCh38`). For cell composition adjustment, the pipeline can utilize reference bases like `champ.refbase` for whole blood samples.

## How to run
The pipeline is executed using Nextflow with mandatory parameters for the input samplesheet and output directory. It is recommended to use a specific release version with `-r` and a container profile for reproducibility.

```bash
nextflow run nf-core/methylarray \
   -r 1.0.0 \
   -profile docker \
   --input samplesheet.csv \
   --outdir ./results
```

To resume a failed or modified run from the last successful step, add the `-resume` flag. Optional analysis steps such as `--find_dmps`, `--find_dmrs`, or `--adjust_cell_composition` are enabled by default but can be toggled as needed.

## Outputs
Results are saved in the directory specified by `--outdir`. The primary summary of the run, including data quality and normalization metrics, is found in the MultiQC report.

Key output components include:
- **QC and Normalization**: Quality control plots and normalized methylation values (Beta or M-values).
- **Differential Analysis**: Tables and reports for Differentially Methylated Probes (DMPs), Regions (DMRs), and blocks.
- **Filtered Data**: Matrices with cross-reactive, SNP-overlapping, and sex-chromosome probes removed.

For a comprehensive description of all output files, refer to the [official output documentation](https://nf-co.re/methylarray/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
