---
name: genefuse
description: GeneFuse detects gene fusions directly from raw FASTQ files without requiring prior alignment to a reference genome. Use when user asks to detect gene fusions, identify druggable or COSMIC-curated fusions, or generate visualizations of fusion breakpoints and supporting reads.
homepage: https://github.com/OpenGene/genefuse
metadata:
  docker_image: "quay.io/biocontainers/genefuse:0.8.0--h5ca1c30_4"
---

# genefuse

## Overview
GeneFuse is a high-performance tool designed to detect gene fusions directly from raw FASTQ files without requiring prior alignment (mapping) to the whole genome. It is particularly useful for clinical and cancer research where specific "druggable" or COSMIC-curated fusions are of interest. By focusing on a target list of genes, it provides rapid results and generates rich visualizations of breakpoints, supporting reads, and inferred fusion proteins.

## Core CLI Usage
The basic command structure requires a reference genome, a fusion configuration file, and your sequencing data.

```bash
genefuse -r <ref.fasta> -f <fusion.csv> -1 <R1.fastq.gz> -2 <R2.fastq.gz> -h <report.html> -j <report.json> > <results.txt>
```

### Key Arguments
- `-r, --ref`: Path to the uncompressed reference genome FASTA (e.g., hg19.fa or hg38.fa).
- `-f, --fusion`: Path to the fusion target file in CSV format.
- `-1, --read1` / `-2, --read2`: Input FASTQ files (supports gzipped files).
- `-h, --html`: Filename for the interactive HTML visualization.
- `-j, --json`: Filename for the machine-readable JSON output.
- `-t, --thread`: Number of worker threads (default is 4).

## Expert Tips and Best Practices

### Reference Genome Preparation
GeneFuse currently does **not** support compressed reference genomes. You must decompress your FASTA files before running the tool:
```bash
gunzip hg38.fa.gz
genefuse -r hg38.fa ...
```

### Selecting the Right Fusion File
The tool includes pre-built fusion panels in the `genes/` directory. Choosing the correct one significantly impacts performance:
- **druggable.hg19/38.csv**: Use for clinical applications or when looking for actionable targets. This is the fastest mode.
- **cancer.hg19/38.csv**: Use for broader discovery. It includes all COSMIC-curated fusions but takes longer to process due to the larger gene set.

### Filtering and Sensitivity
You can tune the detection sensitivity using these flags:
- `-u, --unique`: Minimum number of unique supporting reads required to report a fusion (default is 2). Increase this to reduce false positives in high-depth data.
- `-d, --deletion`: Minimum length for intra-gene deletions to be reported (default is 50bp).

### Creating Custom Fusion Panels
If you need to target specific genes not in the default sets, use the provided helper script. You will need a `refFlat.txt` file from the UCSC Genome Browser.

1. Prepare a `gene_list.txt` (one gene symbol per line).
2. Run the generator:
```bash
python3 scripts/make_fusion_genes.py gene_list.txt -r refFlat.txt -o custom_fusion.csv
```

## Troubleshooting
- **No fusions found**: Ensure the chromosome naming convention in your reference FASTA (e.g., "chr1" vs "1") matches the convention used in your fusion CSV file.
- **Memory issues**: While GeneFuse is efficient, processing the full `cancer.csv` panel against deep WGS data may require significant RAM. Use the `druggable.csv` panel if resources are limited.

## Reference documentation
- [GeneFuse GitHub Repository](./references/github_com_OpenGene_GeneFuse.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_genefuse_overview.md)