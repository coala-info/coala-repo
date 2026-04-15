---
name: metabinner
description: MetaBinner is an ensemble binning tool that recovers high-quality microbial genomes from metagenomic assemblies by integrating multiple binning results. Use when user asks to bin metagenomic contigs, generate coverage and composition profiles, or recover genomes from complex microbial communities.
homepage: https://github.com/ziyewang/MetaBinner
metadata:
  docker_image: "quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1"
---

# metabinner

## Overview

MetaBinner is a stand-alone ensemble binning tool designed to recover high-quality microbial genomes from metagenomic assemblies. It utilizes a "partial seed" method to generate diverse component binning results, which are then integrated through an ensemble module. This approach allows it to achieve superior performance on complex communities without requiring outputs from other individual binners. The workflow typically involves preprocessing assembly files to create coverage and composition (k-mer) profiles before running the main ensemble pipeline.

## Preprocessing Workflows

Before running the main MetaBinner pipeline, you must prepare the input profiles.

### 1. Generating Coverage Profiles
If you have a depth file from MetaWRAP (`mb2_master_depth.txt`), format it for MetaBinner:
```bash
# Basic conversion
cat mb2_master_depth.txt | cut -f -1,4- > coverage_profile.tsv

# Recommended: Filter contigs < 1000bp during conversion
cat mb2_master_depth.txt | awk '{if ($2>1000) print $0 }' | cut -f -1,4- > coverage_profile_f1k.tsv
```

To generate coverage directly from reads using the provided helper script:
```bash
bash gen_coverage_file.sh -a contig_file.fa -o ./coverage_out -t 8 -m 16 [reads_1.fastq reads_2.fastq]
```

### 2. Generating Composition Profiles
Use the `gen_kmer.py` script to create the k-mer vector representation (typically k=4):
```bash
python gen_kmer.py assembly.fa 1000 4
```
*Note: This generates a kmer_4_f1000.csv file in the same directory as the assembly.*

## Running MetaBinner

The primary entry point is `run_metabinner.sh`. All paths provided to this script must be **absolute paths**.

### Standard Execution
```bash
bash run_metabinner.sh \
  -a /path/to/final_contigs.fa \
  -o /path/to/output_dir \
  -d /path/to/coverage_profile.tsv \
  -k /path/to/kmer_profile.csv \
  -p /path/to/metabinner_source_dir \
  -t 16 \
  -s large
```

### Parameter Guidance
- `-a`: Metagenomic assembly file (FASTA).
- `-d`: Coverage profile (TSV, tab-separated).
- `-k`: Composition profile (CSV, comma-separated).
- `-s`: Dataset scale. Options: `small`, `large`, or `huge`. Use `huge` for very large datasets to minimize RAM usage.
- `-p`: The installation path of MetaBinner. If installed via bioconda, use: `metabinner_path=$(dirname $(which run_metabinner.sh))`.

## Expert Tips and Best Practices

- **Contig Length Filter**: Always filter out contigs shorter than 1000bp. Binning short contigs introduces significant noise and reduces the quality of the ensemble result.
- **Absolute Paths**: The wrapper script `run_metabinner.sh` is sensitive to pathing; ensure every argument uses a full system path to avoid file-not-found errors during intermediate steps.
- **CheckM Dependency**: MetaBinner relies on CheckM for marker gene information during the ensemble process. Ensure CheckM is properly configured with its database (`checkm data setroot`) before running the pipeline.
- **Output Interpretation**: The final binning assignments are stored in `${output_dir}/metabinner_res/metabinner_result.tsv`.



## Subcommands

| Command | Description |
|---------|-------------|
| Filter_tooshort.py | Filters out short sequences from a FASTA file. |
| bash run_metabinner.sh | Run the MetaBinner pipeline |
| metabinner_gen_kmer.py | Generates k-mers from input sequences. |

## Reference documentation
- [MetaBinner GitHub README](./references/github_com_ziyewang_MetaBinner_blob_master_README.md)
- [MetaBinner Execution Script](./references/github_com_ziyewang_MetaBinner_blob_master_run_metabinner.sh.md)
- [Conda Environment Specification](./references/github_com_ziyewang_MetaBinner_blob_master_metabinner_env.yaml.md)