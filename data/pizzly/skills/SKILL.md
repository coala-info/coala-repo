---
name: pizzly
description: Pizzly is a specialized tool for the rapid identification of gene fusions in cancer RNA-Seq samples by processing kallisto pseudo-alignments. Use when user asks to identify chimeric transcripts, call gene fusions, or process kallisto fusion output files.
homepage: https://github.com/pmelsted/pizzly
metadata:
  docker_image: "quay.io/biocontainers/pizzly:0.37.3--0"
---

# pizzly

## Overview
Pizzly is a specialized tool designed for the rapid identification of gene fusions in cancer RNA-Seq samples. It operates as a downstream processor for kallisto, leveraging its pseudo-alignment capabilities to identify chimeric transcripts. The workflow is highly efficient, requiring a reference transcriptome (FASTA) and an annotation file (GTF). It is particularly useful when computational speed is a priority without sacrificing the sensitivity of fusion detection.

## Installation
Pizzly is most easily installed via Bioconda:
```bash
conda install -c bioconda pizzly
```

## Core Workflow
Fusion detection with pizzly is a three-step process involving kallisto and pizzly.

### 1. Prepare the Index
Create a kallisto index from your transcriptome FASTA.
```bash
kallisto index -i index.idx -k 31 transcripts.fa.gz
```

### 2. Quantify with Fusion Detection
Run kallisto quantification with the `--fusion` flag enabled. This generates the `fusion.txt` file required by pizzly.
```bash
kallisto quant -i index.idx --fusion -o output_dir r1.fastq.gz r2.fastq.gz
```

### 3. Call Fusions with Pizzly
Run pizzly using the `fusion.txt` generated in the previous step.
```bash
pizzly -k 31 \
  --gtf transcripts.gtf \
  --cache index.cache.txt \
  --align-score 2 \
  --insert-size 400 \
  --fasta transcripts.fa.gz \
  --output sample_name \
  output_dir/fusion.txt
```

## Command Line Best Practices
- **GTF Caching**: Always use the `--cache` flag. The first run will parse the GTF and save it to the cache file; subsequent runs using the same GTF and cache path will start significantly faster.
- **Insert Size**: The `--insert-size` parameter should reflect the maximum expected insert size of your library. While the default is 400, adjusting this to match your specific library preparation improves accuracy.
- **Alignment Score**: The `--align-score` determines the number of mismatches allowed. Increase this value if you expect higher sequencing error rates or significant polymorphism.
- **Protein Coding Filter**: By default, pizzly uses protein-coding information to filter results. If you are interested in non-coding fusions, use `--ignore-protein`, but be prepared for a higher false-positive rate.

## Annotation Requirements
- **Ensembl**: Recommended versions are 75 or later.
- **Gencode**: Requires a preprocessing step to remove pipe symbols (`|`) from the FASTA headers to ensure compatibility with kallisto/pizzly.
  ```bash
  zcat gencode.v26.transcripts.fa.gz | tr '|' ' ' | gzip -1 > gencode.fixed.fa.gz
  ```
- **Consistency**: The FASTA file used for `kallisto index` must be the exact same file provided to the pizzly `--fasta` argument.

## Post-Processing Scripts
Pizzly includes utility scripts in its `scripts/` directory:
- **get_fragment_length.py**: Analyzes the `abundance.h5` from kallisto to determine the 95th percentile of fragment lengths, which can be used to refine the `--insert-size` parameter.
- **flatten_json.py**: Converts the complex `.json` output into a simplified, tab-delimited gene table for easier downstream analysis.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_pmelsted_pizzly.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_pizzly_overview.md)