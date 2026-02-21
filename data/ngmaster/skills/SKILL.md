---
name: ngmaster
description: ngmaster is a specialized bioinformatic tool for the rapid characterization of Neisseria gonorrhoeae isolates.
homepage: https://github.com/MDU-PHL/ngmaster
---

# ngmaster

## Overview

ngmaster is a specialized bioinformatic tool for the rapid characterization of Neisseria gonorrhoeae isolates. It automates the identification of alleles for both the NG-MAST and NG-STAR schemes directly from genomic assemblies or sequence data in FASTA format. By integrating these two major typing schemes, it allows researchers and clinicians to perform epidemiological surveillance and monitor antimicrobial resistance markers simultaneously.

## Usage Patterns

### Basic Typing
To perform NG-MAST and NG-STAR typing on one or more FASTA files:
```bash
ngmaster sample1.fasta sample2.fasta
```
The results are printed to stdout in a tab-separated format by default.

### Output Formatting
For easier integration with spreadsheet software, use the CSV flag:
```bash
ngmaster --csv samples/*.fasta > typing_results.csv
```

### Database Management
The tool relies on allele databases from PubMLST. It is a best practice to update these before a new analysis:
```bash
ngmaster --updatedb
```
To use a specific version of a database or a custom directory:
```bash
ngmaster --db /path/to/custom_db_dir/ sample.fasta
```

### Extracting Allele Sequences
If you identify novel or interesting alleles and need to save the sequences (e.g., for manual submission to PubMLST):
```bash
ngmaster --printseq output_prefix sample.fasta
```
This generates two files: `NGMAST__output_prefix` and `NGSTAR__output_prefix`.

## Expert Tips

- **Handling Low Quality Assemblies**: If working with fragmented assemblies, adjust the coverage and identity thresholds. The defaults are typically strict (100% identity for exact matches).
  - `--minid [MINID]`: Set the minimum DNA percent identity (default is ~95% for "similar" alleles).
  - `--mincov [MINCOV]`: Set the minimum DNA percent coverage to report a partial match.
- **Resistance Context**: When running NG-STAR typing, always use the `--comments` flag to include descriptive information about the specific resistance mutations associated with the identified alleles.
- **Verification**: Run `ngmaster --test` after installation or database updates to ensure the environment and allele calling logic are functioning correctly.
- **Allele Symbols**:
  - `n`: Exact match (100% ID, 100% Cov).
  - `~n`: Novel full-length allele similar to `n`.
  - `n?`: Partial match to known allele.
  - `-`: Allele missing or below thresholds.

## Reference documentation
- [ngmaster GitHub README](./references/github_com_MDU-PHL_ngmaster.md)
- [ngmaster Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ngmaster_overview.md)