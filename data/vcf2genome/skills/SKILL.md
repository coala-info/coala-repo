---
name: vcf2genome
description: vcf2genome transforms VCF call sets into sample-specific draft genomes in FASTA format. Use when user asks to transform VCF to draft genome, reconstruct a genome from VCF, or create a sample-specific genome FASTA.
homepage: https://github.com/apeltzer/vcf2genome
---


# vcf2genome

## Overview
vcf2genome is a specialized tool for transforming VCF call sets into sample-specific draft genomes. It bridges the gap between variant calling and downstream phylogenomic analysis by producing a FASTA file where positions are updated based on VCF records or masked with 'N's based on user-defined quality and coverage thresholds. It is highly effective for reference-based assembly refinement in microbial or ancient DNA genomics.

## Command Line Usage

### Basic Syntax
If installed via Bioconda, the tool is typically available as `vcf2genome`. Otherwise, run the JAR file directly:
```bash
vcf2genome -in <input.vcf> -ref <reference.fasta> -draft <output.fasta> [options]
```

### Core Parameters
- `-in`: Input VCF file (must be VCF 4.0/4.1).
- `-ref`: The reference genome FASTA used for the original mapping/calling.
- `-draft`: Path for the primary output FASTA file.
- `-draftname`: The header name for the sequence inside the output FASTA.

### Filtering and Quality Control
Apply filters during reconstruction to ensure the draft genome only contains high-confidence calls:
- `-minc`: Minimum read depth (coverage) required to make a call.
- `-minq`: Minimum quality score (Phred-scaled for UnifiedGenotyper).
- `-minfreq`: Minimum allele frequency (e.g., `0.8` for 80%) to support a nucleotide call.

### Specialized Outputs
- `-refMod`: Generates a detailed encoding file.
    - `N`: Uncovered or ambiguous.
    - `R`: Low coverage but matches Reference.
    - `a, c, t, g`: Low coverage but matches a SNP.
- `-uncertain`: Produces a FASTA in a special "1234" format required by specific downstream legacy tools.

## Expert Tips and Best Practices

### VCF Requirements
- **EMIT_ALL_SITES**: The tool requires a VCF that includes records for every position in the reference, not just variants. Ensure your GATK command included `--output_mode EMIT_ALL_SITES`.
- **Genotyper Compatibility**: While optimized for GATK UnifiedGenotyper, it may work with other genotypers if they follow VCF 4.0/4.1 standards. It is explicitly noted to have potential issues with GATK HaplotypeCaller output.

### Handling Variants
- **SNPs Only**: vcf2genome is designed for SNP-based reconstruction. It does not handle Indels (insertions/deletions) properly due to internal index handling. Filter out Indels from your VCF before processing if necessary.
- **Masking**: Positions that fail the `-minc`, `-minq`, or `-minfreq` thresholds will be represented as `N` in the `-draft` output.

### Example Workflow
To create a draft genome with a minimum coverage of 5x, 80% frequency, and a quality score of 30:
```bash
vcf2genome -in sample.vcf -ref ref.fasta -draft sample_draft.fasta -draftname "Sample_01" -minc 5 -minfreq 0.8 -minq 30 -refMod sample.refMod
```

## Reference documentation
- [VCF2Genome GitHub Repository](./references/github_com_apeltzer_VCF2Genome.md)