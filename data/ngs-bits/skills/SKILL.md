---
name: ngs-bits
description: The `ngs-bits` suite is a collection of high-performance C++ tools specifically engineered for NGS-based diagnostics.
homepage: https://github.com/imgag/ngs-bits
---

# ngs-bits

# ngs-bits

## Overview
The `ngs-bits` suite is a collection of high-performance C++ tools specifically engineered for NGS-based diagnostics. It provides a robust framework for the entire secondary analysis workflow, from raw FASTQ processing and adapter trimming to sophisticated quality control and variant-level analysis. The suite is particularly valuable for clinical environments requiring deterministic results, standardized QC metrics (via the qcML format), and specialized diagnostic tools for detecting Copy Number Variations (CNV), Runs of Homozygosity (ROH), and Uniparental Disomy (UPD).

## Core Workflows and Tool Usage

### 1. Quality Control (QC)
The suite uses the `qcML` format (XML-based) for standardized reporting.
- **FASTQ QC**: Use `ReadQC` for initial raw data assessment.
- **BAM QC**: Use `MappingQC` to calculate mapping statistics, coverage, and insert sizes.
- **VCF QC**: Use `VariantQC` for variant-level metrics (Ti/Tv ratio, etc.).
- **Reporting**: Use `QcToTsv` to convert the structured `qcML` files into flat TSV files for integration into custom reports or spreadsheets.

### 2. Sample Validation and Diagnostics
These tools are critical for clinical sample tracking and biological verification.
- **Sample Identity**: Use `SampleSimilarity` to compare VCF/BAM files and detect sample swaps. Use `SampleIdentity` to identify datasets belonging to the same patient across different modalities (WGS, RNA-seq, etc.).
- **Biological Sex**: Run `SampleGender` on BAM files to verify if the genetic sex matches the clinical metadata.
- **Ancestry**: Use `SampleAncestry` to estimate the genetic background of a sample.
- **Variant Hunting**:
    - `CnvHunter`: Detect CNVs in targeted resequencing using non-matched controls.
    - `RohHunter`: Detect Runs of Homozygosity from annotated VCFs.
    - `UpdHunter`: Detect Uniparental Disomy using trio variant data.

### 3. Sequence Manipulation (FASTQ & BAM)
- **Trimming**: `SeqPurge` is a highly sensitive adapter trimmer specifically optimized for paired-end data.
- **BAM Filtering**: Use `BamFilter` for complex filtering criteria beyond simple flag checks.
- **Overlap Clipping**: Use `BamClipOverlap` to prevent double-counting of bases in overlapping paired-end reads.
- **Conversion**: Use `BamToFastq` for coordinate-sorted BAMs when re-alignment is necessary.

### 4. Genomic Interval Operations (BED Tools)
The `ngs-bits` BED tools are often more specialized for diagnostics than general-purpose suites:
- **Coverage**: `BedCoverage` calculates average coverage across regions from multiple BAM files simultaneously.
- **Annotation**: `BedAnnotateGenes` and `BedAnnotateGC` add biological context and GC content to intervals.
- **Refinement**: Use `BedLowCoverage` and `BedHighCoverage` to identify problematic regions for clinical reporting.

### 5. VCF Manipulation
- **Annotation**: `VcfAnnotateConsequence` provides transcript-specific predictions similar to VEP but integrated into the C++ workflow.
- **Merging**: Use `VcfAdd` to combine VCF files by appending.
- **Filtering**: Use `VcfAnnotateFromVcf` or `VcfAnnotateFromBed` to flag variants based on external databases or target regions.

## Expert Tips and Best Practices
- **NGSD Integration**: Many tools (like `BedAnnotateGenes`) can optionally connect to the NGSD (Next-Generation Sequencing Database). Ensure your environment variables are set if using a local NGSD instance.
- **Performance**: Most tools are multi-threaded. Check the `-threads` parameter for computationally intensive tasks like `SeqPurge` or `MappingQC`.
- **Reference Genomes**: Ensure the reference genome FASTA used across different tools matches exactly (e.g., chromosome naming conventions like 'chr1' vs '1'). Use `FastaFromBam` to verify or retrieve the reference used in a specific BAM/CRAM file.
- **Memory Management**: When processing large VCFs or BAMs, tools like `VcfSort` or `BedSort` may require significant memory; ensure your environment has sufficient overhead for coordinate-based sorting.

## Reference documentation
- [ngs-bits GitHub Repository](./references/github_com_imgag_ngs-bits.md)
- [Bioconda ngs-bits Overview](./references/anaconda_org_channels_bioconda_packages_ngs-bits_overview.md)