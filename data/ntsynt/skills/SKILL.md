---
name: ntsynt
description: ntsynt detects synteny blocks shared across multiple genomes using a dynamic minimizer graph approach. Use when user asks to identify conserved genomic regions, perform large-scale comparative genomics, or detect macrosynteny across genomes with varying evolutionary distances.
homepage: https://github.com/bcgsc/ntsynt
---


# ntsynt

## Overview
The `ntsynt` tool is a high-performance utility for detecting synteny blocks shared across multiple genomes. By utilizing a dynamic minimizer graph approach, it can handle genomes with varying levels of evolutionary distance. It is particularly useful for researchers performing large-scale comparative genomics who need to identify conserved genomic regions (macrosynteny) without the computational overhead of traditional all-to-all alignments.

## Core CLI Usage
The primary command structure requires a divergence estimate and input FASTA files.

```bash
ntSynt -d <divergence_percent> [options] <genome1.fa> <genome2.fa> ... <genomeN.fa>
```

### Key Parameters
- `-d, --divergence`: **Required.** The approximate maximum percent sequence divergence (e.g., `-d 1` for 1%). This automatically scales internal parameters like block size and indel thresholds.
- `--fastas_list`: Use this if you have a large number of genomes; provide a text file with one FASTA path per line.
- `-t`: Number of threads (default is 12).
- `-p, --prefix`: Custom prefix for output files (default: `ntSynt.k<k>.w<w>`).

## Expert Configuration & Best Practices

### Parameter Tuning by Divergence
While `-d` sets defaults, you can override them for specific research needs:

| Divergence | --block_size | --indel | --merge | --w_rounds |
| :--- | :--- | :--- | :--- | :--- |
| **< 1%** | 500 | 10,000 | 10,000 | 100 10 |
| **1% - 10%** | 1,000 | 50,000 | 100,000 | 250 100 |
| **> 10%** | 10,000 | 100,000 | 1,000,000 | 500 250 |

### Memory Optimization
If encountering memory constraints on large datasets:
- Increase the False Positive Rate for the Bloom filter: `--fpr 0.05` (default is 0.025).
- Use a larger window size (`-w`) to reduce the number of minimizers stored in the graph.

### Estimating Divergence
If the divergence between genomes is unknown, use `Mash` to calculate the mutation rate before running `ntSynt`. This ensures the `-d` parameter is set accurately, which is critical for the sensitivity of block detection.

## Analysis and Output
The primary output is `<prefix>.synteny_blocks.tsv`. 

### Post-Processing
To generate summary statistics (N50 of blocks, total syntenic length), use the included analysis script:
```bash
python3 analysis_scripts/denovo_synteny_block_stats.py --tsv <output>.tsv --fai <genome1.fai> <genome2.fai>
```

## Reference documentation
- [ntSynt GitHub Repository](./references/github_com_bcgsc_ntsynt.md)
- [ntSynt Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ntsynt_overview.md)