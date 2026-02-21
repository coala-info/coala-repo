---
name: aletsch
description: "Aletsch is a tool for transcript assembly (Note: The provided text is an error log and does not contain help information; description and arguments could not be extracted from the input)."
homepage: https://github.com/Shao-Group/aletsch
---

# aletsch

## Overview
Aletsch is a specialized meta-assembler designed to reconstruct transcripts from multiple RNA-seq experiments simultaneously. By leveraging information across samples, it improves the assembly of low-abundance transcripts and handles the sparsity typical of single-cell RNA-seq data. It supports a wide range of sequencing technologies, including Illumina (short-read), PacBio, and Oxford Nanopore (long-read).

## Input Preparation
Aletsch requires a specific input format for its sample list. Create a space-separated text file where each line contains three fields:
1. **BAM File**: Path to the sorted alignment file.
2. **BAI File**: Path to the index file (generated via `samtools index`).
3. **Protocol**: The sequencing protocol used.

### Supported Protocols
- `single_end`: Illumina single-end.
- `paired_end`: Illumina paired-end.
- `pacbio_ccs`: PacBio Iso-Seq CCS reads.
- `pacbio_sub`: PacBio Iso-Seq sub-reads.
- `ont`: Oxford Nanopore RNA-seq.

## Recommended Workflow
For optimal results, use the two-step profiling and assembly approach.

### 1. Profile Individual Samples
Generate profiles to help Aletsch understand the characteristics of each sample.
```bash
# Ensure the profile directory exists first
mkdir -p sample_profiles
./aletsch --profile -i input_list.txt -p sample_profiles
```

### 2. Perform Meta-Assembly
Run the assembly using the generated profiles and specify an output directory for individual sample transcripts.
```bash
# Ensure the output directory for individual GTFs exists
mkdir -p individual_gtfs
./aletsch -i input_list.txt -o final_assembly.gtf -p sample_profiles -d individual_gtfs -t 16
```

## Scoring Transcripts
Aletsch includes a random forest model to score the reliability of assembled transcripts. This requires the `score.py` script and a pre-trained model.

```bash
python3 score.py -i individual_gtfs -m pretrained_model.joblib -c <num_samples> -p 0.2 -o scored_output.csv
```
- `-i`: The directory specified by `-d` during the assembly step.
- `-p`: Minimum probability score threshold (0.0 to 1.0).
- `-c`: Total number of samples/cells processed.

## Expert Tips and Best Practices
- **Pre-sorting**: Aletsch requires BAM files to be sorted by coordinate. Always run `samtools sort` if the origin of the BAM is unknown.
- **Directory Management**: Aletsch will fail if the directories specified by `-d` or `-p` do not exist. Always create them with `mkdir -p` before execution.
- **Thread Optimization**: Use the `-t` flag to match your available CPU cores. The default is 10.
- **Cluster Tuning**: The `-c` parameter (maximum splice graphs in a cluster) is recommended to be set to twice the number of samples (default is 200).
- **Chromosome Filtering**: To speed up testing or focus on specific regions, use `-l <chrom_name>` or `-L <chrom_list_file>`.

## Reference documentation
- [Aletsch Overview](./references/anaconda_org_channels_bioconda_packages_aletsch_overview.md)
- [Aletsch GitHub Documentation](./references/github_com_Shao-Group_aletsch.md)