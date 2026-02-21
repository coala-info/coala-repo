---
name: ngseqbasic
description: The `ngseqbasic` tool simplifies the transition from raw sequencing reads to interpretable genomic tracks.
homepage: http://userweb.molbiol.ox.ac.uk/public/telenius/NGseqBasicManual/external/instructionsBioconda.html
---

# ngseqbasic

## Overview
The `ngseqbasic` tool simplifies the transition from raw sequencing reads to interpretable genomic tracks. It automates the standard bioinformatics workflow—including quality control, mapping, filtering, and track generation—specifically optimized for chromatin accessibility and protein-DNA interaction assays. It is particularly useful for researchers who require a standardized, "one-command" solution for processing ChIP, DNase, or ATAC data without manually chaining individual tools like Bowtie2, Samtools, and Bedtools.

## Command Line Usage

### Basic Execution
The tool is typically invoked by specifying the input FASTQ files and the target genome.
```bash
ngseqbasic -f input_R1.fastq.gz -r input_R2.fastq.gz -g hg38 -o output_directory
```

### Key Parameters
- `-f`: Forward reads (FASTQ).
- `-r`: Reverse reads (for paired-end data).
- `-g`: Genome build (e.g., hg19, hg38, mm10).
- `-o`: Output directory name.
- `-p`: Number of processors/threads to use for parallel steps.

### Workflow Stages
When running `ngseqbasic`, the tool automatically performs the following:
1. **Adapter Trimming**: Removal of sequencing adapters.
2. **Alignment**: Mapping reads to the reference genome.
3. **Filtering**: Removal of multi-mapping reads and PCR duplicates.
4. **Track Generation**: Creation of normalized BigWig files for visualization in UCSC Genome Browser or IGV.

## Best Practices
- **Genome Indexes**: Ensure that the environment variable for genome indexes is correctly set or that indexes are available in the default search path expected by the tool.
- **Memory Management**: For large ATAC-seq datasets, ensure sufficient RAM is allocated, as the sorting and duplicate removal steps can be memory-intensive.
- **Quality Control**: Always inspect the generated QC reports (often found in the output folder) to check for library complexity and mapping percentages before proceeding with downstream peak calling.

## Reference documentation
- [ngseqbasic Overview](./references/anaconda_org_channels_bioconda_packages_ngseqbasic_overview.md)