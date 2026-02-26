---
name: methylartist
description: Methylartist is a suite of tools designed for the analysis and visualization of Oxford Nanopore Technologies methylation data. Use when user asks to initialize methylation databases from raw outputs, aggregate methylation counts over genomic intervals, or generate publication-quality locus and region plots.
homepage: https://github.com/adamewing/methylartist
---


# methylartist

## Overview
methylartist is a specialized suite designed for the analysis and visualization of Oxford Nanopore Technologies (ONT) methylation data. It streamlines the workflow from raw basecaller outputs to publication-quality figures. The tool is particularly effective at handling large-scale nanopore datasets by converting per-read methylation probabilities into efficient SQLite databases, which can then be queried for specific genomic loci or aggregated across regions of interest. It supports a wide range of inputs, including modern BAM files with MM/ML tags, legacy Nanopolish/Megalodon tables, and even C/U conversion assays like EM-seq.

## Core Workflows and CLI Patterns

### 1. Database Initialization
Before plotting, raw methylation calls should be loaded into a methylartist SQLite database (.db) for efficient access.

**From Nanopolish:**
```bash
# Load and scale grouped CpGs with a log-likelihood ratio threshold of 2.0
methylartist db-nanopolish -m calls.tsv.gz -d sample.db -t 2.0 -s

# Append additional results to an existing database
methylartist db-nanopolish -m extra_calls.tsv.gz -d sample.db -a
```

**From Megalodon:**
```bash
# Requires running megalodon_extras per_read_text first
methylartist db-megalodon -m per_read_modified_base_calls.txt --db sample.megalodon.db
```

**From C/U Substitution Data (EM-seq/WGBS):**
```bash
# Requires BAM with MD tags
methylartist db-sub -b alignments.bam -d sample.db
```

### 2. Aggregating Methylation (segmeth)
The `segmeth` command calculates methylation/demethylation counts over specific intervals. This is a prerequisite for generating strip or violin plots.

```bash
# Aggregate over a BED file using 32 processors
methylartist segmeth -d data_config.txt -i annotations.bed -p 32
```
*   **Input Config (`-d`):** A whitespace-delimited file containing `BAM_file Methylation_DB` per line.
*   **Intervals (`-i`):** BED3+2 format (chrom, start, end, label, strand).

### 3. Visualization Patterns

**Locus Plotting:**
Used for detailed views of specific genes or small genomic windows.
```bash
# Plot a specific locus with smoothed methylation lines
methylartist locus -b sample.bam -d sample.db -g hg38.fa -r chr1:10000-20000 --smoothed_csv auto
```

**Region Plotting:**
Used for larger genomic areas, often incorporating multiple samples or tracks.
```bash
# Plot a region with a specific colormap and shuffled read order for better visibility
methylartist region -b s1.bam,s2.bam -d s1.db,s2.db -r chr5:5000000-5100000 --colormap viridis --shuffle
```

## Expert Tips and Best Practices

*   **Parallelization:** Always use the `-p/--proc` flag for `segmeth` and `db-nanopolish` operations. Methylation parsing is CPU-intensive; using all available cores significantly reduces processing time.
*   **BAM Requirements:** Ensure all input BAM files are sorted and indexed (`samtools index`). Read names in the BAM must match the read names in the methylation data.
*   **Genome-Wide Tiling:** To generate genome-wide methylation statistics, use `bedtools makewindows` to create a tiling BED file (e.g., 10kbp bins) and pass it to `segmeth`.
*   **MM/ML Tags:** If using modern basecallers (Dorado/Guppy), ensure your BAM files contain the `MM` (base modification) and `ML` (probability) tags. These are the most efficient way to provide data to methylartist.
*   **Memory Management:** For extremely large regions, use `--skip_raw_plot` in `locus` or `region` commands if you only need the aggregate/smoothed data, as rendering thousands of individual reads can be memory-heavy.
*   **Custom Parsing:** If using non-standard tools (e.g., deepsignal-plant), use `db-custom` to map specific columns (readname, chrom, pos, strand, modprob) to the methylartist schema.

## Reference documentation
- [github_com_adamewing_methylartist.md](./references/github_com_adamewing_methylartist.md)
- [anaconda_org_channels_bioconda_packages_methylartist_overview.md](./references/anaconda_org_channels_bioconda_packages_methylartist_overview.md)