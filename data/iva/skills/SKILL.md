---
name: iva
description: IVA (Iterative Virus Assembler) is a specialized tool designed for the de novo assembly of RNA virus genomes.
homepage: https://github.com/sanger-pathogens/iva
---

# iva

## Overview
IVA (Iterative Virus Assembler) is a specialized tool designed for the de novo assembly of RNA virus genomes. Unlike general-purpose assemblers, IVA focuses on the unique challenges of viral sequencing, such as extremely high and uneven coverage and the lack of long repeat sequences. It works by iteratively extending seed sequences or existing contigs using aligned read pairs until the full genome is reconstructed.

## Core CLI Usage

The basic command requires a pair of FASTQ files (forward and reverse) or an interleaved file, and a non-existent output directory.

### Basic Assembly
```bash
# Using separate forward and reverse reads
iva -f reads_1.fastq.gz -r reads_2.fastq.gz output_dir

# Using interleaved reads
iva --fr interleaved.fastq.gz output_dir
```

### Extending Existing Assemblies
If you have an existing set of contigs and want to use IVA to extend them:
```bash
iva -f reads_1.fastq.gz -r reads_2.fastq.gz --contigs existing_contigs.fasta output_dir
```

### Performance and Multi-threading
Always specify threads to speed up the SMALT mapping and KMC kmer counting steps:
```bash
iva -t 8 -f reads_1.fastq.gz -r reads_2.fastq.gz output_dir
```

## Expert Tips and Best Practices

### Read Trimming
IVA can integrate Trimmomatic directly. This is highly recommended for viral samples where adapter contamination can interfere with kmer-based seeding.
- Use `--trimmomatic` to provide the path to the `.jar` file.
- Use `--adapters` to specify a custom adapters FASTA file.
- Default quality trimming is `LEADING:10 TRAILING:10 SLIDINGWINDOW:4:20`.

### Seed Generation Tuning
If the assembly fails to start, consider adjusting the seed parameters:
- `--seed_start_length`: Default is the minimum of (median read length, 95). For very short reads, you may need to lower this.
- `--seed_min_kmer_cov`: Default is 25. If your viral titer is low, you might need to decrease this to capture lower-frequency seeds.

### Contig Management
- `--max_contigs`: By default, IVA stops generating new seeds after 50 contigs. For complex mixed infections or segmented viruses (like Influenza), you may need to increase this value.
- `--ctg_first_trim`: IVA trims 25bp (default) off contig ends before the first extension to remove potentially low-quality assembly ends.

### Quality Control (iva_qc)
After assembly, use the companion tool `iva_qc` to evaluate the results against a reference:
```bash
iva_qc --reference ref.fasta --assembled_fasta iva_output/contigs.fasta qc_out
```

## Common Troubleshooting
- **Output Directory**: IVA will fail if the output directory already exists. Always provide a fresh path or delete the old directory first.
- **Samtools Version**: Ensure a modern version of samtools is in your PATH, as IVA relies on it for BAM processing.
- **Memory**: If KMC (kmer counter) consumes too much memory, use `--kmc_onethread` to limit its resource usage.

## Reference documentation
- [IVA GitHub README](./references/github_com_sanger-pathogens_iva.md)
- [IVA Wiki Home](./references/github_com_sanger-pathogens_iva_wiki.md)
- [Bioconda IVA Overview](./references/anaconda_org_channels_bioconda_packages_iva_overview.md)