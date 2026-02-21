---
name: ngmlr
description: ngmlr (NextGenMap-LR) is a specialized long-read mapper designed to handle the high error rates and unique characteristics of third-generation sequencing technologies.
homepage: https://github.com/philres/ngmlr
---

# ngmlr

## Overview
ngmlr (NextGenMap-LR) is a specialized long-read mapper designed to handle the high error rates and unique characteristics of third-generation sequencing technologies. Unlike standard mappers, ngmlr is "SV-aware," meaning it can split reads or adjust alignment penalties to correctly span structural variations rather than forcing a linear alignment that might obscure biological truth. It is the preferred aligner for downstream SV calling tools like Sniffles.

## Basic Usage
The standard command structure requires a reference genome, a query read file, and an output path.

```bash
ngmlr -r reference.fasta -q reads.fastq -o output.sam
```

### Presets for Sequencing Platforms
Always use the `-x` flag to apply optimized parameter sets for your specific data type:
- **PacBio (Default):** `ngmlr -x pacbio -r ref.fa -q reads.fq -o out.sam`
- **Oxford Nanopore (ONT):** `ngmlr -x ont -r ref.fa -q reads.fq -o out.sam`

## Performance and Optimization
- **Multi-threading:** Use `-t` to specify the number of CPU cores. For a human genome (~3Gbp), 10+ cores are recommended.
  `ngmlr -t 16 -r ref.fa -q reads.fq -o out.sam`
- **BAM Compatibility:** If you plan to convert the output to BAM format, use `--bam-fix`. This reports reads with more than 64k CIGAR operations as unmapped to prevent format errors in older SAMtools versions.
- **Read Groups:** Add essential metadata for downstream pipelines using the `--rg-id` and `--rg-sm` (Sample) flags.

## Advanced Alignment Tuning
- **Identity Threshold:** Use `-i` (default 0.65) to discard low-identity alignments.
- **Residue Threshold:** Use `-R` (default 0.25) to discard reads where less than a certain percentage of the read length is mapped.
- **Small Inversions:** By default, ngmlr detects small inversions. If this is causing false positives in your specific context, disable it with `--no-smallinv`.
- **Sensitivity:** For ultra-long ONT reads, ensure you are using the latest version and the `-x ont` preset to handle the increased gap lengths.

## Expert Tips
1. **Reference Indexing:** ngmlr automatically builds an index of the reference. To save time in repetitive runs, it writes this index to disk. Use `--skip-write` if you are in a read-only environment or do not want to save the index file.
2. **Piping:** ngmlr can read from stdin if `-q` is omitted or set to `/dev/stdin`.
3. **Memory Requirements:** Expect to use approximately 10 GB of RAM for a 3 Gbp human genome alignment.

## Reference documentation
- [ngmlr GitHub Repository](./references/github_com_philres_ngmlr.md)
- [ngmlr Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ngmlr_overview.md)