---
name: sequencetools
description: sequencetools generates genotype calls from BAM files using read-sampling methods like random haploid or majority calling. Use when user asks to generate genotypes from low-coverage sequencing data, call SNPs using pileupCaller, or convert BAM files to EIGENSOFT and PLINK formats.
homepage: https://github.com/stschiff/sequenceTools
---


# sequencetools

## Overview

The `sequencetools` skill enables the efficient generation of genotype calls from BAM files using read-sampling methods. This is particularly useful in paleogenomics where coverage is often too low for standard diploid genotyping. The primary tool, `pileupCaller`, allows for various calling strategies including random haploid sampling and majority calling. It integrates into bioinformatics pipelines by consuming standard `mpileup` streams and producing formats compatible with population genetics software like EIGENSOFT and ADMIXTOOLS.

## Core Workflow: Generating Genotypes

The standard pipeline involves piping the output of `samtools mpileup` directly into `pileupCaller`.

### 1. Prepare the Pileup
Use `samtools` to create the input. **Crucial:** Always use the `-B` flag to disable Base Alignment Quality (BAQ) recalibration, which can cause significant reference bias in ancient DNA.

```bash
samtools mpileup -R -B -q30 -Q30 -l <positions.txt> \
    -f <reference.fasta> \
    Sample1.bam Sample2.bam | \
    pileupCaller <options>
```

### 2. Execute pileupCaller
Choose a calling strategy based on your data quality and research goals.

#### Random Haploid Calling (Standard for aDNA)
Samples one random read at each specified SNP position.
```bash
pileupCaller --randomHaploid \
    --sampleNames Sample1,Sample2 \
    -f <Eigenstrat.snp> \
    -e <output_prefix>
```

#### Majority Calling (Higher Confidence)
Requires a minimum depth and calls the majority allele.
```bash
pileupCaller --majorityCall --downSampling --minDepth 3 \
    --sampleNames Sample1 \
    -f <Eigenstrat.snp> \
    -e <output_prefix>
```

## Expert Tips and Best Practices

### Handling Chromosome Name Mismatches
If your BAM files use `chr1` but your reference set uses `1`, use `sed` to strip the prefix in the pipe to ensure the SNP file matches the pileup:
```bash
samtools mpileup ... | sed 's/chr//' | pileupCaller ...
```

### Output Formats
- **Eigenstrat (`-e`):** Generates `.ind`, `.snp` (or `.pos`), and `.geno` files.
- **Plink (`-p`):** Generates `.fam`, `.bim`, and `.bed` files.
- **VCF (`--vcf`):** Outputs Variant Call Format to standard output.
- **FreqSum (Default):** If no output prefix is specified, it outputs FreqSum format to the terminal, which is excellent for quick debugging.

### Advanced Calling Options
- **--singleStrandMode:** Useful for ancient DNA libraries to mitigate damage-related errors by only looking at one strand.
- **--skipTransitions:** Ignores C->T and G->A transitions, which are common post-mortem damage patterns.
- **--seed:** Set a specific random seed for reproducibility when using `--randomHaploid`.

### Population Metadata
You can assign population names during the call:
```bash
pileupCaller --sampleNames S1,S2 --samplePopName PopA,PopB ...
```



## Subcommands

| Command | Description |
|---------|-------------|
| pileupCaller | PileupCaller is a tool to create genotype calls from bam files using read-sampling methods. To use this tool, you need to convert bam files into the mpileup-format, specified at http://www.htslib.org/doc/samtools.html (under "mpileup"). The recommended command line to create a multi-sample mpileup file to be processed with pileupCaller is |
| samtools | Tools for alignments in the SAM format |

## Reference documentation
- [SequenceTools README](./references/github_com_stschiff_sequenceTools_blob_master_README.md)
- [Changelog and Version History](./references/github_com_stschiff_sequenceTools_blob_master_Changelog.md)