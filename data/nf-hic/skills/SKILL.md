---
name: hic
description: This pipeline processes paired-end Hi-C FASTQ data using a samplesheet and reference genome to perform mapping with Bowtie2, valid interaction detection, and contact map generation in HiC-Pro and Cooler formats. Use when analyzing chromosome conformation capture data to identify significant interactions, call Topologically Associating Domains (TADs), and define genomic compartments across various resolutions.
homepage: https://github.com/nf-core/hic
---

## Overview
nf-core/hic is a bioinformatics best-practice analysis pipeline for the analysis of Chromosome Conformation Capture data (Hi-C). It addresses the complexity of Hi-C data by handling read alignment, filtering of valid interaction products, and the generation of normalized contact matrices.

In practice, users provide raw sequencing reads and genomic references to obtain multi-resolution contact maps and downstream structural annotations. The pipeline supports both restriction enzyme-based protocols and DNAse Hi-C methods, delivering standardized outputs suitable for visualization in tools like HiGlass and further statistical analysis.

## Data preparation
The pipeline requires a CSV samplesheet and reference genome information.

**Samplesheet format**
The CSV must contain headers for sample names and paths to paired-end FASTQ files.
```csv
sample,fastq_1,fastq_2
HIC_ES_4,SRR5339783_1.fastq.gz,SRR5339783_2.fastq.gz
```

**Reference and Digestion Parameters**
- **Genome:** Specify a genome ID via `--genome` (e.g., `GRCh38`) or provide a FASTA file with `--fasta`.
- **Digestion:** For enzyme-based protocols, use `--digestion` (options: `hindiii`, `mboi`, `dpnii`, `arima`) or manually define `--restriction_site` and `--ligation_site`.
- **DNAse:** Use the `--dnase` flag for protocols not based on enzyme digestion, such as DNase Hi-C.
- **Chromosome Sizes:** If not provided via `--chromosome_size`, the pipeline generates this from the reference FASTA.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to use `-r` to pin a specific version and `-profile` for software management (e.g., `docker`, `singularity`, `conda`).

```bash
nextflow run nf-core/hic \
   -r 2.1.0 \
   -profile docker \
   --input samplesheet.csv \
   --genome GRCh37 \
   --outdir ./results
```

**Common parameters:**
- `--bin_size`: Comma-separated list of resolutions for contact maps (e.g., `1000000,500000`).
- `--tads_caller`: Methods for TAD calling (default: `hicexplorer,insulation`).
- `--split_fastq`: Boolean to split reads into chunks before mapping to improve performance.
- `-resume`: Use this flag to restart a run from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir`.

- **MultiQC Report:** A summary of quality control metrics from FastQC, HiC-Pro, and HiCExplorer.
- **Contact Maps:** Raw and normalized matrices in HiC-Pro and Cooler (`.cool`, `.mcool`) formats.
- **Downstream Analysis:** TAD calls and compartment definitions at specified resolutions.
- **Intermediates:** If enabled via `--save_aligned_intermediates` or `--save_pairs_intermediates`, BAM files and non-valid read pairs are preserved.

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/hic/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
