---
name: jcast
description: JCAST (Junction Centric Alternative Splicing Translator) is a specialized tool designed to bridge the gap between transcriptomics and proteomics.
homepage: https://github.com/ed-lau/jcast
---

# jcast

## Overview
JCAST (Junction Centric Alternative Splicing Translator) is a specialized tool designed to bridge the gap between transcriptomics and proteomics. It processes alternative splicing events—specifically those identified by rMATS—and translates them into amino acid sequences. By integrating splice junction data with genomic references, it allows researchers to create custom protein databases that include specific isoforms, which is essential for accurate isoform-level proteomics and sequence analysis.

## Installation and Setup
JCAST can be installed via pip or conda:

```bash
# Via pip
pip install jcast

# Via Bioconda
conda install bioconda::jcast
```

## Command Line Usage
The basic syntax for JCAST requires three positional arguments: the rMATS output directory, the GTF annotation file, and the genome FASTA file.

```bash
jcast [options] <rmats_folder> <gtf_file> <genome_fasta>
```

### Common CLI Patterns

**Standard Execution**
Run JCAST with default settings, outputting to a specific project name:
```bash
jcast data/rmats_results/ data/hg38.gtf data/hg38.fa -o my_isoform_study
```

**Strict Filtering**
Filter for high-confidence junctions using q-value (FDR) thresholds and minimum read counts:
```bash
# Only include junctions with FDR between 0 and 0.05 and at least 10 reads
jcast data/rmats/ data/ref.gtf data/ref.fa -q 0 0.05 -r 10
```

**Automated Modeling**
Use a Gaussian mixture model to automatically determine the junction read count cutoff instead of a fixed integer:
```bash
jcast data/rmats/ data/ref.gtf data/ref.fa -m
```

**Canonical Fallback**
Ensure that canonical protein sequences are written to the output even if the specific transcript slice is untranslatable:
```bash
jcast data/rmats/ data/ref.gtf data/ref.fa -c
```

## Expert Tips and Best Practices

*   **Genome Selection**: Always use an **unmasked genome** file. JCAST currently cannot handle masked nucleotides (represented as `N`) and will fail if they are encountered in the sequence.
*   **Data Cleaning**: Pre-process rMATS output to ensure there are no rows containing `NA` as a gene name, as this is a known cause of execution failure.
*   **Memory Management**: For large datasets (e.g., whole-genome human rMATS outputs), ensure the environment has sufficient RAM for `gtfparse` to load the annotation file into memory.
*   **Output Interpretation**: The tool generates `.psq` (protein sequence) files. If using the `-c` flag, the output will be more comprehensive for comparative proteomics but will include sequences that may not have direct evidence of translation for that specific junction.

## Reference documentation
- [jcast GitHub Repository](./references/github_com_ed-lau_jcast.md)
- [jcast Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_jcast_overview.md)