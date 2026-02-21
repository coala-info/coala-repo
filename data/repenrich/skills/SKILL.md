---
name: repenrich
description: RepEnrich is a specialized bioinformatics tool designed to overcome the challenges of mapping sequencing reads to repetitive regions of the genome.
homepage: https://github.com/nskvir/RepEnrich
---

# repenrich

## Overview
RepEnrich is a specialized bioinformatics tool designed to overcome the challenges of mapping sequencing reads to repetitive regions of the genome. Standard alignment pipelines often discard multi-mapping reads, which leads to an underestimation of repetitive element activity. RepEnrich addresses this by first identifying uniquely mapping reads and then using that information to fractionally assign multi-mapping reads to specific repetitive element subfamilies. This skill provides the necessary procedures for preparing genomic annotations, performing the required two-stage alignment, and executing the enrichment analysis.

## Tool Requirements and Environment
RepEnrich has specific dependency requirements that must be met for successful execution:
- **Language**: Python 2.7.3 (BioPython required).
- **Aligner**: Bowtie 1 (Note: Bowtie 2 is not used for the primary mapping step).
- **Utilities**: samtools (v0.1.19 recommended) and bedtools.
- **Critical Version Note**: Use bedtools versions earlier than 2.24.0. Versions 2.24.0 and later have altered `coverageBed` functionality that causes errors in the RepEnrich workflow.

## Workflow Instructions

### 1. Annotation Setup
Before processing samples, you must build the RepEnrich annotation library for your target genome. This only needs to be performed once per organism.

**Using RepeatMasker files (Default):**
```bash
python RepEnrich_setup.py /path/to/repeatmasker.txt /path/to/genome.fa /path/to/setup_folder
```

**Using a custom BED file:**
If you are focusing on specific elements (e.g., only LTRs), ensure your BED file is tab-delimited with 6 columns: Chromosome, Start, End, Repeat_name, Class, Family.
```bash
python RepEnrich_setup.py /path/to/custom_elements.bed /path/to/genome.fa /path/to/setup_folder --is_bed TRUE
```

### 2. Mapping Strategy
RepEnrich requires a specific Bowtie 1 configuration to separate unique and multi-mapping reads.

**Single-End Reads:**
```bash
bowtie /path/to/index -p 16 -t -m 1 -S --max sample_multimap.fastq sample.fastq sample_unique.sam
```

**Paired-End Reads:**
```bash
bowtie /path/to/index -p 16 -t -m 1 -S --max sample_multimap.fastq -1 sample_1.fastq -2 sample_2.fastq sample_unique.sam
```

**Key Parameters:**
- `-m 1`: Only reports unique alignments.
- `--max`: Redirects all reads that map to more than one location (multi-mappers) to a separate FASTQ file.

### 3. Post-Mapping Processing
Convert the unique mapping SAM file to a sorted and indexed BAM file:
```bash
samtools view -bS sample_unique.sam > sample_unique.bam
samtools sort sample_unique.bam sample_unique_sorted
mv sample_unique_sorted.bam sample_unique.bam
samtools index sample_unique.bam
```

### 4. Calculating Total Mapping Reads
To normalize your data later, you must calculate the total number of mapping reads. This is the sum of:
1. Reads that mapped uniquely (`sample_unique.bam`).
2. Reads that failed the `-m 1` criteria (found in the `sample_multimap.fastq`).

Check the Bowtie standard output for the "# reads with at least one reported alignment" and "# reads with alignments suppressed due to -m" to get these values.

## Best Practices
- **Genome Indexing**: Ensure you have a Bowtie 1 indexed genome available in FASTA format.
- **Annotation Cleaning**: When using RepeatMasker files, it is often beneficial to remove simple and low-complexity repeats while keeping transposons and satellite repeats.
- **Memory Management**: Use the `-p` flag in Bowtie to utilize multiple CPUs, as the mapping step is the most computationally intensive part of the pipeline.

## Reference documentation
- [RepEnrich README](./references/github_com_nskvir_RepEnrich_blob_master_README.md)
- [RepEnrich Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_repenrich_overview.md)