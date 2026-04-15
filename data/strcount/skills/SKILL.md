---
name: strcount
description: strcount counts repeat motifs within tandem repeat expansions using long-read data aligned to a reference graph. Use when user asks to count short tandem repeats, analyze long-read expansion data, or quantify motifs in specific genomic loci.
homepage: https://github.com/sabiqali/strcount
metadata:
  docker_image: "quay.io/biocontainers/strcount:0.1.1--py310h7cba7a3_1"
---

# strcount

## Overview
strcount is a bioinformatics tool specifically designed to count repeat motifs within tandem repeat expansions using long-read data. It functions by aligning reads to a reference graph of the target locus using GraphAligner. This tool is essential for researchers working on neurodegenerative diseases or other conditions characterized by STR expansions where traditional short-read sequencing fails to span the entire repeat region. Use this skill to prepare the required configuration files, execute the counting pipeline, and interpret the alignment-based results.

## Configuration Requirements
The tool requires a specific tab-separated configuration file (compatible with STRique). Each line must define a target locus with the following columns:

| Column | Description |
| :--- | :--- |
| **chr** | Chromosome name (must match reference FASTA). |
| **begin** | Start position of the repeat. |
| **end** | End position of the repeat. |
| **name** | Unique identifier for the locus (e.g., c9orf72). |
| **repeat** | The repeat motif sequence (e.g., GGCCCC). |
| **prefix** | Flanking sequence to the left of the repeat (suggested 150bp). |
| **suffix** | Flanking sequence to the right of the repeat (suggested 150bp). |

**Expert Tip**: While 150bp flanks are recommended, you can increase flank length to improve alignment specificity in repetitive regions, though this will increase processing time.

## Common CLI Patterns

### Basic Execution
Run the standard counting workflow on basecalled reads:
```bash
STRcount --reference genome.fa --fastq reads.fastq --config loci.config --output counts.tsv
```

### High-Stringency Filtering
To reduce false positives and ensure high-confidence counts, increase the identity and alignment fraction thresholds:
```bash
STRcount --reference genome.fa --fastq reads.fastq --config loci.config --output counts.tsv \
  --min-identity 0.85 \
  --min-aligned-fraction 0.9
```

### Handling Orientation
If the repeat expansion is expected on the negative strand or in a specific orientation relative to the reference:
```bash
STRcount --reference genome.fa --fastq reads.fastq --config loci.config --output counts.tsv \
  --repeat_orientation - \
  --prefix_orientation - \
  --suffix_orientation -
```

### Managing Large Datasets
Use a dedicated output directory to keep temporary alignment files organized and enable easier cleanup:
```bash
STRcount --reference genome.fa --fastq reads.fastq --config loci.config --output results.tsv \
  --output_directory ./str_workdir \
  --cleanup True
```

## Interpreting Results
The output is a `.tsv` file. Focus on these key columns for downstream analysis:
- **spanned**: A value of `1` indicates the read fully spanned the repeat and both flanking regions. These are the most reliable counts.
- **count**: The number of repeat motifs detected in that specific read.
- **identity**: The alignment identity; lower values may indicate poor quality reads or misalignments.
- **query_aligned_fraction**: Indicates how much of the target locus sequence was covered by the read alignment.

## Best Practices
- **Dependency Check**: Ensure `GraphAligner` is installed and available in your system PATH, as `strcount` relies on it for the underlying graph alignments.
- **Reference Matching**: Ensure the chromosome names in your `--config` file exactly match the headers in your `--reference` FASTA file.
- **Non-Spanned Reads**: By default, the tool requires reads to span the prefix/suffix. If you have very short reads or highly degraded DNA, you can use `--write-non-spanned`, but be aware that the resulting counts will be lower bounds rather than exact measurements.

## Reference documentation
- [STRcount GitHub Repository](./references/github_com_sabiqali_strcount.md)
- [Bioconda strcount Overview](./references/anaconda_org_channels_bioconda_packages_strcount_overview.md)