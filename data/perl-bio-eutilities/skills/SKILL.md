---
name: perl-bio-eutilities
description: This tool provides a collection of Perl scripts to interface with the NCBI eUtils API for high-throughput biological data retrieval. Use when user asks to search NCBI databases, download sequences or citations in batch, link records between databases, or automate workflows involving the NCBI history server.
homepage: https://metacpan.org/release/Bio-EUtilities
---


# perl-bio-eutilities

## Overview
This skill provides guidance for using the `Bio-EUtilities` suite, a collection of Perl scripts designed to interface with the NCBI eUtils API. It allows for high-throughput retrieval of biological data, including sequences, taxonomy, and citations. Use these tools to automate NCBI workflows such as converting GI numbers to Accession numbers, downloading large batches of FASTA files, or searching for specific publications.

## Common CLI Patterns

The package provides several core scripts (prefixed with `bp_`) that map to specific NCBI E-utilities functions.

### Searching and Fetching (eSearch & eFetch)
Use `bp_esearch.pl` to find UIDs and `bp_efetch.pl` to retrieve the actual data.

```bash
# Search PubMed for a topic and pipe to fetch for full XML records
bp_esearch.pl -db pubmed -query "CRISPR AND 2023[pdat]" | bp_efetch.pl -db pubmed -format xml > results.xml

# Fetch protein sequences in FASTA format using a list of accessions
bp_efetch.pl -db protein -id P12345,P67890 -format fasta
```

### Linking Databases (eLink)
Use `bp_elink.pl` to find related records in different NCBI databases (e.g., finding protein sequences associated with a nucleotide record).

```bash
# Find protein records linked to a specific nucleotide ID
bp_elink.pl -dbfrom nuccore -db protein -id 1234567
```

### Handling Large ID Lists (ePost)
For large sets of IDs, use `bp_epost.pl` to upload them to the NCBI history server first, then reference them in subsequent commands to avoid URI length limits.

```bash
# Post IDs from a file and use the resulting WebEnv/QueryKey for fetching
bp_epost.pl -db nuccore -idfile ids.txt | bp_efetch.pl -format gb > sequences.gb
```

## Expert Tips
- **API Keys**: To avoid rate limiting (3 requests/sec vs 10 requests/sec), set the `NCBI_API_KEY` environment variable before running scripts.
- **Format Selection**: Always verify the valid `-format` and `-mode` combinations for the specific database you are querying (e.g., `gp` for GenPept, `medline` for PubMed).
- **Batching**: When dealing with thousands of records, use the `-batch` option if available or split ID lists to prevent connection timeouts.
- **Data Parsing**: The output of these scripts is often raw XML or flatfiles; pipe the output to `BioPerl` parsers or standard Unix tools like `grep` and `awk` for quick extraction.

## Reference documentation
- [Bio-EUtilities Release Info](./references/metacpan_org_release_Bio-EUtilities.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-eutilities_overview.md)