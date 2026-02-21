---
name: hpsuissero
description: HpsuisSero is a specialized bioinformatics pipeline designed to streamline the serotyping of *Haemophilus parasuis* from long-read sequencing data.
homepage: https://github.com/jimmyliu1326/HpsuisSero
---

# hpsuissero

## Overview
HpsuisSero is a specialized bioinformatics pipeline designed to streamline the serotyping of *Haemophilus parasuis* from long-read sequencing data. The tool automates a complex workflow that includes de novo assembly using Flye, consensus polishing with Medaka, and genomic querying against a curated Cps (capsule locus) Blast Database. It is particularly useful for resolving difficult-to-distinguish serotypes, such as the differentiation between serotypes 5 and 12, through integrated feature identification.

## Installation and Setup
The recommended way to install the tool and its dependencies (Medaka, Blast, and Flye) is via Bioconda:

```bash
conda install -c bioconda hpsuissero
```

## Command Line Usage

### Basic Command Structure
The primary executable is `HpsuisSero.sh`. You must provide the sample name, input file, output directory, and input format.

```bash
HpsuisSero.sh -s <sample_name> -i <input_file> -o <output_dir> -x <fasta|fastq>
```

### Parameters
- `-i`: Path to the input file (Nanopore reads).
- `-o`: Path to the directory where results will be stored.
- `-s`: Unique identifier for the sample.
- `-x`: Format of the input file; must be either `fasta` or `fastq`.
- `-t`: (Optional) Number of threads to use for Flye and Medaka. Defaults to 4.

### Common Patterns

**Processing FASTQ reads with optimized threading:**
```bash
HpsuisSero.sh -s Hps_Sample_01 -i ./data/reads.fastq -o ./results/sample_01 -x fastq -t 8
```

**Processing an existing FASTA assembly:**
```bash
HpsuisSero.sh -s Hps_Assembly_01 -i ./data/assembly.fasta -o ./results/assembly_01 -x fasta
```

## Expert Tips and Best Practices
- **Input Quality**: While the pipeline performs polishing with Medaka, starting with high-quality Nanopore reads (Q10+) generally improves the reliability of the Flye assembly and subsequent serotype calling.
- **Serotype 5 and 12 Resolution**: HpsuisSero includes a specific feature identification step to resolve the ambiguity between serotypes 5 and 12. If your results indicate one of these, ensure the pipeline completed the additional feature check successfully.
- **Resource Allocation**: Medaka and Flye are resource-intensive. When running on a cluster or high-performance workstation, always specify the `-t` flag to match your available CPU cores to significantly reduce processing time.
- **Output Inspection**: Review the BLAST results against the Cps database found in the output directory to verify the confidence of the serotype assignment, especially for samples with low coverage.

## Reference documentation
- [HpsuisSero GitHub Repository](./references/github_com_jimmyliu1326_HpsuisSero.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hpsuissero_overview.md)