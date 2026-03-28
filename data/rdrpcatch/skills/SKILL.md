---
name: rdrpcatch
description: RdRpCATCH is a bioinformatic pipeline designed to discover and characterize RNA viruses by searching sequences against multiple profile Hidden Markov Model databases. Use when user asks to identify divergent viral sequences, scan metatranscriptomic data for RdRp signatures, or perform taxonomic assignment of viral hits.
homepage: https://github.com/dimitris-karapliafis/RdRpCATCH
---

# rdrpcatch

## Overview

RdRpCATCH (RNA-dependent RNA polymerase Collaborative Analysis Tool with Collections of pHMMs) is a specialized bioinformatic pipeline designed for the discovery and characterization of RNA viruses. It streamlines the process of searching sequences against an aggregate of major public pHMM databases (such as NeoRdRp, RVMT, and RdRp-Scan). 

The tool is particularly useful for researchers working with metatranscriptomic data who need to identify highly divergent viral sequences that might be missed by standard BLAST searches. It provides a unified output containing the best hits across all databases, taxonomic assignments via MMseqs2, and profile coverage information.

## Installation and Setup

RdRpCATCH is available via Bioconda. It requires Python 3.12+ and external dependencies `mmseqs2` and `seqkit`.

```bash
# Recommended installation via Conda
conda create -n rdrpcatch -c bioconda rdrpcatch
conda activate rdrpcatch
```

### Database Initialization
Before scanning, you must download the pre-compiled pHMM and taxonomy databases. These are approximately 3GB.

```bash
rdrpcatch databases --destination-dir path/to/db_folder
```
*Note: If you encounter sporadic SSL errors during download, re-initiating the command usually resolves the issue.*

## Core CLI Usage

### Basic Scanning
The `scan` command is the primary entry point for analysis. It accepts both nucleotide (nt) and amino acid (aa) sequences in multi-FASTA format.

```bash
rdrpcatch scan -i input.fasta -o output_dir -db-dir path/to/db_folder
```

### Database Selection
By default, RdRpCATCH searches all supported databases. You can limit the search to specific collections using `--db-options`.

**Supported Database Keys:**
- `NeoRdRp` / `NeoRdRp2`
- `RVMT`
- `RdRp-Scan`
- `Olendraite_fam` / `Olendraite_gen`
- `LucaProt_HMM`
- `Zayed_HMM`

```bash
# Example: Search only NeoRdRp2 and RVMT
rdrpcatch scan -i input.fasta -o out -db-dir db/ --db-options NeoRdRp2 RVMT
```

### Working with Custom Databases
You can integrate your own pHMMs into the workflow.

1. **Add the database:**
   ```bash
   rdrpcatch databases --add-custom-db path/to/my_models.hmm --db-name MyCustomDB
   ```
2. **Search only custom models:**
   ```bash
   rdrpcatch scan -i input.fasta -o out -db-dir db/ --db-options none --custom-dbs MyCustomDB
   ```

## Expert Tips and Best Practices

### Sensitivity and Thresholds
- **Default HMMER Params:** Use the `--default-hmmsearch-params` flag to override tool-specific heuristics and use standard HMMER thresholds (E=10.0, domE=10.0). This is useful for maximum sensitivity when looking for extremely divergent viruses.
- **Z-Value:** Use `--zvalue` to manually set the search space size for E-value calculations if you are comparing results across different dataset sizes.

### Output Optimization
- **Extended Output:** Always use the `--extended-output` flag if you plan to perform downstream statistical filtering, as it preserves additional HMM score columns that are otherwise truncated.
- **Taxonomy:** If you have a specific local taxonomy database, use `--alt-mmseqs-tax-db` to point to a custom MMseqs2-formatted database instead of the default RefSeq Riboviria set.

### Performance
- RdRpCATCH uses `pyHMMER`, which is significantly faster than standard HMMER3. However, for very large metatranscriptomes, ensure you have sufficient RAM (at least 8GB-16GB) to load the larger pHMM collections like NeoRdRp2.



## Subcommands

| Command | Description |
|---------|-------------|
| rdrpcatch databases | Download & update RdRpCATCH databases. If databases are already installed in the specified directory, it will check for updates and download the latest version if available. |
| rdrpcatch_scan | Scan sequences for RdRps. |

## Reference documentation
- [RdRpCATCH README](./references/github_com_dimitris-karapliafis_RdRpCATCH_blob_main_README.md)
- [Bioconda Package Metadata](./references/github_com_dimitris-karapliafis_RdRpCATCH_blob_main_meta.yaml.md)