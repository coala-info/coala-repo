---
name: metabinner
description: MetaBinner is a high-performance ensemble binning tool designed to recover individual genomes from metagenomic assemblies.
homepage: https://github.com/ziyewang/MetaBinner
---

# metabinner

## Overview

MetaBinner is a high-performance ensemble binning tool designed to recover individual genomes from metagenomic assemblies. It operates in two primary phases: a component module that generates diverse, high-quality binning results using a "partial seed" method, and an ensemble module that integrates these results into a final set of bins. Unlike many other ensemble binners, MetaBinner is stand-alone and does not require the output of external binning tools like MaxBin2 or MetaBAT2 to function.

## Preprocessing

Before running the main MetaBinner pipeline, you must prepare coverage and composition profiles.

### 1. Contig Filtering
MetaBinner performs best on contigs longer than 1000bp. Use the provided script to filter your assembly:

```bash
python Filter_tooshort.py <assembly.fasta> 1000
```

### 2. Coverage Profile Generation
The coverage profile is a TSV file where rows are contigs and columns are samples. If you have raw reads, use the provided wrapper script:

```bash
# If installed via bioconda, find the script path first
METABINNER_PATH=$(dirname $(which run_metabinner.sh))

bash ${METABINNER_PATH}/scripts/gen_coverage_file.sh \
    -a assembly.fasta \
    -o coverage_output_dir \
    -t 8 \
    -m 16 \
    path_to_reads/*_1.fastq path_to_reads/*_2.fastq
```

**Note:** If you already have a MetaWRAP/MaxBin2 depth file (`mb2_master_depth.txt`), you can format it for MetaBinner using:
```bash
cat mb2_master_depth.txt | cut -f -1,4- > coverage_profile.tsv
```

### 3. Composition (K-mer) Profile Generation
Generate the k-mer frequency matrix (typically k=4):

```bash
python gen_kmer.py assembly.fasta 1000 4
```
This produces a `.csv` file in the same directory as the assembly.

## Execution Patterns

The main entry point is `run_metabinner.sh`. 

### Standard Usage
```bash
bash run_metabinner.sh \
    -a /absolute/path/to/assembly.fa \
    -o /absolute/path/to/output_dir \
    -d /absolute/path/to/coverage_profile.tsv \
    -k /absolute/path/to/kmer_4_f1000.csv \
    -p /absolute/path/to/metabinner_dir \
    -t 16 \
    -s large
```

### Critical CLI Requirements
*   **Absolute Paths**: All paths passed to `-a`, `-o`, `-d`, `-k`, and `-p` **must** be absolute paths. Relative paths will cause the internal scripts to fail.
*   **Dataset Scale (`-s`)**:
    *   `small`: For low-complexity datasets.
    *   `large`: Default; standard metagenomes.
    *   `huge`: Use this for extremely large datasets to reduce memory consumption.

## Best Practices and Tips

*   **Environment Pathing**: If MetaBinner is installed via Bioconda, the `-p` parameter (path to MetaBinner) can be dynamically set using: `metabinner_path=$(dirname $(which run_metabinner.sh))`.
*   **Memory Management**: If you encounter "Segmentation fault" or memory errors on large assemblies, switch the `-s` parameter to `huge`.
*   **Output Interpretation**: The final binning assignments are located in `${output_dir}/metabinner_res/metabinner_result.tsv`. This file maps contig IDs to bin IDs.
*   **Contig Length**: While 1000bp is the default threshold, for highly fragmented assemblies, you may experiment with 1500bp or 2000bp to improve bin purity, though this may reduce the total recovered genome size.

## Reference documentation
- [MetaBinner GitHub Repository](./references/github_com_ziyewang_MetaBinner.md)
- [MetaBinner Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_metabinner_overview.md)