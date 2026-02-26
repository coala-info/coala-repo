---
name: recontig
description: "recontig converts contig nomenclature between different naming conventions like UCSC, NCBI, and Ensembl across various bioinformatics file formats. Use when user asks to rename chromosomes in genomic files, map contig names between genome builds, or generate custom sequence mapping files."
homepage: https://github.com/blachlylab/recontig
---


# recontig

## Overview
recontig is a high-performance utility designed to rapidly convert contig nomenclature within standard bioinformatics file formats. By leveraging the speed of the D language and htslib, it allows for seamless remapping between UCSC, NCBI, Ensembl, and Gencode conventions. It handles both headers and individual records, supporting local, compressed (gzip/bgzip), and remote files (HTTP/S3).

## Installation
The most reliable way to install recontig is via Bioconda:
```bash
conda install -c bioconda recontig
```

## Common CLI Patterns

### 1. Converting Using Built-in Mappings
recontig can automatically fetch mapping files from the `dpryan79/ChromosomeMappings` repository.
```bash
# Convert a VCF from UCSC to Ensembl naming for GRCh37
recontig convert -b GRCh37 -c UCSC2ensembl -f vcf input.vcf.gz > output.vcf
```

### 2. Converting Using a Custom Mapping File
If you have a specific tab-delimited mapping file (two columns: "from" and "to"):
```bash
recontig convert -m my_mapping.txt -f bed input.bed > output.bed
```

### 3. Handling SAM/BAM Files
Note that for SAM/BAM, the output format is determined by the `-f` flag.
```bash
# Output as BAM
recontig convert -m mapping.txt -f bam input.bam -o output.bam

# Output as SAM
recontig convert -m mapping.txt -f sam input.bam > output.sam
```

### 4. Converting Generic Delimited Files
You can use recontig on non-standard text files by specifying the column and delimiter.
```bash
recontig convert -m mapping.txt --col 1 --delimiter ',' --comment '#' input.csv > output.csv
```

### 5. Generating a New Mapping File
If a mapping doesn't exist, create one by comparing two indexed FASTA files. recontig compares contigs using MD5 sums, accounting for masking differences.
```bash
samtools faidx ref1.fasta
samtools faidx ref2.fasta
recontig make-mapping ref1.fasta ref2.fasta > new_mapping.txt
```

## Expert Tips and Best Practices

*   **Post-Conversion Sorting**: recontig does not re-sort records. Because contig order often changes between conventions (e.g., Ensembl vs. UCSC), you **must** sort the output file using the appropriate tool (`bcftools sort`, `samtools sort`, or `bedtools sort`) before downstream analysis.
*   **Capture Unmapped Records**: Use the `-e` (or `--ejected-output`) flag to save records whose contigs could not be found in the mapping file. This is critical for auditing data loss.
    ```bash
    recontig convert -b GRCh38 -c ensembl2UCSC -f vcf in.vcf -e unmapped_records.txt > out.vcf
    ```
*   **Remote Access**: recontig supports htslib-style remote paths. You can stream files directly from S3 or HTTPS without manual downloading.
*   **Discovery**: If you are unsure of the available build strings or conversion directions, use the help subcommands:
    *   `recontig build-help`: Lists available genome builds.
    *   `recontig conversion-help -b <build>`: Lists available naming conversions for a specific build.

## Reference documentation
- [recontig GitHub Repository](./references/github_com_blachlylab_recontig.md)
- [recontig Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_recontig_overview.md)