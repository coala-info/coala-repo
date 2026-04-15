---
name: gsort
description: gsort reorders genomic data files based on a custom sequence of chromosomes while preserving file headers. Use when user asks to sort genomic files by a specific chromosome order, manage memory during large file sorts, or ensure parent-child record ordering in GFF files.
homepage: https://github.com/brentp/gsort
metadata:
  docker_image: "quay.io/biocontainers/gsort:0.1.5--he881be0_0"
---

# gsort

## Overview

gsort is a high-performance utility designed to reorder genomic data based on a custom sequence of chromosomes rather than standard alphanumeric sorting. Unlike general-purpose sort tools, gsort understands genomic file structures, ensuring that headers remain at the top and data is partitioned correctly. It is particularly valuable when preparing files for tools like GATK or bedtools that require specific, often non-standard, chromosome sequences.

## Common CLI Patterns

### Basic Sorting
Sort a genomic file using a genome file (tab-delimited `chrom\tlength`):
```bash
gsort input.vcf genome.file > sorted.vcf
```

### Sorting with Compressed Output
gsort outputs uncompressed data; pipe to `bgzip` for compressed results:
```bash
gsort input.bed genome.file | bgzip -c > sorted.bed.gz
```

### Memory Management
Limit memory usage (in Megabytes) for large files. gsort will use `$TMPDIR` for overflow:
```bash
gsort --memory 2000 input.vcf.gz genome.file | bgzip -c > sorted.vcf.gz
```

### GFF Parent-Child Sorting
In GFF files, some programs require that a record referenced in a `Parent` attribute appears before the record that references it. Use the `--parent` flag to enforce this:
```bash
gsort --parent input.gff genome.file > sorted.gff
```

### Chromosome Name Mapping
If your input file uses different chromosome naming conventions (e.g., hg19 vs. GRCh37) than your genome file, use a mapping file:
```bash
gsort --chromosomeMappings mappings.txt input.vcf genome.file
```

## Expert Tips and Best Practices

- **Genome File Order**: The order of chromosomes in your `.genome` file dictates the output order. To move Mitochondrial DNA (MT) to the end, simply place it as the last line in the `.genome` file.
- **Prefix Consistency**: gsort requires the 'chr' prefix to be consistent between the input file and the genome file. If one has the prefix and the other does not, the tool will error out.
- **Performance**: gsort is highly efficient, capable of sorting millions of variants in seconds. However, files with extremely large INFO strings (like ExAC VCFs) will significantly increase processing time.
- **Temporary Space**: When working with datasets larger than the allocated `--memory`, ensure your `$TMPDIR` (usually `/tmp/`) has sufficient space for temporary swap files.
- **Header Stability**: gsort automatically detects and preserves headers for VCF, BED, and GTF formats, keeping them at the top of the output.

## Reference documentation
- [gsort GitHub README](./references/github_com_brentp_gsort.md)
- [gsort Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gsort_overview.md)