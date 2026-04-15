---
name: hifiasm_meta
description: hifiasm_meta is a specialized assembler designed to produce high-quality de novo assemblies from metagenomic HiFi reads. Use when user asks to assemble metagenomic datasets, generate contig graphs from environmental samples, or handle high redundancy in microbial communities.
homepage: https://github.com/xfengnefx/hifiasm-meta
metadata:
  docker_image: "quay.io/biocontainers/hifiasm:0.25.0--h5ca1c30_0"
---

# hifiasm_meta

## Overview
hifiasm_meta is a specialized fork of the hifiasm assembler tailored for metagenomic data. It addresses the unique challenges of metagenomics by incorporating a read selection module to handle uneven species abundance and high redundancy, alongside meta-centric graph cleaning algorithms. It is designed to produce high-quality contig graphs (GFA) and can rescue genome bins that traditional binners might miss by traversing the primary assembly graph.

## Installation
The tool is available via Bioconda:
```bash
conda install -c bioconda hifiasm_meta
```

## Common CLI Patterns

### Standard Assembly
For most metagenomic datasets with standard coverage:
```bash
hifiasm_meta -t 32 -o output_prefix reads.fq.gz 2> assembly.log
```

### High Redundancy Datasets
If working with mock communities or datasets with extremely high redundancy (e.g., many closely related strains), enable read selection to prevent assembly collapse and reduce computational overhead:
```bash
hifiasm_meta -t 32 --force-rs -o output_prefix reads.fq.gz
```

### Fine-tuning Read Selection
Adjust the k-mer frequency thresholds to control how aggressively reads are dropped during selection:
- `--lowq-10`: 10% quantile threshold (default: 50). Lower values keep fewer reads.
- `--lowq-5`: 5% quantile threshold (default: 50).
- `-S`: Automatically estimate if read selection is necessary based on overlap counts.

## Output Files
The assembler produces several GFA files representing different stages of the assembly:
- `*.p_ctg.gfa`: Primary contig graph (most useful for downstream analysis).
- `*.a_ctg.gfa`: Alternate contig graph.
- `*.p_utg.gfa`: Cleaned unitig graph.
- `*.r_utg.gfa`: Raw unitig graph.

**Contig Naming Convention:**
Format: `^s[ID].[u/c]tg[Number][l/c]`
- `s[ID]`: Disconnected subgraph label. Contigs with the same `s` ID belong to the same haplotype or tangled group.

## Expert Tips and Best Practices

### Memory and Performance
- **Resource Estimation:** For a dataset containing a few strains (e.g., 5 E. coli strains), expect ~18GB peak memory and ~5 minutes runtime. Scale accordingly for complex environmental samples.
- **Thread Scaling:** Use the `-t` flag to match your available CPU cores; the tool is highly parallelized.

### Error Correction and Assembly Tuning
- **K-mer Length (`-k`):** Default is 51. Must be less than 64.
- **Haplotype-aware Correction (`-r`):** Default is 3 rounds. Increasing this may improve resolution in highly complex samples but increases runtime.
- **Adapter Trimming (`-z`):** If reads contain adapters, use `-z [length]` to trim bases from both ends before assembly.

### Resuming and Debugging
- **Bin Files:** hifiasm_meta saves intermediate states in `.bin` files. Use `-i` to ignore these if you want to restart from scratch.
- **Graph Debugging:** Use `--dbg-gfa` to resume specifically from the raw unitig graph stage, which is useful for testing different graph cleaning parameters without re-calculating overlaps.
- **Overlap Dumps:** Use `--write-paf` to generate PAF files containing intra-haplotype and inter-haplotype overlaps for manual inspection.

## Reference documentation
- [hifiasm-meta GitHub Repository](./references/github_com_xfengnefx_hifiasm-meta.md)
- [hifiasm_meta Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hifiasm_meta_overview.md)