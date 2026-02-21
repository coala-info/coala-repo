---
name: egap
description: EGAP (Entheome Genome Assembly Pipeline) is a comprehensive bioinformatics workflow designed to generate high-quality genome assemblies.
homepage: https://github.com/iPsychonaut/EGAP
---

# egap

## Overview

EGAP (Entheome Genome Assembly Pipeline) is a comprehensive bioinformatics workflow designed to generate high-quality genome assemblies. It automates the transition from raw sequencing reads to a curated, polished, and assessed final assembly. It is particularly useful for researchers working with hybrid data sets who need to compare different assembly algorithms (such as Flye, MaSuRCA, or SPAdes) and select the best result based on biological completeness (BUSCO/Compleasm) and contiguity (QUAST). The pipeline handles preprocessing, deduplication, assembly, polishing, and final quality classification.

## Installation

The most efficient way to install EGAP is via Bioconda:

```bash
conda create -n EGAP_env python=3.8
conda activate EGAP_env
conda install -c bioconda egap
```

## Command-Line Usage

The primary entry point is the `EGAP` command. It requires an input CSV to define sample metadata and paths.

### Basic Command
```bash
EGAP -csv samples.csv -o ./results -t 16 -r 64
```

### Parameters
- `--input_csv` / `-csv`: Path to the sample configuration CSV.
- `--output_dir` / `-o`: Directory for all pipeline outputs.
- `--cpu_threads` / `-t`: Number of CPU threads to allocate (default: 1).
- `--ram_gb` / `-r`: Amount of RAM in GB to allocate (default: 8).

## CSV Configuration

EGAP relies on a specific CSV structure to manage inputs. Use `None` for any fields that are not applicable to your specific sample.

### Required CSV Headers
The CSV must contain exactly these columns in order:
`ONT_SRA`, `ONT_RAW_DIR`, `ONT_RAW_READS`, `ILLUMINA_SRA`, `ILLUMINA_RAW_DIR`, `ILLUMINA_RAW_F_READS`, `ILLUMINA_RAW_R_READS`, `PACBIO_SRA`, `PACBIO_RAW_DIR`, `PACBIO_RAW_READS`, `SPECIES_ID`, `SAMPLE_ID`, `ORGANISM_KINGDOM`, `ORGANISM_KARYOTE`, `BUSCO_1`, `BUSCO_2`, `EST_SIZE`, `REF_SEQ_GCA`, `REF_SEQ`

### Input Mode Examples
- **Illumina Only**: Provide `ILLUMINA_RAW_F_READS` and `ILLUMINA_RAW_R_READS`. Set others to `None`.
- **Hybrid (ONT + Illumina)**: Provide `ONT_RAW_READS`, `ILLUMINA_RAW_F_READS`, and `ILLUMINA_RAW_R_READS`.
- **SRA Fetching**: Provide the accession number in `ONT_SRA`, `ILLUMINA_SRA`, or `PACBIO_SRA`. The pipeline will attempt to download the data automatically.

## Expert Tips and Best Practices

- **Fungal Optimization**: While adaptable, EGAP is highly optimized for fungal genomes. Ensure you provide appropriate lineages in the `BUSCO_1` and `BUSCO_2` columns (e.g., `ascomycota`, `basidiomycota`) for accurate completeness assessment.
- **Assembly Selection**: EGAP runs multiple assemblers depending on the input data. It automatically selects the "Best Assembly" by weighing BUSCO completeness against N50 and contig counts. Review the final classification (AMAZING, GREAT, OK, or POOR) in the output summary.
- **Polishing Logic**: If Illumina data is provided, the pipeline will perform Pilon polishing. If long reads (ONT/PacBio) are provided, it uses Racon (2x) and purge_dups to handle haplotigs.
- **Reference-Based Curation**: If a reference genome is provided in the `REF_SEQ` or `REF_SEQ_GCA` columns, the pipeline will use RagTag for scaffolding and patching the draft assembly.
- **Memory Management**: For large hybrid assemblies (especially using MaSuRCA), ensure the `-r` (RAM) parameter is set generously, as hybrid assembly is memory-intensive.

## Reference documentation
- [EGAP Overview](./references/github_com_iPsychonaut_EGAP.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_egap_overview.md)