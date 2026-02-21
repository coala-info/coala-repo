---
name: shigatyper
description: ShigaTyper is a specialized bioinformatics tool designed for the rapid identification of Shigella serotypes directly from raw sequencing reads.
homepage: https://github.com/CFSAN-Biostatistics/shigatyper
---

# shigatyper

## Overview
ShigaTyper is a specialized bioinformatics tool designed for the rapid identification of Shigella serotypes directly from raw sequencing reads. By utilizing a mapping-based approach rather than assembly, it provides a low-computation method to differentiate between Shigella species and serotypes, as well as EIEC. It is particularly effective for public health surveillance and clinical microbiology workflows where identifying the specific serotype and the presence of the virulent invasion plasmid (via the *ipaB* gene) is critical.

## Installation
The tool is primarily distributed via Bioconda.
```bash
conda create -n shigatyper -c conda-forge -c bioconda shigatyper
conda activate shigatyper
```

## Common CLI Patterns

### Illumina Paired-End Reads
This is the most common use case for high-accuracy serotyping.
```bash
shigatyper.py --R1 sample_R1.fastq.gz --R2 sample_R2.fastq.gz -n MySampleName
```

### Illumina Single-End Reads
```bash
shigatyper.py --SE sample.fastq.gz -n MySampleName
```

### Oxford Nanopore (ONT) Reads
When using long-read data, the `--ont` flag must be specified to adjust the mapping parameters.
```bash
shigatyper.py --SE sample_ont.fastq.gz --ont -n MySampleName
```

## Interpreting Results
ShigaTyper produces two primary tab-delimited output files.

### 1. <PREFIX>.tsv (Main Prediction)
This file contains the final call. Pay close attention to these columns:
- **prediction**: The identified Shigella serotype. If the tool finds no relevant markers, it will report "Not Shigella or EIEC".
- **ipaB**: A `+` indicates the presence of the *ipaB* gene, suggesting the strain retains the large virulence plasmid (pINV). A `-` suggests the plasmid may have been lost.
- **notes**: Provides context, such as whether the strain is likely EIEC or if no reads mapped to the database.

### 2. <PREFIX>-hits.tsv (Detailed Statistics)
Use this file to validate the confidence of a prediction:
- **% covered**: High-confidence calls typically have 100% coverage of the reference gene.
- **% accuracy**: Indicates the identity match. Low accuracy with high coverage may suggest a novel variant or a closely related serotype not perfectly matched in the database.

## Expert Tips and Best Practices
- **Sample Naming**: Always use the `-n` or `--name` parameter. By default, ShigaTyper uses the base name of the input FASTQ, which can lead to confusing output filenames if your FASTQs have long, complex strings.
- **Input Formats**: The tool natively supports gzipped FASTQ files (`.fastq.gz` or `.fq.gz`), so there is no need to decompress data beforehand.
- **Virulence Assessment**: The *ipaB* marker is a key indicator of pathogenicity. If a sample is predicted as a Shigella serotype but is *ipaB* negative, it may be an avirulent laboratory strain or a clinical isolate that lost its plasmid during subculturing.
- **Troubleshooting "No Hits"**: If you receive a "Not Shigella or EIEC" result for a sample you suspect is Shigella, check the `ipaH_c` hit in the `-hits.tsv` file. *ipaH* is a multicopy chromosomal marker for Shigella/EIEC; its absence usually confirms the sample is not Shigella.

## Reference documentation
- [ShigaTyper GitHub Repository](./references/github_com_CFSAN-Biostatistics_shigatyper.md)
- [Bioconda ShigaTyper Package](./references/anaconda_org_channels_bioconda_packages_shigatyper_overview.md)