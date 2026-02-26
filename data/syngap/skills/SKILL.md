---
name: syngap
description: SynGAP refines gene models and analyzes evolutionary transcriptomics by leveraging synteny and conservation between related species. Use when user asks to polish genome annotations, identify homologous gene pairs, or calculate expression variation across species.
homepage: https://github.com/yanyew/SynGAP
---


# syngap

## Overview

SynGAP (Synteny-based Gene structure Annotation Polisher) is a specialized toolkit designed to refine gene models by leveraging evolutionary conservation between related organisms. It addresses common issues in genome annotation, such as missing or mis-annotated genes, by using syntenic blocks to guide the polishing process. Beyond annotation, it provides workflows for cross-species transcriptomic analysis, allowing researchers to identify high-confidence homologous gene pairs and calculate expression variation across time-series data.

## Tool-Specific Best Practices

### Genome Annotation Polishing
SynGAP offers four primary modes for polishing annotations. Choose the mode based on the number of species and the quality of available references:

*   **Dual Polishing (`dual`)**: Use for mutual correction between two related species. This is the most common workflow when both species have similar assembly quality.
*   **Master Polishing (`master`)**: Use to polish a target species using a high-quality reference "Core set" provided by the SynGAP database. You must run `initdb` before using this mode.
*   **Triple Polishing (`triple`)**: Use for a three-way combination to maximize the detection of conserved gene structures.
*   **Custom Polishing (`custom`)**: Use if you prefer to provide your own synteny results (e.g., `.anchors` files from JCVI or other software) rather than letting SynGAP compute them.

### Expression Variation Analysis
For evolutionary transcriptomics, follow the sequential workflow:
1.  **`genepair`**: Combines synteny and best two-way BLAST to generate high-confidence homologous pairs.
2.  **`evi`**: Calculates the Expression Variation Index. Use TPM (Transcripts Per Million) as the input unit for normalized expression values to ensure consistency.

## Common CLI Patterns

### Initializing the Master Database
Before running the `master` workflow, download the required plant or animal database and initialize it:
```bash
syngap initdb --sp=plant --file=plant.tar.gz
```

### Running Dual Polishing
Provide FASTA and GFF3 files for both species. Use short, unique identifiers for `--sp1` and `--sp2`:
```bash
syngap dual \
  --sp1fa=species1.fa \
  --sp1gff=species1.gff3 \
  --sp2fa=species2.fa \
  --sp2gff=species2.gff3 \
  --sp1=S1 \
  --sp2=S2
```

### Calculating EVI
Ensure the gene pair file matches the expression files. The expression files should be tab-delimited:
```bash
syngap evi \
  --genepair=S1.S2.final.genepair \
  --sp1exp=S1_expression.tpm.xls \
  --sp2exp=S2_expression.tpm.xls
```

## Expert Tips

*   **Output Selection**: SynGAP generates multiple GFF3 files. 
    *   Use `*.SynGAP.gff3` for a complete annotation containing both original and polished models.
    *   Use `*.SynGAP.clean.gff3` if you only need the newly predicted/corrected models.
*   **Input Consistency**: Ensure that the sequence IDs in your FASTA files exactly match the chromosome/scaffold IDs in the GFF3 files. Discrepancies will cause the synteny mapping to fail.
*   **Resource Management**: For large genomes, SynGAP's dependency on `jcvi` and `last` can be memory-intensive. Ensure your environment has sufficient RAM when running `dual` or `triple` workflows.
*   **Environment Setup**: It is highly recommended to use the Conda installation (`bioconda::syngap`) to manage the complex list of dependencies (Biopython, JCVI, Bedtools, LAST, etc.) automatically.

## Reference documentation
- [SynGAP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_syngap_overview.md)
- [SynGAP GitHub Repository](./references/github_com_yanyew_SynGAP.md)