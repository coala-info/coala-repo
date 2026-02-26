---
name: haphpipe
description: HAPHPIPE is a bioinformatics toolset designed to process raw viral NGS data into consensus sequences and haplotype reconstructions. Use when user asks to process raw reads, perform de novo or reference-based assembly, refine consensus sequences, or call variants in viral genomics datasets.
homepage: https://github.com/gwcbi/haphpipe
---


# haphpipe

## Overview
HAPHPIPE is a specialized bioinformatics toolset designed for viral genomics. It streamlines the transition from raw Next-Generation Sequencing (NGS) data to refined consensus sequences and haplotype reconstructions. It is particularly useful for researchers working with highly diverse viral populations where standard assembly tools might struggle with intra-host variation. The tool is organized into modular stages (reads, assembly, haplotype, description, and phylodynamics) that can be run as standalone commands or as part of integrated pipelines.

## Installation and Setup
HAPHPIPE is primarily distributed via Bioconda. A critical post-installation step is the manual registration of GATK, which is required for variant calling.

1. **Install via Conda**:
   `conda install -c bioconda haphpipe`

2. **Register GATK (Required)**:
   HAPHPIPE requires GATK version 3.8-0. After downloading the licensed copy from the Broad Institute, register it within your environment:
   `gatk3-register /path/to/GenomeAnalysisTK-3.8-0-ge9d806836.tar.bz2`

3. **Verify Installation**:
   Run the built-in demo to ensure all dependencies are correctly configured:
   `hp_demo --outdir test_run`

## Common CLI Patterns

### Read Processing (hp_reads)
Before assembly, use these modules to clean and prepare your raw FASTQ data.

*   **Subsampling**: Reduce dataset size for testing or to normalize coverage.
    `haphpipe sample_reads --fq1 read_1.fastq --fq2 read_2.fastq --nreads 1000 --seed 1234`
*   **Trimming**: Remove adapters and low-quality bases using Trimmomatic.
    `haphpipe trim_reads --fq1 read_1.fastq --fq2 read_2.fastq`
*   **Error Correction**: Use SPAdes to correct sequencing errors in reads.
    `haphpipe ec_reads --fq1 trimmed_1.fastq --fq2 trimmed_2.fastq`

### Assembly and Refinement (hp_assemble)
HAPHPIPE supports both de novo and reference-based assembly.

*   **De Novo Assembly**:
    `haphpipe assemble_denovo --fq1 corrected_1.fastq --fq2 corrected_2.fastq --outdir denovo_assembly`
*   **Reference-Based Alignment**:
    `haphpipe align_reads --fq1 corrected_1.fastq --fq2 corrected_2.fastq --ref_fa reference.fasta`
*   **Iterative Refinement**: Map reads back to a draft assembly to improve the consensus.
    `haphpipe refine_assembly --fq_1 corrected_1.fastq --fq2 corrected_2.fastq --ref_fa draft.fasta`
*   **Finalization**: Generate the final consensus, BAM alignment, and VCF file.
    `haphpipe finalize_assembly --fq_1 corrected_1.fastq --fq2 corrected_2.fastq --ref_fa refined.fna`

### Variant Calling
*   **Call Variants**: Generate a VCF from an alignment.
    `haphpipe call_variants --aln_bam alignment.bam --ref_fa reference.fasta`
*   **Consensus Generation**: Create a FASTA consensus from a VCF.
    `haphpipe vcf_to_consensus --vcf variants.vcf`

## Expert Tips and Best Practices
*   **Pipeline Selection**: Use `haphpipe_assemble_01` for amplicon data where no close reference exists (de novo approach). Use `haphpipe_assemble_02` when a reliable reference sequence is available.
*   **Memory Management**: For `assemble_denovo`, HAPHPIPE uses SPAdes. Ensure your environment has sufficient RAM for the k-mer sizes being explored.
*   **Reference Files**: If you only need the internal HIV reference files provided by the tool, use `hp_demo --refonly` to extract them without running the full demo.
*   **Module Independence**: Every stage in HAPHPIPE is designed to be modular. If a specific pipeline step fails, you can manually run the individual stage (e.g., `haphpipe sample_reads`) with modified parameters to troubleshoot.

## Reference documentation
- [HAPHPIPE GitHub Repository](./references/github_com_gwcbi_haphpipe.md)
- [Bioconda HAPHPIPE Overview](./references/anaconda_org_channels_bioconda_packages_haphpipe_overview.md)