---
name: padloc
description: PADLOC (Prokaryotic Antiviral Defence LOCator) is a specialized bioinformatics tool designed to detect and annotate antiviral defense systems within prokaryotic genomic data.
homepage: https://github.com/padlocbio/padloc
---

# padloc

## Overview
PADLOC (Prokaryotic Antiviral Defence LOCator) is a specialized bioinformatics tool designed to detect and annotate antiviral defense systems within prokaryotic genomic data. It functions by comparing input sequences against a curated database of HMMs and system classifications. This skill enables the execution of the PADLOC pipeline, management of its underlying database, and interpretation of the resulting defense system maps.

## Installation and Initialization
Before running analyses, ensure the environment is set up and the database is current.

*   **Update Database**: PADLOC requires a local HMM database. Always run this before a new project to ensure you have the latest system models.
    ```bash
    padloc --db-update
    ```
*   **Check Dependencies**: Verify that HMMER and other required tools are in the path.
    ```bash
    padloc --check-deps
    ```

## Common CLI Patterns

### Basic Analysis
The most common workflow involves providing a protein FASTA file (`.faa`) and a corresponding annotation file (`.gff`).
```bash
padloc --faa genome.faa --gff features.gff
```

### Nucleic Acid Input
If starting from raw genomic sequences without pre-computed annotations:
```bash
padloc --fna genome.fna
```

### Performance and Output Management
For large-scale genomic datasets, utilize multi-threading and specify output locations to keep workspaces organized.
```bash
padloc --faa genome.faa --gff features.gff --cpu 8 --outdir ./defense_results
```

### Advanced Detection (CRISPR & ncRNA)
To increase sensitivity for systems involving non-coding elements, provide pre-computed CRISPR and ncRNA data.
```bash
padloc --faa genome.faa --gff features.gff --ncrna genome.ncrna --crispr genome.crispr
```

## Expert Tips and Best Practices

### Input Compatibility
*   **ID Matching**: Ensure that the IDs in your `.faa` file match the `ID` or `cds-ID` attributes in your `.gff` file. PADLOC is optimized for outputs from NCBI (RefSeq/GenBank), JGI (IMG), and Prokka.
*   **Prodigal Fix**: If using FAA/GFF files generated specifically by Prodigal, use the `--fix-prodigal` flag to force sequence ID synchronization.
    ```bash
    padloc --faa prodigal.faa --gff prodigal.gff --fix-prodigal
    ```

### Database Versioning
*   **Compatibility Warning**: PADLOC versions >2.0.0 are only compatible with PADLOC-DB versions >2.0.0. If you update the software, you must update the database immediately using `padloc --db-update`.

### Interpreting Results
*   **Primary Output**: Focus on the `_padloc.csv` file.
*   **Significance**: Use the `domain.iE.value` as the primary filter for putative hits. A lower E-value indicates higher statistical significance.
*   **Coverage**: Check `target.coverage` and `hmm.coverage`. High coverage of both the target protein and the HMM model suggests a high-confidence functional hit rather than a remote or partial homolog.

## Reference documentation
- [PADLOC Main Documentation](./references/github_com_padlocbio_padloc.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_padloc_overview.md)