---
name: pysradb
description: pysradb is a toolkit for retrieving metadata and raw data from genomic repositories like SRA, ENA, and GEO. Use when user asks to fetch experimental metadata, convert accession IDs between GEO and SRA, search for genomic projects, or download sequencing data.
homepage: https://github.com/saketkc/pysradb
---


# pysradb

## Overview

pysradb is a specialized toolkit designed to simplify the retrieval of metadata and raw data from major genomic repositories including the Sequence Read Archive (SRA), European Nucleotide Archive (ENA), and Gene Expression Omnibus (GEO). It provides a unified command-line interface to resolve accession IDs across these databases—mapping GEO Series (GSE) or Samples (GSM) to SRA Projects (SRP) or Runs (SRR)—and gathering comprehensive experimental metadata for downstream bioinformatics analysis.

## Common CLI Patterns

### Metadata Retrieval
Fetch all metadata associated with an SRA project:
```bash
pysradb metadata SRP000001
```

To get more detailed information including sample attributes:
```bash
pysradb metadata --detailed SRP000001
```

### Accession Conversions
pysradb excels at mapping identifiers between GEO and SRA:

*   **GEO Series to SRA Project:** `pysradb gse-to-srp GSE12345`
*   **GEO Sample to SRA Run:** `pysradb gsm-to-srr GSM12345`
*   **SRA Project to SRA Run:** `pysradb srp-to-srr SRP12345`
*   **SRA Run to GEO Sample:** `pysradb srr-to-gsm SRR12345`

### Searching the Archive
Search for projects or samples based on specific text queries:
```bash
pysradb search "human liver RNA-seq"
```

### Downloading Data
Download all runs associated with a project:
```bash
pysradb download -p SRP000001
```

Download specific runs:
```bash
pysradb download -r SRR000001 -r SRR000002
```

### Literature Mapping
Find genomic accessions associated with PubMed IDs or DOIs:
*   **PMID to SRA Project:** `pysradb pmid-to-srp 12345678`
*   **DOI to GEO Series:** `pysradb doi-to-gse 10.1038/s41588-018-0147-x`

## Expert Tips

*   **Output Redirection:** Most commands output TSV data by default. Use standard shell redirection (`> output.tsv`) to save results for use in R or Python.
*   **Batch Processing:** For multiple accessions, you can often pass them as a space-separated list or use a loop in bash to process a file of IDs.
*   **GEO Matrix Files:** Use `pysradb geo-matrix GSEnnnnn` to specifically handle the download and parsing of GEO series matrix files, which contain processed expression data.
*   **ENA as Alternative:** If NCBI SRA is slow, pysradb often utilizes ENA's API for metadata, which can be more responsive for certain queries.



## Subcommands

| Command | Description |
|---------|-------------|
| doi-to-gse | Convert DOI(s) to GSE accession(s) |
| doi-to-srp | Convert DOI(s) to SRP accession(s) |
| gse-to-gsm | Convert GSE accession IDs to GSM accession IDs |
| gsm-to-gse | Convert GSM IDs to GSE IDs. |
| gsm-to-srp | Convert GSM IDs to SRP IDs |
| gsm-to-srr | Convert GSM IDs to SRR IDs |
| gsm-to-srs | Convert GSM IDs to SRS IDs |
| gsm-to-srx | Convert GSM IDs to SRX IDs. |
| pmid-to-gse | Convert PMID(s) to GSE accession(s) |
| pmid-to-identifiers | Convert PMID(s) to SRA accession(s) and Experiment accession(s) |
| pmid-to-srp | Convert PMID(s) to SRP accession(s) |
| pysradb | Query NGS metadata and data from NCBI Sequence Read Archive. |
| pysradb doi-to-identifiers | Convert DOI(s) to SRA/GEO identifiers. |
| pysradb geo-matrix | Generates a matrix from GEO accession data. |
| pysradb gse-to-pmid | Convert GSE accession(s) to PMID(s) |
| pysradb gse-to-srp | Convert GSE accession IDs to SRP accession IDs |
| pysradb metadata | Retrieve metadata for given SRP IDs. |
| pysradb pmc-to-identifiers | Convert PMC IDs to accession identifiers. |
| pysradb search | Search for data in SRA, ENA, or GEO databases. |
| pysradb srp-to-gse | Convert SRP accession to GSE accession |
| pysradb_download | Download SRA data. Accepts a list of accession IDs from stdin or a file. |
| srp-to-pmid | Convert SRP accession(s) to PMID(s) |
| srp-to-srr | Convert SRP accession to SRR accessions |
| srp-to-srs | Convert SRP accession to SRS accession |
| srp-to-srx | Convert SRP accession to SRX accession |
| srr-to-gsm | Convert SRR IDs to GSM IDs |
| srr-to-srp | Convert SRR IDs to SRP IDs |
| srr-to-srs | Convert SRR IDs to SRS IDs |
| srr-to-srx | Convert SRR IDs to SRX IDs. |
| srs-to-gsm | Convert SRS IDs to GSM IDs |
| srs-to-srx | Convert SRS IDs to SRX IDs |
| srx-to-srp | Convert SRX IDs to SRP IDs |
| srx-to-srr | Convert SRX IDs to SRR IDs |
| srx-to-srs | Convert SRX IDs to SRS IDs |

## Reference documentation
- [pysradb README](./references/github_com_saketkc_pysradb_blob_develop_README.md)
- [pysradb CLI Instructions](./references/saket-choudhary_me_pysradb_cmdline.html.md)
- [pysradb Quickstart Guide](./references/saket-choudhary_me_pysradb_quickstart.html.md)