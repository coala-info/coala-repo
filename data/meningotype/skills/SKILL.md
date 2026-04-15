---
name: meningotype
description: meningotype performs rapid characterization of Neisseria meningitidis isolates by predicting serogroups and identifying antigen variants from genomic data. Use when user asks to predict serogroups, perform finetyping, determine MLST, or assess vaccine coverage using the MenDeVAR index.
homepage: https://github.com/MDU-PHL/meningotype
metadata:
  docker_image: "quay.io/biocontainers/meningotype:0.8.5--pyhdfd78af_1"
---

# meningotype

## Overview
The `meningotype` skill enables the rapid characterization of *Neisseria meningitidis* isolates using whole-genome sequencing (WGS) data. It automates the detection of capsule biosynthesis genes to predict serogroups (A, B, C, W, X, Y) and compares antigen sequences against the PubMLST database for high-resolution finetyping. This tool is essential for epidemiological surveillance, outbreak investigation, and assessing potential vaccine coverage (Bexsero/Trumenba) via the MenDeVAR index.

## Installation and Environment
The tool is best managed via Conda to ensure all binary dependencies (isPcr, BLAST+, mlst) are correctly linked.

```bash
# Install via bioconda
conda install -c bioconda meningotype

# Verify environment and dependencies
meningotype --checkdeps
```

## Common CLI Patterns

### Basic Serotyping
To predict the serogroup and detect the `ctrA` gene (capsule locus) for one or more FASTA files:
```bash
meningotype *.fna
```

### Comprehensive Typing
To perform a full analysis including MLST, PorA, FetA, PorB, BAST, and the MenDeVAR index:
```bash
meningotype --all *.fna
```

### Targeted Finetyping
If only the outer membrane protein variants (PorA and FetA) are required for short-term surveillance:
```bash
meningotype --finetype sample.fasta
```

### Exporting Allele Sequences
To extract the actual nucleotide or amino acid sequences of the identified alleles (useful for submitting new variants to PubMLST):
```bash
meningotype --all --printseq sequences_output/ *.fna
```

## Expert Tips and Best Practices

- **Database Maintenance**: Allele definitions for *N. meningitidis* change frequently. Always run `meningotype --updatedb` before starting a new project to ensure your results match the latest PubMLST nomenclature.
- **Interpreting MenDeVAR**: The MenDeVAR index provides a color-coded reactivity prediction:
    - **Green (Exact match)**: High confidence in vaccine reactivity.
    - **Amber (Cross-reactive)**: Likely reactive based on experimental data.
    - **Red (No match)**: Likely not covered by the vaccine.
    - **Insufficient data**: Occurs when alleles are novel or not present in the reactivity database.
- **Output Handling**: The tool outputs tab-separated values (TSV) to `stdout`. For large batches, always redirect to a file: `meningotype --all *.fna > typing_results.tsv`.
- **Performance**: Use the `--cpus` flag to speed up BLAST searches when processing hundreds of genomes: `meningotype --all --cpus 8 *.fna`.
- **Input Quality**: Ensure your FASTA files contain contigs or scaffolds. While the tool can run on raw reads if they are formatted as FASTA, it is designed and validated for assembled genomic data.

## Reference documentation
- [Meningotype GitHub Repository](./references/github_com_MDU-PHL_meningotype.md)
- [Meningotype Wiki and Interpretation Guide](./references/github_com_MDU-PHL_meningotype_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_meningotype_overview.md)