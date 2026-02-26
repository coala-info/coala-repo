---
name: optitype
description: OptiType is an HLA genotyping algorithm that performs 4-digit HLA Class I allele prediction using integer linear programming. Use when user asks to perform HLA genotyping, predict HLA Class I alleles from DNA or RNA-Seq data, or analyze HLA coverage plots.
homepage: https://github.com/FRED-2/OptiType
---


# optitype

## Overview
OptiType is a specialized HLA genotyping algorithm that produces accurate 4-digit predictions by simultaneously selecting major and minor HLA Class I alleles. It utilizes an integer linear programming (ILP) approach to maximize the number of explained reads. The tool is versatile, supporting both DNA (Exome/WGS) and RNA-Seq data, and typically outputs results in CSV format along with diagnostic coverage plots.

## Core Workflow

### 1. Pre-filtering (Fishing)
For large datasets, it is highly recommended to filter sequencing data for HLA-relevant reads first. This reduces multi-gigabyte files to megabyte-scale files, significantly speeding up the ILP solver.

**DNA Filtering Example (using RazerS3):**
```bash
razers3 -i 95 -m 1 -dr 0 -o fished_1.bam /path/to/OptiType/data/hla_reference_dna.fasta sample_1.fastq
samtools bam2fq fished_1.bam > sample_1_fished.fastq
```
*Note: For paired-end data, filter each end individually. Do not use the mapper's paired-end mode during this step.*

### 2. Running the Pipeline
Execute the main pipeline using the `OptiTypePipeline.py` script.

**Standard Command Structure:**
```bash
python OptiTypePipeline.py -i <input_1.fastq> [input_2.fastq] (--rna | --dna) -o <output_dir>
```

**Common CLI Patterns:**
- **Paired-end DNA:** `python OptiTypePipeline.py -i R1.fastq R2.fastq --dna -o ./results/`
- **Single-end RNA:** `python OptiTypePipeline.py -i sample.fastq --rna -o ./results/`
- **Using BAM inputs:** If you have intermediate BAM files from a previous OptiType run, you can pass them directly with `-i` to skip the mapping phase.

### 3. Parameter Optimization
- `--beta <float>`: Controls the sensitivity for homozygosity detection. The default is `0.009`. Adjust with caution if you suspect the sample has unusual zygosity.
- `--enumerate <int>`: By default, OptiType returns the optimal solution. Use this to output the top N-1 suboptimal solutions in the CSV.
- `--prefix <string>`: Use this to define a custom filename prefix for output files; otherwise, a timestamp is used.

## Best Practices
- **Solver Selection:** OptiType requires an ILP solver. While it supports GLPK and CBC, CPLEX is often faster for complex samples. Ensure the solver is in your system PATH.
- **Reference Selection:** Ensure you use the correct reference (`hla_reference_dna.fasta` vs `hla_reference_rna.fasta`) during the pre-filtering step to match your data type.
- **Memory Management:** RazerS3 loads all reads into memory. If working on a low-memory machine, ensure your "fished" fastq files are properly subsetted.
- **Output Interpretation:**
    - **CSV:** Contains the predicted alleles and the objective function value.
    - **PDF:** Provides a coverage plot. Always inspect this to verify the distribution of reads across the predicted alleles.

## Reference documentation
- [OptiType GitHub Repository](./references/github_com_FRED-2_OptiType.md)
- [Bioconda OptiType Overview](./references/anaconda_org_channels_bioconda_packages_optitype_overview.md)