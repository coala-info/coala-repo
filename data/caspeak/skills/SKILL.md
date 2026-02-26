---
name: caspeak
description: CasPeak is a bioinformatics pipeline for detecting and validating mobile element insertions using outer-Cas9 targeted Nanopore sequencing data. Use when user asks to identify non-reference insertions, align long reads to mobile element consensus sequences, detect coverage peaks, or generate validated VCF and BED files for genomic variants.
homepage: https://github.com/Rye-lxy/CasPeak
---


# caspeak

## Overview
CasPeak is a specialized bioinformatics pipeline for detecting mobile element insertions (MEIs) that are not present in the reference genome. It leverages the unique signal of outer-Cas9 targeted Nanopore sequencing, where enrichment occurs at the insertion boundaries. This skill guides you through the multi-step process of aligning long reads, identifying coverage peaks that signify potential insertions, and validating these events to produce high-confidence VCF or BED outputs.

## Core Workflow

### 1. Quick Start (All-in-One)
If you want to run the entire pipeline from raw reads to validated variants in a single step, use the `exec` subcommand.

```bash
caspeak exec \
  --read /path/to/reads.fq.gz \
  --ref /path/to/reference.fa \
  --insert /path/to/consensus_ME.fa \
  --target-start <INT> \
  --target-end <INT> \
  --thread <INT> \
  --vcf
```

### 2. Step-by-Step Execution
For larger datasets or when manual inspection of intermediate files is required, run the subcommands sequentially.

**A. Alignment**
Aligns reads to both the reference genome and the mobile element consensus sequence using `LAST`.
```bash
caspeak align --read reads.fq.gz --ref ref.fa --insert me_consensus.fa --thread 8
```

**B. Peak Detection**
Identifies candidate insertion sites based on coverage enrichment.
```bash
caspeak peak \
  --read reads.fq.gz --ref ref.fa --insert me_consensus.fa \
  --target-start <INT> --target-end <INT> \
  --thread 8
```

**C. Validation**
Filters candidate peaks and generates the final call set.
```bash
caspeak valid --thread 8 --vcf
```

**D. Visualization**
Generates dotplots for identified peaks to manually inspect the evidence.
```bash
caspeak plot --maf result/validate.maf
```

## Expert Tips and Best Practices

### Input Requirements
- **Target Coordinates**: You must know the exact start and end positions of the Cas9 target site within your mobile element consensus sequence (`--target-start` and `--target-end`).
- **Genome Files**: If not using the default hg38, provide a genome file (chromosome names and lengths) via `--bedtools-genome` to ensure correct coverage calculations.

### Filtering and Sensitivity
- **Exogenous Elements**: If the mobile element is entirely absent from the reference genome (e.g., a transgene), use the `-x` or `--exog` flag during the `peak` step to optimize detection.
- **Masking**: Use `--mask` with a RepeatMasker `.out` file to reduce false positives in highly repetitive regions, though be aware this may slightly increase false negatives.
- **Read Length**: By default, reads shorter than 500bp are filtered. Adjust this using `--min-read-length` if working with fragmented DNA.
- **Coverage Threshold**: The default minimum coverage for a peak is 2. For high-depth data, increase `--min-cov` to reduce noise.

### Working Directory Management
- Always specify the same `--workdir` (default is current directory) for all subcommands in a project. CasPeak relies on the directory structure created by `align` to find files for `peak` and `valid`.

## Reference documentation
- [CasPeak GitHub Repository](./references/github_com_Rye-lxy_CasPeak.md)
- [CasPeak Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_caspeak_overview.md)