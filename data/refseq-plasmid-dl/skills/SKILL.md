---
name: refseq-plasmid-dl
description: Downloads, filters, and curates plasmid sequences from the NCBI RefSeq database. Use when user asks to download plasmid DNA sequences with specific metadata or sequence property criteria, and generate associated reports and metadata files.
homepage: https://github.com/erinyoung/refseq-plasmid-dl
metadata:
  docker_image: "quay.io/biocontainers/refseq-plasmid-dl:0.1.0--pyhdfd78af_0"
---

# refseq-plasmid-dl

Downloads, filters, and curates plasmid sequences from the NCBI RefSeq database.
  Use this skill when you need to programmatically obtain plasmid DNA sequences with specific metadata or sequence property criteria, and generate associated reports and metadata files.
---
## Overview

This tool is designed to streamline the process of acquiring plasmid sequences from NCBI's RefSeq database. It allows users to download raw sequence and annotation files, extract relevant metadata, and then filter these sequences based on a wide range of criteria such as organism, taxonomy ID, sequence length, and topology. The output includes a curated multi-FASTA file, a detailed metadata CSV, and a summary report.

## Usage Instructions

The primary command for this tool is `refseq-plasmid-dl`.

### Basic Download and Report

To download all available RefSeq plasmids and generate the default metadata and report files:

```bash
refseq-plasmid-dl
```

This command will create an output directory (defaulting to `refseq_plasmids`) containing the downloaded files, the curated FASTA, the metadata CSV, and a summary report.

### Filtering and Customization

You can specify various filters and output options to tailor your download.

**Key Arguments:**

*   `--outdir <directory>` or `-o <directory>`: Specifies the output directory for all generated files.
    *   Example: `refseq-plasmid-dl -o my_plasmid_data`
*   `--indir <directory>`: Use an existing download directory to skip the FTP/HTTPS download step and re-apply filtering and reporting. This is useful for reprocessing data with new criteria.
    *   Example: `refseq-plasmid-dl --indir downloaded_sequences --organism Escherichia --topology circular`
*   `--organism <name>` or `-s <name>`: Filter by species or organism name (substring match).
    *   Example: `refseq-plasmid-dl --organism Salmonella`
*   `--taxid <id>` or `-t <id>`: Filter by NCBI Taxonomy ID.
    *   Example: `refseq-plasmid-dl --taxid 562`
*   `--topology <type>`: Filter by plasmid topology. Accepted values are `circular` or `linear`.
    *   Example: `refseq-plasmid-dl --topology circular`
*   `--min-length <bp>`: Minimum sequence length in base pairs.
    *   Example: `refseq-plasmid-dl --min-length 5000`
*   `--max-length <bp>`: Maximum sequence length in base pairs.
    *   Example: `refseq-plasmid-dl --max-length 200000`
*   `--strain <name>`: Filter by strain name.
*   `--isolate <name>`: Filter by isolate name.
*   `--host <organism>`: Filter by host organism.
*   `--plasmid-name <name>`: Filter by plasmid name.
*   `--geo_loc_name <location>`: Filter by geographic location.
*   `--isolation_source <source>`: Filter by isolation source.
*   `--min-date <YYYY-MM-DD>`: Include records updated after this date.
*   `--max-date <YYYY-MM-DD>`: Include records updated before this date.
*   `--min-collection-date <YYYY-MM-DD>`: Include records collected after this date.
*   `--max-collection-date <YYYY-MM-DD>`: Include records collected before this date.
*   `--dev-mode` or `-d`: Enable development mode to download a single test file set for rapid testing.
*   `--force`: Force re-download of existing files, even if they appear to be present.

### Example Combinations

1.  **Download all plasmids and filter for circular ones:**
    ```bash
    refseq-plasmid-dl --topology circular
    ```
2.  **Download plasmids for *Escherichia* with circular topology:**
    ```bash
    refseq-plasmid-dl --organism Escherichia --topology circular
    ```
3.  **Reprocess existing data to filter for plasmids between 5kb and 200kb:**
    ```bash
    refseq-plasmid-dl --indir refseq_plasmids --min-length 5000 --max-length 200000
    ```

## Output Directory Structure

The output directory (default `refseq_plasmids/` or specified with `-o`) will contain:

*   `plasmids_index.html`: A saved HTML listing of the NCBI plasmid directory.
*   `refseq_plasmids/`: A subdirectory containing the raw downloaded FASTA (`.fna.gz`) and GenBank (`.gbff.gz`) files.
*   `refseq_plasmids_dl.fasta`: The final curated multi-FASTA file.
*   `refseq_plasmids_dl_metadata.csv`: A CSV file with full metadata for all filtered plasmids.
*   `refseq_plasmids_dl_report.csv`: A summary report detailing counts of total records, filtered records by reason, and sequences written.

## Reference documentation
- [refseq-plasmid-dl Overview](./references/anaconda_org_channels_bioconda_packages_refseq-plasmid-dl_overview.md)
- [refseq-plasmid-dl GitHub Repository](https://github.com/erinyoung/refseq-plasmid-dl)