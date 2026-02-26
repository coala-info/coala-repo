---
name: spine
description: Spine is a bioinformatics tool that identifies the core genome and accessory sequences across multiple organisms using the MUMmer alignment engine. Use when user asks to define a core genome, identify homologous genomic regions, generate pangenome data, or extract backbone sequences from bacterial genomes.
homepage: https://github.com/egonozer/Spine
---


# spine

## Overview
Spine is a specialized bioinformatics tool designed to define the core genome—the set of genomic regions conserved across a specified percentage of input organisms. By utilizing the MUMmer alignment engine, Spine identifies homologous regions and outputs backbone sequences, accessory sequences, and detailed statistics. It is particularly effective for bacterial genomics where researchers need to distinguish between the stable core and the variable accessory genome.

## Command Line Usage

### Input File Preparation
The primary requirement for Spine is a tab-delimited input file (specified with `-f`) that maps file paths to unique identifiers.

**Format:** `path/to/file <tab> unique_identifier <tab> format`

*   **Formats supported:** `fasta`, `gbk` (GenBank), or `comb` (FASTA + GFF3).
*   **Multiple files per strain:** If a genome consists of multiple chromosomes or plasmids, separate the paths with commas:
    `chrom1.fasta,chrom2.fasta,plasmid.fasta <tab> strain_ID <tab> fasta`

### Common CLI Patterns

**Basic Core Genome Identification:**
```bash
perl spine.pl -f genome_list.txt -o project_output
```

**Defining a "Soft" Core (e.g., present in 90% of strains):**
```bash
perl spine.pl -f genome_list.txt --pctcore 90
```

**High-Performance Execution:**
```bash
perl spine.pl -f genome_list.txt -t 8 -p 90
```
*   `-t`: Sets threads (ensure this matches available CPU cores).
*   `-p`: Sets minimum percent identity for homology (default is 85).

**Generating Pangenome Data:**
```bash
perl spine.pl -f genome_list.txt --pangenome
```

**Resource-Efficient "Mini" Mode:**
Use this when you only need the backbone sequence derived from the reference and want to skip full accessory extraction for every genome.
```bash
perl spine.pl -f genome_list.txt --mini
```

### Reference Selection Logic
By default, Spine uses the first genome in your input file as the primary reference. You can customize priority using the `-r` flag with 1-based integers:
```bash
perl spine.pl -f genome_list.txt -r 3,1
```
*This prioritizes the 3rd genome in the list as the primary reference, followed by the 1st.*

## Expert Tips and Best Practices

*   **Unique Identifiers:** Ensure that all chromosome, plasmid, and contig IDs are unique within a single genome entry. Duplicate IDs within a strain will cause incorrect results.
*   **MUMmer Path:** If MUMmer is not in your system PATH, specify the directory containing the binaries using `-m /path/to/mummer/bin`.
*   **Fragment Merging:** Use the `-g` (max distance) parameter to control how close core segments must be to be merged. The default is 10bp; increasing this can result in fewer, longer core segments joined by 'N's.
*   **Memory Management:** For very large datasets, the `--mini` flag is highly recommended to reduce the computational overhead of processing accessory genomes for every input strain.
*   **Annotation Handling:** Providing GenBank (`gbk`) or combined FASTA/GFF3 (`comb`) files allows Spine to include coding sequence (CDS) counts in the `statistics.txt` output.

## Reference documentation
- [Spine GitHub Repository](./references/github_com_egonozer_Spine.md)
- [Spine Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_spine_overview.md)