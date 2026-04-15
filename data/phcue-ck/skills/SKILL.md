---
name: phcue-ck
description: The phcue-ck tool queries the ENA API to retrieve raw data locations and generate download manifests for sequencing accessions. Use when user asks to find FTP links for sequencing accessions, resolve accessions into download manifests, or generate structured output for raw data downloads.
homepage: https://lgi-onehealth.github.io/phcue-ck/
metadata:
  docker_image: "quay.io/biocontainers/phcue-ck:0.2.0--h3dc2dae_4"
---

# phcue-ck

## Overview
The `phcue-ck` skill provides a streamlined interface for querying the ENA API to find raw data locations. While other tools exist for SRA metadata, `phcue-ck` is optimized for the specific task of returning clean, actionable FTP links. Use this skill to resolve accessions into download manifests, handle paired-end vs. single-end data logic, and generate structured outputs (JSON/CSV) that can be piped into other command-line utilities.

## Core Usage Patterns

### Basic Queries
Retrieve data for one or more specific accessions:
```bash
# Single accession
phcue-ck --accession SRR16298173

# Multiple accessions
phcue-ck --accession SRR16298173 SRR16298174
```

### Batch Processing
For large projects, provide a line-delimited text file of accessions:
```bash
phcue-ck --file accessions.txt
```

### Output Formatting
Choose the format that best fits your downstream processing needs:
- **json** (Default): Best for programmatic parsing.
- **csv**: Standard flat format.
- **csv-wide**: One row per accession (useful for spreadsheets).
- **csv-long**: Key-value pairs (useful for tidy data analysis).

```bash
phcue-ck --accession SRR16298173 --output-format csv-wide
```

## Expert Tips & Best Practices

### Optimizing Performance
When querying many accessions, use the `-n` flag to enable parallel requests. The tool supports up to 10 concurrent connections.
```bash
# Run 10 queries in parallel for faster manifest generation
phcue-ck -n 10 --file large_accession_list.txt
```

### Handling Library Layouts
By default, `phcue-ck` ignores the small single-end "technical" reads often found alongside paired-end data in ENA. If your workflow requires all available files regardless of layout, use the `-k` flag.
```bash
# Ensure single-end files are included in the output
phcue-ck -k --accession ERR5556343
```

### Integration with Downloaders
To immediately download the files discovered by `phcue-ck`, pipe the CSV output to `wget` or `curl`.
```bash
# Example: Extracting URLs from CSV and downloading via wget
phcue-ck --accession SRR16298173 --output-format csv | tail -n +2 | cut -d',' -f2 | xargs -n 1 wget
```

## Reference documentation
- [Usage Guide](./references/lgi-onehealth_github_io_phcue-ck_usage.md)
- [Examples and Patterns](./references/lgi-onehealth_github_io_phcue-ck_examples.md)
- [Installation and Setup](./references/lgi-onehealth_github_io_phcue-ck_installation.md)