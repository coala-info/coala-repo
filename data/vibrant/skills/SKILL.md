---
name: vibrant
description: VIBRANT identifies viruses and integrated prophages in genomic data. Use when user asks to identify viruses, distinguish viral sequences from microbial backgrounds, annotate viral sequences, identify circular viral sequences, or extract prophages.
homepage: https://github.com/AnantharamanLab/VIBRANT
metadata:
  docker_image: "quay.io/biocontainers/vibrant:1.2.1--hdfd78af_4"
---

# vibrant

## Overview
VIBRANT (Virus Identification By iteRative ANnoTation) is a specialized bioinformatic tool designed for the high-throughput identification of viruses within genomic data. It utilizes a combination of protein annotation and neural network classification to distinguish viral sequences from microbial backgrounds. The tool is highly effective at identifying both lytic viruses and integrated prophages, providing detailed functional annotations and quality metrics for the recovered viral community.

## Installation and Setup
VIBRANT is primarily distributed via Bioconda.

```bash
# Install via Conda
conda install bioconda::vibrant
```

Before running VIBRANT for the first time, verify the installation and database setup:
```bash
# Verify setup and dependencies
python3 VIBRANT_setup.py -test
```

## Common CLI Patterns

### Basic Virus Identification
To run VIBRANT on a FASTA file of scaffolds or contigs:
```bash
python3 VIBRANT_run.py -i input_scaffolds.fasta
```

### Organized Output Management
Use the `-folder` flag to specify a custom output directory. This is recommended for shared computing environments or when running multiple samples.
```bash
python3 VIBRANT_run.py -i input.fasta -folder /path/to/output_dir
```

### Custom Database Paths
If you have moved the VIBRANT databases or files from their default installation location, use the `-d` and `-m` flags:
```bash
python3 VIBRANT_run.py -i input.fasta -d /path/to/databases/ -m /path/to/files/
```

## Expert Tips and Best Practices

### Identifying Circular Sequences
VIBRANT automatically identifies circular viral sequences. Check the `phages_circular.fna` output file for these high-confidence, complete viral genomes.

### Prophage Extraction
For integrated prophages, VIBRANT provides specific coordinate locations. Refer to `integrated_prophage_coordinates.tsv` to find the exact scaffold locations of excised proviruses.

### Downstream Compatibility (vConTACT2)
VIBRANT output headers can be verbose. If you plan to use the predicted proteins for taxonomic classification in tools like vConTACT2, use the provided utility script to simplify the definition lines:
```bash
python3 scripts/simplify_faa-ffn.py example.phages_combined.faa
```

### Troubleshooting Runs
If a run fails or exits unexpectedly, check the following logs:
- `log_run.log`: Contains summary information, commands used, and general errors.
- `log_annotation.log`: Contains specific errors related to the HMM annotation process.

### Sequence Length Requirements
VIBRANT requires a minimum sequence length of 1000bp. Sequences shorter than this will be filtered out before analysis.

## Reference documentation
- [VIBRANT Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vibrant_overview.md)
- [VIBRANT GitHub Repository](./references/github_com_AnantharamanLab_VIBRANT.md)