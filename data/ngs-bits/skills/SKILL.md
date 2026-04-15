---
name: ngs-bits
description: ngs-bits is a collection of bioinformatics tools for analyzing sequencing data with a focus on clinical diagnostics and quality control. Use when user asks to generate quality control reports, validate sample identity through gender or ancestry checks, trim adapters, filter BAM files, or perform BED and VCF annotations.
homepage: https://github.com/imgag/ngs-bits
metadata:
  docker_image: "quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0"
---

# ngs-bits

## Overview
ngs-bits is a specialized collection of tools designed for the analysis of short-read and long-read sequencing data, with a heavy focus on medical diagnostics. Unlike general-purpose bioinformatics suites, ngs-bits provides high-level tools for sample validation (gender, ancestry, and similarity), trio-based analysis (Mendelian errors, contamination), and structured quality control using the qcML format. It is the primary toolkit for pipelines requiring integrated database support (NGSD) and rigorous clinical sample tracking.

## Common CLI Patterns and Tool Usage

### Quality Control (QC) Workflow
The suite uses a standardized XML-based format called `qcML`. To generate a comprehensive report, run the tools sequentially:
- **Raw Data:** `ReadQC -in1 input_R1.fastq.gz -in2 input_R2.fastq.gz -out output.qcML`
- **Mapping:** `MappingQC -in input.bam -out output.qcML`
- **Variants:** `VariantQC -in input.vcf -out output.qcML`
- **Aggregation:** Use `QcToTsv` to convert these XML files into a flat TSV format for multi-sample comparison or LIMS integration.

### Sample Validation and Identity
These tools are critical for detecting sample swaps or contamination in a diagnostic setting:
- **Gender Check:** `SampleGender -in input.bam -method ry` (Uses the R-ratio of Y-chromosomal reads).
- **Similarity:** `SampleSimilarity -in1 sample1.vcf -in2 sample2.vcf` (Calculates genotype overlap to verify if samples originate from the same individual).
- **Ancestry:** `SampleAncestry -in input.vcf` (Estimates population origin based on specific variant frequencies).

### Specialized Trimming and Filtering
- **SeqPurge:** Use this for highly sensitive adapter trimming in paired-end data. It is often more effective than general trimmers for clinical data because it considers the overlap of the two reads.
  `SeqPurge -in1 R1.fastq.gz -in2 R2.fastq.gz -out1 R1_trimmed.fastq.gz -out2 R2_trimmed.fastq.gz`
- **BamFilter:** Use this for complex filtering of BAM files (e.g., by mapping quality, flags, or specific regions) in a single pass.

### BED and Interval Operations
While similar to bedtools, these tools are optimized for diagnostic coverage reporting:
- **BedCoverage:** Annotates a BED file with average coverage from one or more BAM files.
  `BedCoverage -bam input.bam -in regions.bed -out coverage.bed`
- **BedAnnotateGenes:** Requires a connection to the NGSD to map genomic coordinates to gene names and transcripts.

### VCF Manipulation
- **VcfAnnotateConsequence:** Adds transcript-specific consequence predictions (similar to VEP) directly to the VCF.
- **VcfAnnotateFromVcf:** Efficiently transfers INFO or ID fields from a source VCF (like gnomAD or ClinVar) to your target VCF.

## Expert Tips
- **NGSD Integration:** Many tools (like `BedAnnotateGenes` or `BedGeneOverlap`) require the NGSD (Next-Generation Sequencing Database). Ensure your environment is configured with the necessary database credentials if using these features.
- **Memory Management:** For large BAM files, tools like `BamToFastq` or `BamFilter` are optimized for streaming; however, ensure your temporary directory has sufficient space for intermediate sorting if required.
- **CRAM Support:** Most BAM tools in ngs-bits natively support CRAM format via htslib, provided the reference genome is accessible.



## Subcommands

| Command | Description |
|---------|-------------|
| BamClipOverlap | Softclipping of overlapping reads. |
| BamFilter | Filter alignments in BAM/CRAM file (no input sorting required). |
| BamToFastq | Converts a coordinate-sorted BAM file to FASTQ files. |
| BedAnnotateGC | Annotates GC content fraction to regions in a BED file. |
| BedAnnotateGenes | Annotates BED file regions with gene names. |
| BedCoverage | Annotates a BED file with the average coverage of the regions from one or several BAM/CRAM file(s). |
| BedHighCoverage | Detects high-coverage regions from a BAM/CRAM file. Note that only read start/end are used. Thus, deletions in the CIGAR string are treated as covered. |
| BedLowCoverage | Detects low-coverage regions from a BAM/CRAM file. |
| BedSort | Sort the regions in a BED file. |
| MappingQC | Calculates QC metrics based on mapped NGS reads. |
| QcToTsv | Converts qcML files to a TSV file. |
| ReadQC | Calculates QC metrics on unprocessed NGS reads. |
| RohHunter | ROH detection based on a variant list. |
| SampleAncestry | Estimates the ancestry of a sample based on variants. |
| SampleGender | Determines the gender of a sample from the BAM/CRAM file. |
| SampleSimilarity | Calculates pairwise sample similarity metrics from VCF/BAM/CRAM files. |
| SeqPurge | Removes adapter sequences from paired-end sequencing data. |
| UpdHunter | UPD detection from trio variant data. |
| VariantQC | Calculates QC metrics on variant lists. |
| VcfAdd | Merges several VCF files into one VCF by appending one to the other. Variant lines from all other input files are appended to the first input file. VCF header lines are taken from the first input file only. |
| VcfAnnotateConsequence | Adds transcript-specific consequence predictions to a VCF file. |
| VcfAnnotateFromBed | Annotates the INFO column of a VCF with data from a BED file. |
| VcfAnnotateFromVcf | Annotates a VCF file with data from one or more source VCF files. |
| VcfSort | Sorts variant lists according to chromosomal position. |
| ngs-bits_FastaFromBam | Download the reference genome FASTA file for a BAM/CRAM file. |

## Reference documentation
- [ngs-bits Main Documentation](./references/github_com_imgag_ngs-bits.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ngs-bits_overview.md)