---
name: ngsngs
description: ngsngs is a high-throughput sequencing simulator that generates synthetic reads with customizable error profiles, fragment lengths, and genomic features. Use when user asks to simulate sequencing data, model ancient DNA deamination, generate reads from specific VCF variants, or create coverage-based datasets in BAM or FASTQ formats.
homepage: https://github.com/rahenriksen/ngsngs
metadata:
  docker_image: "quay.io/biocontainers/ngsngs:0.9.2--hce60e53_0"
---

# ngsngs

## Overview

The `ngsngs` tool is a versatile simulator designed to produce high-throughput sequencing data that mimics real-world experimental outputs. It allows users to control variables such as sequencing depth, fragment length distributions, and sequencing error profiles. Beyond standard genomic simulation, it provides specialized features for ancient DNA research (modeling deamination) and clinical genomics (simulating variants from VCF files). It supports single-end (SE) and paired-end (PE) reads in BAM, FASTQ, and FASTA formats.

## Core CLI Usage

The basic syntax for `ngsngs` requires an input reference, a definition of the data volume (reads or coverage), fragment length parameters, sequencing type, and output format.

### Basic Simulation Patterns

**Simulate by Depth of Coverage (BAM output):**
```bash
ngsngs -i reference.fa -c 5 -l 100 -seq SE -f bam -o output_prefix
```

**Simulate Specific Number of Reads (FASTQ output):**
```bash
ngsngs -i reference.fa -r 1000000 -l 150 -seq SE -f fq -o output_prefix
```

**Paired-End Simulation with Adapters:**
```bash
ngsngs -i reference.fa -c 10 -l 100 -seq PE -a1 <ADAPTER1> -a2 <ADAPTER2> -f fq -o output_pe
```

### Advanced Genomic Features

**Circular Genome Simulation:**
Use for bacterial or mitochondrial DNA to allow reads to cross the end-coordinate boundary.
```bash
ngsngs -i mito.fa -r 5000 -l 100 -seq SE -sim circ -f fq -o circular_reads
```

**Variant-Aware Simulation:**
Incorporate SNPs and indels from a VCF file into the simulated reads.
```bash
ngsngs -i ref.fa -r 10000 -l 100 -seq SE -vcf variants.vcf -f bam -o variant_reads
```

**Targeted Region Simulation (Capture):**
Simulate reads only from regions defined in a BED file, with optional flanking sequences.
```bash
ngsngs -i ref.fa -c 20 -l 100 -seq SE -incl regions.bed -fl 10 -f fq -o capture_sim
```

## Modeling Errors and Fragment Lengths

### Fragment Length Distributions
Instead of a fixed length (`-l`), use distributions to mimic library prep:
- **Poisson:** `-ld Pois,78`
- **Uniform:** `-ld Uni,30,150`
- **Custom:** `-lf length_profile.txt` (requires a CDF file)

### Sequencing Errors and Quality Scores
- **Fixed Quality:** Use `-qs 40` to set a constant Phred score for all bases.
- **Profile-based:** Use `-q1` (and `-q2` for PE) with frequency files (e.g., `AccFreqL150R1.txt`) to simulate realistic position-dependent errors.
- **Model-based:** Use `-m Illumina,0.024,0.36,0.68,0.0097` to apply specific error models.

### Ancient DNA (aDNA) Simulation
To simulate post-mortem damage (deamination), provide a misincorporation file:
```bash
ngsngs -i ref.fa -r 100000 -ld Pois,50 -seq SE -mf MisincorpFile.txt -f fa -o ancient_sim
```

## Expert Tips

1. **Performance:** Use the `-t` flag to specify the number of threads for faster simulation on large genomes.
2. **Reproducibility:** Always set a seed using `-s <integer>` to ensure the stochastic sampling produces the same results across runs.
3. **Memory Management:** When working with large VCF files, use the `-chr` flag to limit simulation to specific chromosomes to reduce memory overhead.
4. **Validation:** Use `-DumpVCF <name>` when simulating variants to output a record of the exact mutations incorporated into the simulated data.

## Reference documentation
- [NGSNGS GitHub Repository](./references/github_com_RAHenriksen_NGSNGS.md)
- [Bioconda ngsngs Overview](./references/anaconda_org_channels_bioconda_packages_ngsngs_overview.md)