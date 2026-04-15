---
name: phenix
description: PHEnix is a bioinformatics pipeline designed for SNP detection and analysis that integrates mapping and variant calling into a unified workflow. Use when user asks to prepare reference genomes, execute the SNP pipeline, filter variant calls, or convert VCF files to FASTA format for phylogenetic analysis.
homepage: https://github.com/phe-bioinformatics/PHEnix
metadata:
  docker_image: "quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0"
---

# phenix

## Overview

PHEnix is a specialized bioinformatics pipeline designed for SNP (Single Nucleotide Polymorphism) detection and analysis. It streamlines the workflow from raw sequencing data to filtered variant calls by integrating popular mappers and variant callers into a unified command-line interface. This skill provides guidance on preparing reference genomes, executing the core SNP pipeline, and performing post-processing tasks like VCF-to-FASTA conversion.

## Reference Preparation

Before running the pipeline, the reference genome must be indexed for the specific mapper and variant caller combination you intend to use.

- **Command**: `phenix.py prepare_reference.py --mapper [bwa|bowtie2] --variant [gatk|mpileup] --reference <path_to_ref>`
- **Critical Constraint**: The reference file must **not** have a `.fas` extension, as Picard Tools (used internally) will throw an exception. Use `.fasta` or `.fna` instead.
- **Automation**: If running samples individually within the internal pipeline logic, indexing may occur automatically, but manual preparation is recommended for multi-job environments to prevent index corruption.

## Running the SNP Pipeline

The `run_snp_pipeline.py` script is the primary entry point for analysis.

### Basic Syntax
```bash
phenix.py run_snp_pipeline.py -r1 <R1.fastq> -r2 <R2.fastq> -r <reference.fasta> --sample-name <NAME> --mapper <bwa|bowtie2> --variant <gatk|mpileup>
```

### Best Practices
- **Sample Naming**: Always provide the `--sample-name` flag. This string determines the output filenames and the Read Group (RG) ID in the resulting BAM file. If omitted, it defaults to `test_sample`.
- **Environment Variables**: Ensure `GATK_JAR` and `PICARD_JAR` environment variables are set to the full paths of their respective Java archives if using GATK.
- **Output Management**: Intermediate files are written to the current working directory. It is best practice to run the command from a dedicated output directory for each sample.

## Variant Filtering

PHEnix uses a flexible filtering interface to ensure high-quality calls. Filters are passed as a comma-separated list of `key:threshold` pairs.

### Common Filters
- `min_depth`: Minimum mean depth (e.g., `min_depth:5`).
- `mq_score`: Minimum Mapping Quality score (e.g., `mq_score:30`).
- `af_ratio`: Allele frequency ratio (GATK).
- `qg_score`: Genotype quality score.

**Example with filters**:
```bash
phenix.py run_snp_pipeline.py [options] --filters min_depth:10,mq_score:40,qg_score:20
```

## Post-Processing: VCF to FASTA

To prepare data for phylogenetic software, use the `vcf2fasta` tool to convert a directory of VCFs into a multi-FASTA alignment.

- **Command**: `phenix.py vcf2fasta -d <vcf_directory> -o <output.fasta>`
- **Quality Control**:
    - Use `--sample-Ns` to set the maximum fraction of 'N's allowed in a sample before it is discarded.
    - Use `--Ns` to set the maximum fraction of 'N's allowed per column (genomic position).
- **Distance Matrices**: Add `--with-dist-matrix` to automatically generate a SNP distance matrix during conversion.
- **Visualization**: If `matplotlib` and `numpy` are in the environment, using `--with-stats` will generate summary plots of SNPs, mixtures, and low-depth bases.

## Reference documentation
- [PHEnix GitHub README](./references/github_com_ukhsa-collaboration_PHEnix.md)
- [Bioconda Phenix Overview](./references/anaconda_org_channels_bioconda_packages_phenix_overview.md)