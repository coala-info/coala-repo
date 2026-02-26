---
name: kofamscan
description: kofamscan performs functional annotation of protein sequences by searching them against the KOfam database of KEGG Ortholog HMMs using adaptive thresholds. Use when user asks to annotate protein sequences with KEGG Orthologs, perform functional annotation of genomic data, or identify metabolic functions using HMM profiles.
homepage: https://www.genome.jp/tools/kofamkoala/
---


# kofamscan

## Overview
kofamscan is a command-line tool used for the functional annotation of genomic, transcriptomic, or proteomic data. It works by searching protein sequences against KOfam—a customized database of profile Hidden Markov Models (HMMs) representing KEGG Orthologs. Unlike standard HMM searches, kofamscan utilizes KO-specific "adaptive thresholds" to determine if a hit is significant. This allows for more accurate automated annotation than a simple E-value cutoff, as each protein family has its own validated bit-score threshold.

## Usage Patterns

### Basic Execution
The most common usage involves providing a FASTA file of protein sequences and specifying the paths to the KOfam profiles and the threshold information file.

```bash
exec_annotation -o output.txt input_sequences.fasta --ko-list /path/to/ko_list --profile /path/to/profiles/
```

### Key Arguments
- `-o, --output`: Path to the output file.
- `--ko-list`: Path to the `ko_list` file (contains threshold information).
- `--profile`: Path to the directory containing KOfam HMM profiles.
- `-f, --format`: Output format. Options include `detail` (default), `tabular`, and `mapper` (compatible with KEGG Mapper).
- `-E, --e-value`: Set an E-value threshold (default is often 0.01).
- `-T, --cpu`: Number of CPUs to use for parallel processing.

### Interpreting Results
The output highlights high-confidence assignments with an asterisk (`*`).
- **Asterisk (`*`)**: The hit score is above the predefined adaptive threshold for that specific KO, indicating a reliable assignment.
- **No Asterisk**: The hit met the E-value criteria but fell below the KO-specific bit-score threshold; these should be treated as "provisional" or "putative."

## Expert Tips
- **Database Preparation**: Ensure you have downloaded both the HMM profiles and the `ko_list` file from the KEGG FTP/HTTPS servers. The tool cannot function without the threshold metadata found in `ko_list`.
- **Performance**: HMM searches are computationally expensive. Always utilize the `--cpu` flag to match your available hardware resources to significantly reduce runtime.
- **Downstream Analysis**: Use the `mapper` output format if you intend to immediately upload your results to the KEGG Mapper web tool for pathway reconstruction.
- **Memory Management**: For very large datasets, consider splitting the input FASTA file into smaller chunks to avoid potential memory overhead, although kofamscan is generally efficient with sequence streaming.

## Reference documentation
- [KofamKOALA - KEGG Orthology Search](./references/www_genome_jp_tools_kofamkoala.md)
- [kofamscan bioconda overview](./references/anaconda_org_channels_bioconda_packages_kofamscan_overview.md)