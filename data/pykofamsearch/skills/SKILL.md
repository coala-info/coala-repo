---
name: pykofamsearch
description: pykofamsearch is a high-performance tool that uses PyHMMER to annotate protein sequences with KEGG Orthology terms. Use when user asks to annotate protein sequences using KofamScan, search against the KOfam database, or serialize KOfam models for faster profile HMM searches.
homepage: https://github.com/jolespin/pykofamsearch
---


# pykofamsearch

## Overview
pykofamsearch is a high-performance implementation of KofamScan that utilizes the PyHMMER library to accelerate profile HMM searches. It is designed to be significantly faster than the original KofamScan by keeping data in memory and avoiding the creation of intermediate files. This tool is particularly effective for annotating large sets of protein sequences (FASTA or gzipped FASTA) using the KEGG Orthology (KO) system. It supports both the standard KOfam directory structure and a specialized serialized (pickle) format for even faster loading.

## Database Preparation
Before running searches, the KOfam database must be downloaded and optionally serialized. Serializing the database is highly recommended for repeated use as it significantly reduces startup time.

### Online Serialization
Automatically download and serialize the latest KOfam models:
```bash
serialize_kofam_models -o path/to/database_directory/
```

### Manual/Offline Serialization
If you already have the `ko_list` and HMM profiles:
```bash
serialize_kofam_models -d path/to/profiles/ -k path/to/ko_list -b path/to/database.pkl.gz
```

## Common CLI Patterns

### Standard Search
Run a search using a serialized database and all available threads:
```bash
pykofamsearch -i proteins.faa.gz -b database.pkl.gz -o results.tsv -p -1
```

### Using Official KOfam Directory
If using the raw KOfam directory instead of a serialized file:
```bash
pykofamsearch -i proteins.faa -d /path/to/KOfam_dir -o results.tsv -p 8
```

### Adjusting Annotation Strictness
*   **More Strict**: Increase the threshold scale (e.g., 1.5).
*   **Less Strict**: Decrease the threshold scale (e.g., 0.8) or use `-a` to ignore curated thresholds entirely.
```bash
pykofamsearch -i proteins.faa -b database.pkl.gz -t 1.2 -o strict_results.tsv
```

### Subsetting the Search
To search only against a specific list of KO identifiers:
```bash
pykofamsearch -i proteins.faa -b database.pkl.gz -s ko_list.txt -o subset_results.tsv
```

## Post-Processing Results
The default output provides raw hits. Use `reformat_pykofamsearch` to group hits by query protein or filter for the best hits.

### Grouping Hits
```bash
reformat_pykofamsearch -i results.tsv -o results.reformatted.tsv
```

### Extracting Best Hits Only
```bash
reformat_pykofamsearch -i results.tsv -b -o best_hits.tsv
```

## Expert Tips
*   **Memory Management**: While pykofamsearch is optimized for speed, loading the full serialized KOfam database requires significant RAM. Ensure the system has at least 16-32GB of available memory for the full database.
*   **Thread Scaling**: Use `-p -1` to automatically utilize all available CPU cores. PyHMMER scales very efficiently across threads.
*   **Input Formats**: The tool natively supports `.gz` files for both input proteins and serialized databases, saving disk space without requiring manual decompression.
*   **Thresholding**: By default, the tool uses KOfam's curated "adaptive" thresholds. Only use the `--all_hits` (`-a`) flag if you intend to perform your own custom filtering, as it will produce a much larger output file.

## Reference documentation
- [pykofamsearch GitHub Repository](./references/github_com_jolespin_pykofamsearch.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pykofamsearch_overview.md)