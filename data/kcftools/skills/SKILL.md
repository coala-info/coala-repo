---
name: kcftools
description: kcftools is a Java-based suite designed for rapid genomic variation analysis without the need for traditional sequence alignment.
homepage: https://github.com/sivasubramanics/kcftools
---

# kcftools

## Overview
kcftools is a Java-based suite designed for rapid genomic variation analysis without the need for traditional sequence alignment. By comparing k-mer counts from a query sample (stored in KMC databases) against a reference genome, it identifies gaps and hits to calculate identity scores. This approach is highly effective for population genetics, introgression screening, and GWAS, providing a faster alternative to BWA/SAMtools workflows for specific comparative tasks.

## Core Workflow

### 1. Prepare the KMC Database
Before using kcftools, you must generate a k-mer database using KMC3. 
**Critical Requirement**: You must use the `-p 9` (signature length) flag for compatibility.

```bash
# For FASTA files
kmc -k31 -m4 -t2 -ci0 -p9 -fm <input_fasta> <output_prefix> tmp/

# For FASTQ files
kmc -k31 -m4 -t2 -ci0 -p9 -fq <input_fastq> <output_prefix> tmp/
```

### 2. Detect Variations
The `getVariations` command is the primary tool for comparing a sample against the reference.

```bash
kcftools getVariations \
  --reference <ref.fasta> \
  --kmc <kmc_db_prefix> \
  --sample <sample_name> \
  --feature window \
  --window 1000 \
  --output <sample.kcf>
```

*   **Feature Types**: `window` (fixed-length), `gene`, or `transcript` (requires `--gtf`).
*   **Weights**: You can adjust the identity score calculation using `--wi` (inner distance), `--wt` (tail distance), and `--wr` (k-mer ratio).

### 3. Cohort Analysis
To analyze multiple samples together, merge individual `.kcf` files into a single cohort.

```bash
kcftools cohort -i <sample1.kcf> <sample2.kcf> -o <combined.kcf>
```

### 4. Downstream Processing
*   **Identify IBS Regions**: Use `findIBS` to find Identity-by-State windows across the cohort.
*   **Export to TSV**: Use `kcf2tsv` for general data inspection or compatibility with IBSpy-like workflows.
*   **Genotype Generation**: Use `kcf2gt` to convert k-mer variation data into a population-level genotype table.

## Performance and Memory Management
kcftools is memory-intensive when loading large KMC databases.

*   **JVM Heap**: Always specify the maximum heap size to avoid `OutOfMemoryError`.
    ```bash
    export KCFTOOLS_HEAP_SIZE=16G
    # OR
    java -Xmx16G -jar kcftools.jar <command>
    ```
*   **In-Memory Mode**: Use the `--memory` or `-m` flag in `getVariations` to load the entire KMC DB into RAM for significantly faster processing, provided you have sufficient heap space.
*   **Parallelization**: Use the `--threads` or `-t` option to speed up k-mer screening.

## Best Practices
*   **KMC Version**: Ensure KMC version 3.0.0 or higher is used.
*   **Signature Length**: Double-check that KMC was run with `-p 9`. Other signature lengths will cause kcftools to fail or produce incorrect results.
*   **Feature Selection**: Use `window` for discovery of unknown introgressions and `gene`/`transcript` (with a GTF) when looking for presence/absence variations in specific coding sequences.
*   **Sample Names**: Avoid special characters in sample names to prevent parsing issues in downstream cohort files.

## Reference documentation
- [github_com_sivasubramanics_kcftools.md](./references/github_com_sivasubramanics_kcftools.md)
- [anaconda_org_channels_bioconda_packages_kcftools_overview.md](./references/anaconda_org_channels_bioconda_packages_kcftools_overview.md)