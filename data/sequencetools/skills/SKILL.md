---
name: sequencetools
description: The `sequencetools` package, primarily centered around the `pileupCaller` utility, is a specialized suite for paleogenomics.
homepage: https://github.com/stschiff/sequenceTools
---

# sequencetools

## Overview
The `sequencetools` package, primarily centered around the `pileupCaller` utility, is a specialized suite for paleogenomics. It addresses the unique challenges of ancient DNA (aDNA), such as low coverage and post-mortem degradation, by using read-sampling methods instead of traditional diploid genotype calling. It is the standard tool for transforming sequence alignment data (BAM files) into formats compatible with population genetics software like ADMIXTOOLS.

## Core Workflow: BAM to Eigenstrat
The most common use case involves piping `samtools mpileup` output directly into `pileupCaller`.

### 1. Generate the Pileup
Use `samtools` to create the input. 
**Critical Tip**: Always use the `-B` flag in `samtools` to disable Base Alignment Quality (BAQ) recalibration, as it causes significant reference bias in low-coverage aDNA.

```bash
samtools mpileup -R -B -q30 -Q30 -l <positions.txt> \
  -f <reference.fasta> \
  Sample1.bam Sample2.bam | pileupCaller [options]
```

### 2. Call Genotypes with pileupCaller
`pileupCaller` requires an Eigenstrat SNP file (`-f`) to define the sites and alleles to be called.

**Random Haploid Calling (Standard for low coverage):**
```bash
pileupCaller --randomHaploid \
  --sampleNames Sample1,Sample2 \
  -f <reference.snp> \
  -e <output_prefix> < pileup.txt
```

**Majority Calling (Higher quality, less data):**
Use this to reduce errors by requiring a minimum depth and calling the majority allele.
```bash
pileupCaller --majorityCall --downSampling --minDepth 3 \
  --sampleNames Sample1 \
  -f <reference.snp> \
  -e <output_prefix> < pileup.txt
```

## Expert CLI Patterns

### Handling Chromosome Naming Mismatches
If your BAM files use `chr1` but your reference dataset uses `1`, use `sed` in the pipeline to strip the prefix:
```bash
samtools mpileup ... | sed 's/chr//' | pileupCaller ...
```

### Mitigating aDNA Damage (Transitions)
Ancient DNA often suffers from C->T and G->A transitions. You can ignore these problematic sites:
- `--skipTransitions`: Completely ignores transition sites.
- `--singleStrandMode`: Useful for libraries where damage is restricted to one strand.
- `--transitionsMissing`: Treats transitions as missing data.

### Output Formats
- `-e <prefix>`: Eigenstrat format (generates `.ind`, `.pos`, `.geno`).
- `-p <prefix>`: Plink format.
- `--vcf`: VCF format.
- (Default): FreqSum format (useful for debugging/terminal inspection).

## Best Practices
- **Position Lists**: While optional, providing a `-l <list.txt>` to `samtools mpileup` significantly speeds up processing by restricting the pileup to known SNP positions.
- **Sample Names**: Use `--sampleNames` (comma-separated) or `--sampleNameFile` to ensure the output files are correctly labeled for downstream analysis.
- **Seed for Reproducibility**: Use `--seed <INT>` if you need to generate the exact same random haploid calls across different runs.

## Reference documentation
- [sequenceTools GitHub README](./references/github_com_stschiff_sequenceTools.md)
- [Bioconda sequencetools Overview](./references/anaconda_org_channels_bioconda_packages_sequencetools_overview.md)