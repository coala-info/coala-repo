---
name: ltr_retriever
description: LTR_retriever is a bioinformatics pipeline that filters raw LTR retrotransposon candidates to produce high-quality annotations and genome assembly quality metrics. Use when user asks to identify intact LTR retrotransposons, generate a non-redundant LTR library, or calculate the LTR Assembly Index to assess genome assembly quality.
homepage: https://github.com/oushujun/LTR_retriever
metadata:
  docker_image: "quay.io/biocontainers/ltr_harvest_parallel:1.2--hdfd78af_2"
---

# ltr_retriever

## Overview

`ltr_retriever` is a specialized bioinformatics pipeline designed to process raw LTR retrotransposon (LTR-RT) candidates into high-quality, non-redundant annotations. It filters out false positives from initial discovery tools (like LTRharvest or LTR_FINDER) and provides structural information, insertion time estimates, and a standardized metric for genome assembly quality known as the LTR Assembly Index (LAI). Use this skill when you need to characterize the repetitive landscape of a genome or assess the completeness of a genome assembly.

## Installation and Setup

The tool is available via Bioconda. It is recommended to use a dedicated environment due to its extensive dependency list (BLAST+, HMMER, RepeatMasker, etc.).

```bash
conda install -c bioconda ltr_retriever
```

## Core Workflow

### 1. Generate Raw Candidates
Before running `ltr_retriever`, you must generate candidate files using discovery tools. The best practice is to combine results from both `LTRharvest` and `LTR_FINDER_parallel`.

```bash
# Example using LTRharvest
gt suffixerator -db genome.fa -indexname genome.fa -tis -suf -lcp -des -ssp -sds -dna
gt ltrharvest -index genome.fa -minlenltr 100 -maxlenltr 7000 -mintsd 4 -maxtsd 6 -motif TGCA -motifmis 1 -similar 85 -vic 10 -seed 20 -seqids yes > genome.fa.harvest.scn

# Example using LTR_FINDER_parallel
LTR_FINDER_parallel -seq genome.fa -threads 10 -harvest_out -size 1000000 -time 300

# Combine inputs
cat genome.fa.harvest.scn genome.fa.finder.combine.scn > genome.fa.rawLTR.scn
```

### 2. Run LTR_retriever
Execute the main program using the combined candidate file.

```bash
LTR_retriever -genome genome.fa -inharvest genome.fa.rawLTR.scn -threads 10
```

### 3. Calculate LTR Assembly Index (LAI)
If you need to evaluate assembly continuity, run the LAI module using the outputs from the previous step.

```bash
LAI -genome genome.fa -intact genome.fa.pass.list -all genome.fa.out
```

## Expert Tips and Best Practices

- **Sequence Naming**: Ensure FASTA headers are short (under 15 characters) and use only alphanumeric characters or underscores. Long or complex names can cause failures in downstream tools like RepeatMasker.
- **Input Conversion**: If using outputs from LTR_STRUC, MGEScan 3.0.0, or LtrDetector, use the provided conversion scripts in the `bin/` directory (e.g., `convert_ltr_struc.pl`) to format them for `-inharvest`.
- **Sensitivity**: Combining multiple discovery tools (LTRharvest + LTR_FINDER) is highly recommended to maximize the sensitivity of the final library.
- **Memory Management**: For large genomes, `ltr_retriever` (v3.0.0+) includes logic to split sequences into chunks to reduce the memory footprint of RepeatMasker.
- **Output Files**:
    - `.pass.list`: Contains coordinates of intact LTR-RTs.
    - `.LTRlib.fa`: The non-redundant library for genome-wide annotation.
    - `.out.LAI`: The assembly quality metric (LAI > 20 is considered "Gold" standard).

## Reference documentation

- [LTR_retriever GitHub Repository](./references/github_com_oushujun_LTR_retriever.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ltr_retriever_overview.md)