---
name: auriclass
description: AuriClass identifies *Candida auris* clades from genomic data using Mash distances against a reference database. Use when user asks to classify *Candida auris* samples into clades, identify outgroups, or analyze FastQ and FastA files for species identification.
homepage: https://rivm-bioinformatics.github.io/auriclass/
metadata:
  docker_image: "quay.io/biocontainers/auriclass:0.5.4--pyhdfd78af_0"
---

# auriclass

## Overview

AuriClass is a specialized bioinformatics tool designed for the rapid identification of *Candida auris* clades. It utilizes Mash distances against a reference database to classify samples into known clades (I-VI) or identify them as outgroups. It is particularly useful for clinical microbiology and public health labs needing quick turnaround times, typically processing FastQ data in about a minute and FastA data in seconds.

## Installation

The recommended installation method is via Mamba or Conda:

```bash
mamba create -n env_auriclass -c bioconda -c conda-forge auriclass
conda activate env_auriclass
```

## Common CLI Patterns

### Basic Analysis
Run a standard analysis on a single sample using forward reads:
```bash
auriclass -o report.tsv sample_R1.fq.gz
```

### Analyzing Assemblies
To analyze a FastA file (e.g., a genome assembly):
```bash
auriclass --fasta -o report.tsv sample_assembly.fasta
```

### Customizing Sample Names
By default, the report uses "isolate" as the sample name. Use `--name` to specify a unique identifier:
```bash
auriclass --name Sample_001 -o Sample_001_report.tsv sample_R1.fq.gz
```

### Parallel Processing
AuriClass does not support internal multithreading. To process multiple samples efficiently, use GNU Parallel:
```bash
parallel auriclass --name {/.} -o {/.}.tsv {} ::: path/to/fastas/*.fasta
```

## Expert Tips and Best Practices

### Use Forward Reads for FastQ
For Illumina WGS data, it is a best practice to run AuriClass **only on the forward (R1) reads**. Reverse reads (R2) are often noisier, which can increase Mash distances and potentially trigger false quality warnings.

### Handling Multiple Input Files
AuriClass treats all input files in a single command as belonging to the **same sample**. 
- **Correct for one sample:** `auriclass R1.fq.gz R2.fq.gz` (Combines data for one prediction)
- **Incorrect for multiple samples:** `auriclass sample1.fq.gz sample2.fq.gz` (Will attempt to classify them as a single combined isolate)

### Forcing Analysis on Non-Candida Samples
If a sample fails the initial species check (QC_species), AuriClass skips the clade prediction. To force the analysis (e.g., if you suspect a highly divergent strain), increase the threshold:
```bash
auriclass --non_candida_threshold 1.0 sample_R1.fq.gz
```

### Interpreting QC Warnings
- **QC_species FAIL:** The sample is likely not *C. auris* or the data is too poor for identification.
- **QC_genome_size WARN:** Estimated size is outside 11.4–14.6 Mb. This may occur with diploid samples or significant contamination.
- **QC_multiple_hits WARN:** The sample is within the error bounds of multiple references, suggesting the classification might not be unique.

## Reference documentation

- [Full usage](./references/rivm-bioinformatics_github_io_auriclass_full_usage.md)
- [Running an analysis](./references/rivm-bioinformatics_github_io_auriclass_running_analysis.md)
- [Input & output](./references/rivm-bioinformatics_github_io_auriclass_input_output.md)
- [FAQ](./references/rivm-bioinformatics_github_io_auriclass_faq.md)