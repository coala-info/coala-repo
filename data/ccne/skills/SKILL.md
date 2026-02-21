---
name: ccne
description: The Carbapenemase-encoding gene copy number estimator (ccne) is a specialized bioinformatics tool used to quantify the abundance of resistance genes within a bacterial sample.
homepage: https://github.com/biojiang/ccne
---

# ccne

## Overview
The Carbapenemase-encoding gene copy number estimator (ccne) is a specialized bioinformatics tool used to quantify the abundance of resistance genes within a bacterial sample. By calculating the ratio of reads mapped to a target AMR gene versus a reference (either a single-copy housekeeping gene or the average genome depth), it provides a numerical estimate of how many copies of a resistance gene are present. This is essential for identifying high-level resistance caused by gene duplication or multi-copy plasmids.

## Core Workflows

### 1. Database and Species Discovery
Before running an analysis, verify the supported genes and species codes to ensure compatibility.
- List all supported AMR genes: `ccne-fast --listdb`
- List supported species and their default housekeeping genes: `ccne-fast --listsp`
- Format the internal BWA indices (required after first installation): `ccne-fast --fmtdb`

### 2. Fast Estimation (ccne-fast)
Use this mode when you have raw FASTQ reads and know the species of the isolate. It relies on specific housekeeping genes (e.g., *rpoB* for *K. pneumoniae*).

**Input File Format (`File.list`):**
The input is a tab-delimited or space-delimited file with the following structure:
`SampleID  /path/to/read_1.fastq.gz  /path/to/read_2.fastq.gz`

**Command Pattern:**
```bash
ccne-fast --amr KPC-2 --sp Kpn --in File.list --out results.txt --cpus 4
```
- `--amr`: The target gene (e.g., NDM-1, OXA-48).
- `--sp`: The species code (e.g., `Kpn` for Klebsiella, `Eco` for E. coli, `Aba` for A. baumannii).
- `--multiref`: Optional flag to use all available reference sequences for depth calculation, increasing robustness.

### 3. Accurate Estimation (ccne-acc)
Use this mode if you have a draft genome assembly (FASTA) in addition to raw reads. This is generally more accurate as it calculates the average depth across the entire genome rather than a single reference gene.

**Input File Format (`File.list`):**
`SampleID  /path/to/read_1.fastq.gz  /path/to/read_2.fastq.gz  /path/to/assembly.fasta`

**Command Pattern:**
```bash
ccne-acc --amr KPC-2 --in File.list --out results.txt --cpus 4
```

## Expert Tips and Best Practices

- **Species Selection**: If your species is not listed in `--listsp`, you can use the `Pls` (Plasmid) code, but you must manually specify a reference gene or replicon type using the `--ref` parameter.
- **Flanking Sequences**: Use the `--flank` parameter (e.g., `--flank 100`) to exclude the ends of the target gene from depth calculations. This helps avoid edge-effect biases where read mapping might be less reliable.
- **Interpreting Results**: 
    - A copy number near **1.0** suggests a single chromosomal integration.
    - Values significantly higher (e.g., **>3.0**) typically indicate plasmid-borne genes or tandem duplications.
    - Check the "SD" (Standard Deviation) columns in the output; high SD relative to the depth suggests uneven coverage or mapping issues.
- **Resource Management**: Always specify `--cpus` to match your environment, as the underlying BWA mapping is the primary bottleneck.

## Reference documentation
- [ccne GitHub Repository](./references/github_com_biojiang_ccne.md)
- [Bioconda ccne Package Overview](./references/anaconda_org_channels_bioconda_packages_ccne_overview.md)