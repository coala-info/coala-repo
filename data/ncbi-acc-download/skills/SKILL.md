---
name: ncbi-acc-download
description: `ncbi-acc-download` is a specialized command-line utility designed to retrieve sequence data directly from the NCBI Entrez API using unique accession identifiers.
homepage: https://github.com/kblin/ncbi-acc-download/
---

# ncbi-acc-download

## Overview
`ncbi-acc-download` is a specialized command-line utility designed to retrieve sequence data directly from the NCBI Entrez API using unique accession identifiers. While other tools focus on downloading entire genomes based on taxonomic metadata, this tool provides surgical precision for fetching specific records. It allows for fine-grained control over the molecule type, file format, and coordinate ranges, making it an essential tool for targeted bioinformatic data acquisition.

## Basic Usage
The tool's primary function is to fetch a record by its accession number. By default, it downloads nucleotide records in GenBank format.

- **Download a nucleotide record (GenBank):**
  `ncbi-acc-download AB_12345`

- **Download in FASTA format:**
  `ncbi-acc-download --format fasta AB_12345`

- **Download a protein record:**
  `ncbi-acc-download --molecule protein WP_12345`

## Advanced CLI Patterns

### Genomic Range Extraction
You can download a specific slice of a large record. When doing so, it is best practice to use the extended validator to clean up partial features created by the cut.
`ncbi-acc-download NC_007194 --range 1001:9000 --extended-validation correct`

### Recursive WGS Downloads
If you provide a Whole Genome Shotgun (WGS) master record accession, use the recursive flag to download all associated records instead of just the master record.
`ncbi-acc-download --recursive NZ_EXMP01000000`

### Batch Processing and Concatenation
To combine multiple accessions into a single output file:
`ncbi-acc-download --out multi_sequence.gbk AB_12345 AB_23456`

### Piping to Downstream Tools
Use `/dev/stdout` to stream data directly into other commands (e.g., compression or alignment tools):
`ncbi-acc-download --out /dev/stdout --format fasta AB_12345 | gzip > sequence.fa.gz`

## Expert Tips

- **Avoid Rate Limiting:** If you are performing many downloads, provide an NCBI API key to increase your request limit.
  `ncbi-acc-download --api-key YOUR_NCBI_API_KEY AB_12345`
- **Handling 429 Errors:** The tool has built-in logic to detect "Too Many Requests" (HTTP 429) errors and will automatically wait for the period requested by the NCBI server before retrying.
- **Format Options:** Beyond GenBank and FASTA, the tool supports `gff3` and `featuretable` for nucleotide downloads.
- **URL Generation:** If you need to perform the actual download on a different machine (e.g., a cluster node without external API access), use the `--url` flag to generate a list of direct download links.

## Reference documentation
- [github_com_kblin_ncbi-acc-download.md](./references/github_com_kblin_ncbi-acc-download.md)
- [github_com_kblin_ncbi-acc-download_tags.md](./references/github_com_kblin_ncbi-acc-download_tags.md)