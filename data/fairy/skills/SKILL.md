---
name: fairy
description: fairy is an alignment-free tool designed to provide approximate contig coverage for metagenome-assembled genomes (MAGs).
homepage: https://github.com/bluenote-1577/fairy
---

# fairy

## Overview

fairy is an alignment-free tool designed to provide approximate contig coverage for metagenome-assembled genomes (MAGs). By using a sketching-based approach rather than full read alignment, it achieves speeds 100x to 1000x faster than traditional methods while producing results compatible with major binning software. It is specifically optimized for multi-sample workflows where cross-mapping coverage is required.

## Core Workflow

### 1. Sketching Reads
Before calculating coverage, you must index your raw reads into sketches.

**For Short Reads (Paired-end):**
```bash
fairy sketch -1 *_1.fastq.gz -2 *_2.fastq.gz -d sketch_dir
```

**For Long Reads (Nanopore):**
```bash
fairy sketch -r long_reads.fq -d sketch_dir
```

**Customizing Sample Names:**
If filenames are identical across directories, use `-S` to provide unique identifiers:
```bash
fairy sketch -r dir1/reads.fq dir2/reads.fq -S sample1 sample2 -d sketch_dir
```

### 2. Calculating Coverage
Once sketches are generated, calculate the coverage matrix against your assembled contigs.

```bash
fairy coverage sketch_dir/*.bcsp contigs.fa -t 10 -o coverage.tsv
```

## Binner Integration

fairy supports specific output formats to match the requirements of different binning tools.

### MetaBAT2 (Default)
The default output is a coverage matrix compatible with `jgi_summarize_bam_contig_depths`.
```bash
# Generate coverage
fairy coverage sketch_dir/*.bcsp contigs.fa -o coverage.tsv

# Run MetaBAT2
metabat2 -i contigs.fa -a coverage.tsv -o bins/
```

### SemiBin2
SemiBin2 requires separate coverage files for each sample rather than a single matrix. Use the `--aemb-format` flag.
```bash
# Generate individual coverage files
fairy coverage contigs.fa sample1.bcsp --aemb-format -o cov_sample1.tsv
fairy coverage contigs.fa sample2.bcsp --aemb-format -o cov_sample2.tsv

# Run SemiBin2
SemiBin2 single_easy_bin -i contigs.fa cov_sample*.tsv -o results
```

### MaxBin2
Use the `--maxbin-format` flag to remove variance and length columns, producing a clean abundance matrix.
```bash
fairy coverage sketch_dir/*.bcsp contigs.fa --maxbin-format -o maxbin_cov.tsv
```

## Best Practices and Constraints

- **Multi-sample Only**: Do not use fairy for single-sample binning; the approximation is optimized for the differential coverage patterns found in multi-sample datasets.
- **Read Compatibility**: fairy works well with short reads and Nanopore reads. It is **not** recommended for PacBio HiFi reads.
- **Performance**: The pre-built x86-64 Linux binary uses `musl` instead of `glibc`, which may result in slightly lower performance compared to a version built from source or installed via Conda.
- **Memory/Threads**: Use the `-t` flag during the `coverage` step to utilize multiple CPU cores for faster processing of large contig files.

## Reference documentation
- [fairy GitHub Repository](./references/github_com_bluenote-1577_fairy.md)
- [fairy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fairy_overview.md)