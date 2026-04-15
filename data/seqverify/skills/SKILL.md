---
name: seqverify
description: SeqVerify is a pipeline designed to verify gene edits by identifying insertion sites, assessing genomic integrity, and detecting unintended integrations. Use when user asks to detect transgene integration, perform copy number variation analysis, screen for bacterial contamination, or call and filter variants.
homepage: https://github.com/mpiersonsmela/SeqVerify
metadata:
  docker_image: "quay.io/biocontainers/seqverify:1.3.0--hdfd78af_0"
---

# seqverify

## Overview
SeqVerify is a specialized pipeline designed to provide a comprehensive "readout" of a gene-edited sample. It automates the complex process of verifying whether an edit occurred at the intended location, identifying unintended insertion sites, and assessing the genomic integrity of the sample. 

Use this skill to:
- Detect where transgenes or plasmids have integrated into a genome.
- Perform Copy Number Variation (CNV) analysis to identify duplications or deletions.
- Screen for bacterial contamination using Kraken2.
- Call and filter variants (SNVs/Indels) to check for off-target effects or mutations.

## Installation
The tool is available via Bioconda:
```bash
conda install -c bioconda seqverify
```

## Core Command Structure
A standard SeqVerify execution requires paired-end reads, a reference genome, and the sequences of the markers you are looking for.

```bash
seqverify --output Sample_Name \
  --reads_1 sample_R1.fastq.gz \
  --reads_2 sample_R2.fastq.gz \
  --genome reference.fa \
  --untargeted transgenes.fa \
  --targeted insertion_commands.txt
```

### Key Arguments
- `--output`: Sets the prefix for the output directory (e.g., `Sample_Name_seqverify`).
- `--untargeted`: Use this for "discovery" mode. Provide FASTA files of plasmids or transgenes to find where they might have integrated randomly.
- `--targeted`: Use this when you have a specific expected insertion site. Requires a command file defining the intended edit.
- `--genome`: The reference FASTA. Defaults to CHM13v2.0 if not specified.

## Advanced Workflow Patterns

### Resuming or Skipping Steps
Use the `--start` flag to optimize resource usage or resume a failed run:
- `beginning`: Pre-processing only (single-core).
- `align`: Starts at alignment (multi-core).
- `markers`: Skips to insertion site detection.
- `cnv`: Skips to CNV analysis.
- `kraken`: Runs only microbial contamination analysis (requires `--kraken`).
- `variant`: Runs only variant calling (requires `--variant_calling`).

### Microbial Contamination (Kraken2)
To check for bacterial or viral contamination, you must explicitly enable the module:
```bash
seqverify --kraken --database /path/to/kraken_db [other_args]
```

### Variant Calling and Annotation
To identify SNVs/Indels, provide a compatible genome and an annotation database (e.g., ClinVar):
```bash
seqverify --variant_calling hg38 /path/to/clinvar.vcf.gz --variant_intensity MODERATE
```
*Note: Intensity levels include MODIFIER, LOW, MODERATE, and HIGH.*

## Expert Tips and Best Practices

### Memory and Performance
- **Memory Indexing**: If working on a memory-constrained system, use `--max_mem` (e.g., `--max_mem 8G`) to limit the memory used during genome indexing.
- **Threading**: Always specify `--threads` to match your environment, as the default is 1.

### Tuning Detection Sensitivity
- **Insertion Granularity**: If you are seeing too many distinct insertion sites that are actually the same event, increase `--granularity` (default 500bp).
- **False Positive Filtering**: Increase `--min_matches` (default 1) to filter out low-confidence insertion sites caused by repetitive DNA.
- **CNV Resolution**: For higher resolution CNV detection in high-coverage data, decrease `--bin_size` from the default 100,000bp.

### Mitochondrial Analysis
If you suspect insertions into the mitochondrial genome, use the `--mitochondrial` flag. This enables specific detection logic for `chrM`.

## Reference documentation
- [SeqVerify GitHub README](./references/github_com_mpiersonsmela_SeqVerify_blob_main_README.md)
- [Bioconda SeqVerify Overview](./references/anaconda_org_channels_bioconda_packages_seqverify_overview.md)