---
name: secapr
description: SECAPR is a comprehensive toolkit that processes raw Illumina fastq reads into phylogenomic alignments through quality control, de novo assembly, and target extraction. Use when user asks to clean and trim reads, assemble contigs from target enrichment data, identify target sequences, or align and phase reads for phylogenetic analysis.
homepage: https://github.com/AntonelliLab/seqcap_processor
---

# secapr

## Overview
SECAPR (SEquence CApture PRocessor) is a comprehensive toolkit designed to transform raw Illumina fastq reads into phylogenomic alignments. It automates the transition from raw data to "ready-to-analyze" sequences by integrating third-party tools like Trimmomatic, Trinity, and Velvet into a unified command-line interface. It is particularly effective for processing target enrichment data where researchers need to extract specific loci from a genomic background and handle allelic variation through phasing.

## Installation and Environment
The tool is best managed via Conda to ensure all dependencies (like SAMtools and Trimmomatic) are correctly linked.

```bash
# Create and activate the environment
conda create -n secapr_env secapr
conda activate secapr_env

# Verify installation
secapr -h
```

## Core Workflow Commands

### 1. Quality Control and Trimming
Before assembly, reads must be cleaned of adapters and low-quality bases. SECAPR uses a configuration file to manage barcodes and adapter sequences.

```bash
# Clean and trim reads
secapr clean_reads --input /path/to/fastq --config adapter_config.txt --output /path/to/cleaned --index double --read_min 150000
```
*   **Tip**: Use `--read_min` to exclude samples with insufficient data early in the pipeline.
*   **Config Format**: Ensure your config file has `[adapters]`, `[names]`, and `[barcodes]` sections as defined in the documentation.

### 2. De Novo Assembly
SECAPR supports multiple assemblers. Assembly is performed per sample to generate contigs.

```bash
# Assemble cleaned reads
secapr assemble_reads --input /path/to/cleaned --output /path/to/assembly --assembler trinity
```

### 3. Target Identification and Extraction
Once assembled, you must identify which contigs match your target probes (reference sequences).

```bash
# Find contigs matching reference probes
secapr find_target_contigs --input /path/to/assembly --reference probes.fasta --output /path/to/target_contigs

# Extract identified sequences into locus-specific files
secapr extract_sequences --input /path/to/target_contigs --output /path/to/locus_fastas
```

### 4. Alignment and Phasing
For phylogenetic inference, sequences must be aligned. SECAPR can also phase reads to recover allelic information (haplotypes) rather than just consensus sequences.

```bash
# Align sequences per locus
secapr align_sequences --input /path/to/locus_fastas --output /path/to/alignments

# Map reads and phase alleles
secapr locus_selection --input /path/to/alignments --output /path/to/selected_loci
secapr phase_reads --input /path/to/selected_loci --output /path/to/phased_data
```

## Expert Tips
*   **Memory Management**: Assembly (especially with Trinity) is memory-intensive. Ensure your environment has sufficient RAM or use the `--cores` flag where available to limit parallel processes.
*   **File Inspection**: Before starting, check your raw read counts using `grep -c '^+$' *.fastq`. SECAPR works best with at least 200,000 reads per file.
*   **Compressed Files**: Modern versions of SECAPR support `.gz` files directly for the `clean_reads` step, but older versions may require manual unzipping via `gunzip`.



## Subcommands

| Command | Description |
|---------|-------------|
| secapr add_missing_sequences | This script will add dummy sequences '?' for missing taxa in each alignments, making sure that all alignments in the input folder contain the same taxa (as required for e.g. *BEAST) |
| secapr align_sequences | Create multiple sequence alignments from sequence collections |
| secapr assemble_reads | Assemble trimmed Illumina read files (fastq) |
| secapr automate_all | This script automates the complete secapr pipeline, producing MSAs (allele, contig and BAM-consensus) from FASTQ files |
| secapr clean_reads | Clean and trim raw Illumina read files |
| secapr concatenate_alignments | Concatenate mutliple alignments (MSAs) into one supermatrix |
| secapr find_target_contigs | Extract the contigs that match the reference database |
| secapr join_exons | Join exon-alignment files belonging to the same gene |
| secapr locus_selection | Extract the n loci with the best read-coverage from you reference-based assembly (bam-files) |
| secapr paralogs_to_ref | Align paralogous contigs with reference sequence |
| secapr plot_sequence_yield | Plot overview of extracted sequences |
| secapr quality_check | This script runs a fastqc test on all fastq samples in a user-provided folder and creates an overview plot |
| secapr reference_assembly | Create new reference library and map raw reads against the library (reference-based assembly) |
| secapr_phase_alleles | Phase remapped reads form reference-based assembly into two separate alleles. Then produce consensus sequence for each allele. |

## Reference documentation
- [SECAPR GitHub Overview](./references/github_com_AntonelliLab_seqcap_processor.md)
- [File Preparation and Inspection](./references/github_com_AntonelliLab_seqcap_processor_wiki_1.-File-preparation-and-inspection.md)
- [Trimming and Filtering Guide](./references/github_com_AntonelliLab_seqcap_processor_wiki_2.-Trimming-and-filtering.md)
- [Assembly Workflow](./references/github_com_AntonelliLab_seqcap_processor_wiki_3.-Assembly.md)