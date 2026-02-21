---
name: bactopia-teton
description: The `bactopia-teton` skill provides specialized guidance for using the taxonomic classification methods integrated into the Bactopia ecosystem.
homepage: https://bactopia.github.io/
---

# bactopia-teton

## Overview
The `bactopia-teton` skill provides specialized guidance for using the taxonomic classification methods integrated into the Bactopia ecosystem. While Bactopia is a broad bacterial genomics pipeline, "Teton" specifically handles the identification of organisms by leveraging tools like Kraken2 and Bracken. Use this skill to configure classification parameters, manage taxonomic databases, and interpret the resulting species composition reports.

## Usage Patterns

### Basic Taxonomic Classification
To run the Teton classification as part of a Bactopia workflow, use the following pattern:
```bash
bactopia --samples samples.csv \
    --workflow teton \
    --outdir ./results \
    --kraken2_db /path/to/kraken2_database
```

### Refining Abundance with Bracken
Teton often utilizes Bracken to estimate species-level abundance from Kraken2 k-mer counts. Ensure your database includes the necessary `.kmer_distrib` files:
```bash
bactopia --samples samples.csv \
    --workflow teton \
    --kraken2_db /path/to/database \
    --bracken_read_len 150
```

### Common CLI Parameters
- `--kraken2_db`: Path to the Kraken2 formatted database (Required).
- `--min_bundle_reads`: Minimum number of reads required to process a sample.
- `--min_base_qual`: Minimum base quality for k-mer processing (default is often 7).
- `--quick`: Enable quick operation for Kraken2 (first hit classification).

## Best Practices
- **Database Selection**: The accuracy of Teton is entirely dependent on the Kraken2 database used (e.g., Standard, PlusPF, or custom). Always verify the database version and contents.
- **Memory Management**: Kraken2 loads the entire database into RAM. Ensure your environment has sufficient memory (often 32GB to 100GB+ depending on the database size).
- **Sample Metadata**: Use a structured `samples.csv` containing `sample,fastq_1,fastq_2` to process multiple isolates in parallel.
- **Output Interpretation**: Focus on the `*report.txt` files for high-level summaries and the Bracken-adjusted outputs for more accurate relative abundance estimates.

## Reference documentation
- [Bactopia Introduction](./references/bactopia_github_io_index.md)
- [Bactopia Teton Overview](./references/anaconda_org_channels_bioconda_packages_bactopia-teton_overview.md)