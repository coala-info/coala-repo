---
name: tides-ml
description: TIdeS (Transcript Identification and Selection) is a machine learning tool designed to extract the most likely protein-coding regions from noisy transcriptomes.
homepage: https://github.com/xxmalcala/TIdeS
---

# tides-ml

## Overview
TIdeS (Transcript Identification and Selection) is a machine learning tool designed to extract the most likely protein-coding regions from noisy transcriptomes. It excels at identifying the correct reading frame and can classify sequences into user-defined categories (e.g., "eukaryotic" vs "non-eukaryotic") to clean up contaminated datasets. It is a robust alternative to standard ORF-calling tools when dealing with non-standard genetic codes or highly contaminated samples like parasite-host mixtures.

## Core Workflows

### ORF Prediction
To predict ORFs from a transcriptome assembly, you need a reference protein database.

```bash
tides -i <transcriptome.fasta> -o <project_name> -d <protein_database>
```

**Key Parameters:**
- `-g <int>`: Specify the NCBI genetic code (default is 1). For example, use `-g 6` for the ciliate genetic code.
- `-p`: Include partial ORFs in the output.
- `-s <both|plus|minus>`: Define which strands to search (default is both).
- `-t <int>`: Set the number of threads (default is 4).

### ORF Classification and Decontamination
TIdeS can classify predicted ORFs into categories to filter out contamination.

**Using Kraken2 (Eukaryotic vs. Non-Eukaryotic):**
```bash
tides -i <predicted_orfs.fasta> -o <project_name> -c -k <kraken2_database_path>
```

**Using a Custom Annotation Table:**
The table must be tab-separated with sequence names and categories.
```bash
tides -i <predicted_orfs.fasta> -o <project_name> -c <annotated_seqs.tsv>
```

### Deploying Pre-trained Models
If you have already trained a TIdeS model (`.pkl` file) on a similar dataset, you can apply it directly to new data.
```bash
tides -i <transcriptome.fasta> -o <project_name> -m <model.pkl>
```

## Expert Tips and Best Practices

- **Minimum Training Data**: When using custom classification (`-c`), ensure you provide at least 25 annotated sequences per category. For better performance, aim for ~200 sequences.
- **Fragmented Assemblies**: If working with highly fragmented transcriptomes, always use the `-p` flag to capture partial ORFs that do not have both start and stop codons.
- **Clustering Control**: TIdeS uses CD-HIT to remove redundant transcripts (default 97% identity). Adjust this with `-id <int>` or skip the step entirely using `--no-filter` if you have already pre-processed the data.
- **Memory Management**: For large datasets, use `--memory <int>` to set the limit (in MB) for CD-HIT. Setting it to `0` allows for unlimited memory usage.
- **Genetic Codes**: TIdeS is particularly powerful for non-standard codes. If your organism uses alternative stop-to-sense reassignments, ensure the correct `-g` table is selected to avoid truncated ORF predictions.

## Reference documentation
- [TIdeS GitHub Repository](./references/github_com_xxmalcala_TIdeS.md)
- [tides-ml Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tides-ml_overview.md)