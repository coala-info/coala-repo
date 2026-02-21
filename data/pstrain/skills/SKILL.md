---
name: pstrain
description: PStrain is an iterative profiling algorithm designed to resolve microbial strains within shotgun metagenomic datasets.
homepage: https://github.com/wshuai294/PStrain
---

# pstrain

## Overview
PStrain is an iterative profiling algorithm designed to resolve microbial strains within shotgun metagenomic datasets. While many tools stop at species-level identification, PStrain identifies the number of strains present, their relative abundances, and their specific genotypes. It functions primarily as a pipeline that leverages MetaPhlAn for taxonomic profiling and Bowtie2 for mapping, but it also includes a dedicated mode for phasing variants of a single species given pre-aligned data.

## Installation and Environment Setup
PStrain can be installed via Bioconda or by cloning the source and building a specific Conda environment.

**Bioconda Installation:**
```bash
conda create --name pstrain -c bioconda -c conda-forge pstrain
conda activate pstrain
```

**Source Installation (for MetaPhlAn 4):**
```bash
git clone https://github.com/wshuai294/PStrain.git --depth 1
cd PStrain/
conda env create --name pstrain -f pstrain_metaphlan4_env.yml
conda activate pstrain
```

## Database Preparation
Before running the main pipeline, you must collect the MetaPhlAn database and build the Bowtie2 index.

```bash
# For MetaPhlAn 4
bash scripts/collect_metaphlan_datbase.sh -x mpa_vOct22_CHOCOPhlAnSGB_202403 -m 4 -d ./db_path/

# For MetaPhlAn 3
bash scripts/collect_metaphlan_datbase.sh -x mpa_v31_CHOCOPhlAn_201901 -m 3 -d ./db_path/
```

## Configuration File Format
PStrain requires a specific configuration file format to define input samples. Note the use of double slashes for sample headers.

**Paired-end reads:**
```text
// sample: SampleA_ID
fq1: /path/to/sampleA_1.fastq
fq2: /path/to/sampleA_2.fastq
// sample: SampleB_ID
fq1: /path/to/sampleB_1.fastq
fq2: /path/to/sampleB_2.fastq
```

**Single-end reads:**
```text
// sample: SampleC_ID
fq1: /path/to/sampleC.fastq
```

## Common CLI Patterns

### Standard Strain Profiling (MetaPhlAn 4)
```bash
python3 scripts/PStrain.py \
    -c config.txt \
    -o output_dir \
    --bowtie2db ./db_path/ \
    -x mpa_vOct22_CHOCOPhlAnSGB_202403
```

### Profiling with MetaPhlAn 3
```bash
python3 scripts/PStrain.py \
    --metaphlan_version 3 \
    -c config.txt \
    -o output_dir \
    --bowtie2db ./db_path/ \
    -x mpa_v31_CHOCOPhlAn_201901
```

### Single Species Phasing
If you already have a BAM file and a VCF file for a specific species, use the `single_species.py` script.
```bash
python3 scripts/single_species.py \
    --bam species_alignment.bam \
    --vcf species_variants.vcf \
    --outdir phasing_results
```

### Merging Results
To combine strain results from multiple runs for downstream analysis:
```bash
python3 scripts/merge.py -i input_dir_list.txt -o merged_output
```

## Expert Tips and Best Practices

1.  **Parallelization Strategy**: PStrain offers two levels of parallelization. Use `-p` to set the number of samples to process simultaneously and `-n` to set the number of threads used by Bowtie2 for mapping within each sample.
2.  **Using Existing MetaPhlAn Results**: To save significant runtime, if you have already run MetaPhlAn (with the `--tax_lev s` flag), you can provide the output files using the `--metaphlan_output_files` argument. Ensure the order of files matches your config file.
3.  **Depth Thresholds**: If dealing with low-abundance samples, adjust `--species_dp` (default: 5). Increasing this value improves genotype accuracy but may exclude rarer species.
4.  **SNP Filtering**: The `--snp_ratio` (default: 0.45) removes SNVs with depth significantly lower than the species mean. Adjust this if you suspect high levels of contamination or extremely uneven coverage.
5.  **Memory Management**: When running many samples in parallel (`-p`), monitor memory usage closely, as Bowtie2 and the iterative solver can be resource-intensive depending on the complexity of the community.

## Reference documentation
- [pstrain Overview](./references/anaconda_org_channels_bioconda_packages_pstrain_overview.md)
- [PStrain GitHub Repository](./references/github_com_wshuai294_PStrain.md)