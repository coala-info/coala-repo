---
name: rdrpcatch
description: RdRpCATCH (RNA-dependent RNA polymerase Collaborative Analysis Tool with Collections of pHMMs) is a specialized bioinformatic pipeline for the discovery and annotation of RNA viruses.
homepage: https://github.com/dimitris-karapliafis/RdRpCATCH
---

# rdrpcatch

## Overview

RdRpCATCH (RNA-dependent RNA polymerase Collaborative Analysis Tool with Collections of pHMMs) is a specialized bioinformatic pipeline for the discovery and annotation of RNA viruses. It consolidates multiple publicly available RdRp profile HMM (pHMM) databases into a single workflow, using pyHMMER3 for sequence searching and MMseqs2 for taxonomic classification against a custom Riboviria database. It is particularly effective for identifying divergent viral sequences in metagenomic or metatranscriptomic datasets by reporting the best hit across all included databases based on bitscore.

## Database Management

Before running scans, you must download the required pHMM databases. These files are large (~3 GB).

```bash
# Download and initialize databases
rdrpcatch databases --destination-dir /path/to/database_folder
```

If the automated download fails due to SSL issues, manually download the pre-compiled databases from Zenodo (10.5281/zenodo.15463729) and extract them.

## Common CLI Patterns

### Basic Sequence Scanning
The tool accepts both nucleotide (nt) and protein (aa) sequences in multi-fasta format.

```bash
# Scan protein sequences
rdrpcatch scan -i input.faa -o results_dir -db-dir /path/to/database_folder --seq-type aa

# Scan nucleotide sequences
rdrpcatch scan -i input.fna -o results_dir -db-dir /path/to/database_folder --seq-type nt
```

### Selecting Specific Databases
You can limit the search to specific pHMM collections using the `--db-options` flag. Supported databases include: `NeoRdRp`, `NeoRdRp2`, `RVMT`, `RdRp-Scan`, `TSA_Olendraite_fam`, `TSA_Olendraite_gen`, `LucaProt_HMM`, and `Zayed_HMM`.

```bash
# Search only against NeoRdRp2 and RVMT
rdrpcatch scan -i input.faa -o results_dir -db-dir /path/to/db --db-options NeoRdRp2 RVMT
```

### Using Custom pHMMs
To include your own pHMM files in the analysis:

1. Add the custom database to the RdRpCATCH environment:
   ```bash
   rdrpcatch databases --add-custom-db /path/to/my_models.hmm --db-name my_custom_db
   ```
2. Run the scan including the custom database:
   ```bash
   rdrpcatch scan -i input.faa -o results_dir -db-dir /path/to/db --custom-dbs my_custom_db
   ```

## Expert Tips and Best Practices

*   **Default HMMER Thresholds**: Use the `--default-hmmsearch-params` flag to override tool-specific heuristics and use standard HMMER thresholds (E=10.0, domE=10.0). This is useful for highly sensitive searches for extremely divergent viruses.
*   **Extended Output**: Use the `--extended-output` flag to retain additional HMM score columns in the final results, which is helpful for manual validation of borderline hits.
*   **Taxonomy Overrides**: If you have a specific MMseqs2 taxonomy database you prefer, use `--alt-mmseqs-tax-db` to point to the path of your pressed MMseqs2 database.
*   **Sequence Type**: While the tool can attempt to auto-detect sequence type, explicitly setting `--seq-type` (aa or nt) prevents errors in ambiguous metagenomic assemblies.
*   **Bitscore Priority**: RdRpCATCH identifies the "best hit" by comparing bitscores across all selected databases. If a sequence matches multiple profiles, the output will prioritize the one with the highest statistical support.

## Reference documentation
- [RdRpCATCH GitHub Repository](./references/github_com_dimitris-karapliafis_RdRpCATCH.md)
- [Bioconda rdrpcatch Overview](./references/anaconda_org_channels_bioconda_packages_rdrpcatch_overview.md)