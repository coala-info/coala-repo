---
name: malva
description: "MALVA performs mapping-free genotyping of known variants using k-mer frequencies. Use when user asks to genotype known variants, perform mapping-free variant detection, or run the MALVA genotyping pipeline."
homepage: https://algolab.github.io/malva/
---


# malva

## Overview
MALVA (Mapping-free ALternate-allele detection of known VAriants) provides a high-speed alternative to traditional alignment-based genotyping. Instead of mapping reads to a reference genome, it uses k-mer frequencies to determine the presence of known alleles. This skill covers the end-to-end workflow from raw reads to a genotyped VCF, including the use of the integrated `MALVA` wrapper script and the underlying `malva-geno` components.

## Core Workflows

### 1. The Integrated Pipeline (Recommended)
The `MALVA` shell script automates the k-mer counting (via KMC) and the genotyping steps.

```bash
MALVA [options] <reference.fa> <variants.vcf> <sample.fastq> > output.vcf
```

**Common Options:**
- `-k`: K-mer size for indexing (default: 35).
- `-r`: Reference k-mer size (default: 43).
- `-t`: Number of threads for KMC.
- `-m`: Max RAM in GB for KMC (default: 4).
- `-f`: The INFO field key for a priori frequencies (e.g., `EUR_AF` or `AF`).
- `-1`: Enable haploid mode (essential for mitochondria, Y-chromosome, or prokaryotes).

### 2. Manual Multi-Step Execution
For fine-grained control or to reuse k-mer counts across different variant sets, run the components individually.

**Step A: Count K-mers with KMC**
```bash
mkdir -p kmc_tmp
kmc -k43 -m4 -fm <sample.fastq> kmc_output_prefix kmc_tmp
```

**Step B: Index the Reference and Variants**
```bash
malva-geno index -k 35 -r 43 <reference.fa> <variants.vcf> kmc_output_prefix
```

**Step C: Call Genotypes**
```bash
malva-geno call -k 35 -r 43 <reference.fa> <variants.vcf> kmc_output_prefix > genotyped.vcf
```

## Expert Tips & Best Practices

- **K-mer Selection**: The default `-k 35` and `-r 43` are optimized for human data. If working with highly repetitive genomes or very short reads, consider increasing these values to improve specificity.
- **Memory Management**: Use the `-b` flag to adjust the Bloom Filter size (default 4GB). For large-scale human WGS, increasing this can reduce false positive k-mer matches.
- **A Priori Frequencies**: MALVA performs better when provided with population frequencies. Ensure your input VCF has an INFO field (like `AF`) and specify it using `-f`. If frequencies are unavailable, use `-u` for uniform probabilities.
- **Chromosome Naming**: If your reference uses "chr1" but your VCF uses "1", use the `-p` flag to strip the "chr" prefix for compatibility.
- **Haploid Data**: Always use the `-1` flag for haploid samples. Running haploid data in the default diploid mode will lead to incorrect genotype likelihoods and filtered variants.



## Subcommands

| Command | Description |
|---------|-------------|
| MALVA | MALVA is a tool for variant calling in sequencing data. |
| kmc | K-Mer Counter (KMC) |
| malva-geno | Top notch description of this tool |

## Reference documentation
- [MALVA Documentation](./references/algolab_github_io_malva.md)
- [Bioconda MALVA Overview](./references/anaconda_org_channels_bioconda_packages_malva_overview.md)