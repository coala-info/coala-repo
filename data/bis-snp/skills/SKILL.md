---
name: bis-snp
description: Bis-SNP is a specialized genomic analysis tool built on the GATK map-reduce framework.
homepage: http://people.csail.mit.edu/dnaase/bissnp2011/
---

# bis-snp

## Overview
Bis-SNP is a specialized genomic analysis tool built on the GATK map-reduce framework. It addresses the unique challenge of bisulfite sequencing—where unmethylated cytosines are converted to uracils (read as thymines)—by using a probability-based model to distinguish between true C-to-T SNPs and cytosine conversion. It is particularly effective for researchers needing high-sensitivity variant detection alongside accurate methylation quantification in directional Illumina libraries.

## Core Workflows

### 1. Data Preparation
Before running the caller, ensure your input BAM files are processed similarly to standard GATK best practices:
- Align reads using a bisulfite-aware aligner (e.g., Bismark or BS-Seeker2).
- Sort and index the BAM file.
- Mark duplicates using Picard tools.
- **Reference Genome:** Use the same reference genome used for alignment.

### 2. Genotyping and Methylation Calling
The primary command uses the `BisulfiteGenotyper` walker.

```bash
java -Xmx4g -jar BisSNP.jar \
    -T BisulfiteGenotyper \
    -R reference.fasta \
    -I input_processed.bam \
    -D dbSNP.vcf \
    -vfn output_raw_snps.vcf \
    -stand_call_conf 20 \
    -stand_emit_conf 0 \
    -mmq 30 \
    -mbq 0
```

### 3. Methylation Summary (Post-processing)
To extract specific methylation levels into bedGraph or wiggle formats for visualization:

```bash
java -Xmx4g -jar BisSNP.jar \
    -T BisulfiteVcfAnalyzer \
    -R reference.fasta \
    -vcf output_filtered_snps.vcf \
    -cv output_cytosine_summary.txt \
    -out_one_pixel \
    -stand_call_conf 20
```

## Expert Tips and Best Practices
- **Memory Management:** Since Bis-SNP is Java-based, always specify the heap size (e.g., `-Xmx4g` or higher) based on your system resources and genome size.
- **Cytosine Contexts:** By default, Bis-SNP identifies CpG contexts. For NOMe-seq or plant studies, ensure you specify the relevant context (CHH, CHG, or GCH) in the parameters to capture non-CpG methylation.
- **Base Quality Recalibration:** Bis-SNP supports base quality score recalibration (BQSR) specifically tailored for bisulfite data. Use this to reduce false positive SNP calls caused by systematic sequencing errors.
- **Multi-threading:** Utilize the `-nt` (number of threads) or `-nct` (number of CPU cores per data thread) arguments to speed up processing on large datasets, as Bis-SNP leverages the GATK map-reduce framework.
- **Filtering:** Always filter the raw VCF output. High-confidence SNPs typically require a Phred-scaled quality score > 20.

## Reference documentation
- [Bis-SNP Home and Introduction](./references/people_csail_mit_edu_dnaase_bissnp2011.md)
- [Bioconda bis-snp Package Overview](./references/anaconda_org_channels_bioconda_packages_bis-snp_overview.md)