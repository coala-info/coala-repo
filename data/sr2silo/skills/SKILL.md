---
name: sr2silo
description: "sr2silo converts short-read alignments into compressed SILO-formatted NDJSON files for viral surveillance and database submission. Use when user asks to translate nucleotide reads into amino acids, process BAM files for LAPIS-SILO, or submit sequencing data to Loculus."
homepage: https://github.com/cbg-ethz/sr2silo
---


# sr2silo

## Overview

`sr2silo` is a specialized utility for the bioinformatics domain that bridges the gap between raw short-read alignments and the SILO data format. It automates the translation of nucleotide reads into amino acids and packages them into compressed NDJSON files compatible with LAPIS-SILO v0.8.0+. This tool is essential for researchers and clinicians who need to wrangle sequencing data for viral surveillance and database submission.

## Installation

The tool is primarily distributed via Bioconda:

```bash
conda install -c bioconda sr2silo
```

## Core CLI Usage

### Processing BAM Data
The primary command for data conversion is `process-from-vpipe`. This command handles the translation and alignment of reads.

```bash
sr2silo process-from-vpipe \
  --input-file path/to/input.bam \
  --sample-id SAMPLE_NAME \
  --timeline-file timeline.tsv \
  --organism covid \
  --output-fp output.ndjson.zst
```

**Key Arguments:**
- `--organism`: Supported organisms include `covid` and `rsva`.
- `--timeline-file`: A TSV file containing temporal metadata for the sample.
- `--output-fp`: It is recommended to use the `.ndjson.zst` extension for Zstandard compression, which is natively supported.

### Filtering by Reference Accession
In cases where reads might cross-align between similar viruses (e.g., RSV-A and RSV-B), use the `--reference-accession` flag to ensure data integrity.

```bash
sr2silo process-from-vpipe \
  --input-file input.bam \
  --reference-accession "NC_038235.1" \
  --organism rsva \
  --output-fp filtered_output.ndjson.zst
```

### Submitting to Loculus
Once processed, data can be submitted directly to a Loculus instance.

```bash
sr2silo submit-to-loculus \
  --processed-file output.ndjson.zst \
  --auto-release
```

## Expert Tips and Best Practices

- **Compression**: Always use `.zst` for output files. The tool handles the compression internally, and it significantly reduces the storage footprint for large-scale surveillance data.
- **Reference Handling**: If you encounter a `ZeroFilteredReadsError`, verify that your `--reference-accession` matches the headers in your BAM file exactly.
- **Environment Variables**: For automated deployments, `sr2silo` can be configured via environment variables to avoid passing repetitive CLI flags in cluster environments.
- **V-PIPE Integration**: While `sr2silo` is a standalone tool, it is optimized to consume outputs from the V-PIPE pipeline. Ensure your BAM files are coordinate-sorted and indexed for optimal performance.

## Reference documentation
- [sr2silo Main Repository](./references/github_com_cbg-ethz_sr2silo.md)
- [Version 1.7.0/1.8.0 Release Notes and CLI Updates](./references/github_com_cbg-ethz_sr2silo_tags.md)