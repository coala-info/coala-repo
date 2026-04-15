---
name: irissv
description: Iris refines the sequence accuracy of structural variant calls by generating high-quality consensus sequences from supporting reads. Use when user asks to improve the precision of insertion or deletion calls, perform local assembly of structural variants, or refine VCF entries using Racon or FalconSense.
homepage: https://github.com/mkirsche/Iris
metadata:
  docker_image: "quay.io/biocontainers/irissv:1.0.5--hdfd78af_0"
---

# irissv

## Overview
Iris (irissv) is a tool designed to improve the sequence accuracy of structural variant calls, particularly insertions. While many SV callers identify the presence and approximate location of a variant, the reported sequence is often imprecise. Iris addresses this by extracting the reads supporting a specific variant, generating a high-quality consensus sequence using tools like Racon or FalconSense, and then re-aligning that consensus to the reference genome to produce a refined VCF entry.

## Core Usage Patterns

### Basic Refinement
The standard command requires the reference genome, the initial VCF (typically from Sniffles), and the indexed BAM file containing the supporting reads.

```bash
irissv genome_in=reference.fasta vcf_in=calls.vcf reads_in=aligned_reads.bam vcf_out=refined_calls.vcf
```

### Performance Optimization
For large datasets, utilize multi-threading to speed up the local assembly and alignment processes.

```bash
irissv genome_in=ref.fa vcf_in=in.vcf reads_in=reads.bam vcf_out=out.vcf threads=16
```

### Refining Deletions
By default, Iris focuses on insertions. To attempt refinement of deletion positions and lengths, add the deletions flag.

```bash
irissv genome_in=ref.fa vcf_in=in.vcf reads_in=reads.bam vcf_out=out.vcf --also_deletions
```

### Handling Long Variants
Variants longer than 100 kbp are ignored by default to prevent massive VCF file sizes. To keep them (using their original unrefined sequences), use the following flag:

```bash
irissv genome_in=ref.fa vcf_in=in.vcf reads_in=reads.bam vcf_out=out.vcf --keep_long_variants
```

## Expert Tips and Best Practices

### Upstream Requirements (Sniffles)
Iris relies on the `RNAMES` INFO field in the input VCF to identify which reads support each variant. 
- **Critical**: When running Sniffles, you must include the `-n -1` (or a specific positive integer) parameter to ensure read names are saved in the VCF.

### Tool Selection
Iris bundles several external tools (minimap2, ngmlr, racon, falconsense). 
- **Aligner**: Minimap2 is the default. Use `--ngmlr` if you prefer the NGMLR aligner.
- **Consensus**: Racon is the default. Use `--falconsense` for FalconSense consensus.
- **PacBio Data**: If using the default minimap2 aligner with PacBio reads, always include the `--pacbio` flag for optimized alignment parameters.

### Resource Management
- **Intermediate Files**: Iris generates many temporary files during local assembly. Use `out_dir=path/to/dir` to keep your workspace clean.
- **Debugging**: If a run fails, use `--keep_files` to inspect the intermediate assemblies and alignments in the output directory.
- **Resuming**: If a process is interrupted, the `--resume` flag allows the tool to skip variants that have already been processed in the specified `out_dir`.

### Memory and Buffering
The `genome_buffer` parameter (default 100k) determines how much of the reference genome on either side of the SV is used for re-alignment. For very complex regions or extremely long insertions, increasing this buffer may improve results, though it increases computational overhead.

## Reference documentation
- [irissv - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_irissv_overview.md)
- [Iris: Implement for Refining Insertion Sequences](./references/github_com_mkirsche_Iris.md)