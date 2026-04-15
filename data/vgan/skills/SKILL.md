---
name: vgan
description: vgan is a suite of pangenomic tools designed for mitochondrial haplogroup classification and species identification using variation graphs. Use when user asks to classify human mtDNA, analyze ancient environmental DNA for bilaterian abundance, or identify species sources in ancient samples.
homepage: https://github.com/grenaud/vgan
metadata:
  docker_image: "quay.io/biocontainers/vgan:3.1.0--h9ee0642_0"
---

# vgan

## Overview

vgan is a specialized suite of pangenomic tools built upon the variation graph (vg) framework. It is designed to handle genomic data more accurately than linear reference-based methods by accounting for known genetic variation. You should use this skill when you need to:
1. **Classify human mtDNA**: Use the `haplocart` subcommand for maximum likelihood haplogroup prediction.
2. **Analyze ancient environmental DNA**: Use `euka` for bilaterian abundance estimation.
3. **Identify species sources**: Use `soibean` for detecting contributing species in filtered ancient samples.

## Installation and Environment Setup

vgan is supported on Linux and requires the `vg` (variation graph) tool as a dependency.

### Directory Structure
vgan expects a specific directory structure for its resource files. Ensure these exist in your environment:
- `$HOME/share/vgan/hcfiles/` (HaploCart graph files)
- `$HOME/share/vgan/euka_dir/` (euka database files)
- `$HOME/share/vgan/soibean_dir/` (soibean resources)

### Permissions Tip
If multiple users share the same graph files, ensure the distance index files are writable:
```bash
chmod +w $HOME/share/vgan/hcfiles/graph.dist
chmod +w $HOME/share/vgan/euka_dir/euka_db.dist
```

## HaploCart: mtDNA Classification

`haplocart` predicts mitochondrial haplogroups from modern human samples.

### Common CLI Patterns
- **From FASTA (Consensus):**
  ```bash
  vgan haplocart -f sample.fa.gz
  ```
- **From FASTQ (Single-end or Paired-end):**
  ```bash
  vgan haplocart -fq1 reads_R1.fq.gz -fq2 reads_R2.fq.gz
  ```
- **From GAM (Graph Alignment Map):**
  Note: Reads must have been previously aligned to the vgan-specific graph.
  ```bash
  vgan haplocart -g aligned_reads.gam
  ```

### Handling Non-Native Formats
- **BAM/CRAM:** vgan does not read HTS-lib formats directly. Pipe unmapped reads from samtools:
  ```bash
  samtools bam2fq input.bam | vgan haplocart -fq1 /dev/stdin
  ```
- **VCF:** Convert VCF to FASTA first using the provided helper script:
  ```bash
  python3 share/vgan/hc_scripts/vcf2fasta.py input.vcf.gz rCRS J01415.2 | gzip > input.fa.gz
  vgan haplocart -f input.fa.gz
  ```

## euka: Bilaterian Abundance Estimation

Use `euka` for detecting bilaterian taxa in ancient environmental DNA.

### Basic Usage
```bash
vgan euka -fq1 reads.fq.gz
```

### Expert Tips
- **Database Path:** If your database is not in the default `share/vgan/euka_dir`, specify it manually using the appropriate flag (check `vgan euka --help`).
- **Output:** euka provides abundance estimates; ensure your input reads have been properly adapter-trimmed and filtered for quality before processing.

## soibean: Species Identification

`soibean` is used for identifying one or more contributing species in filtered ancient environmental samples.

### Basic Usage
```bash
vgan soibean -fq1 filtered_reads.fq.gz
```

## General Best Practices

1. **Data Sparsity:** For low-coverage or sparse data in HaploCart, always check the clade-level posterior probabilities in the output files rather than relying solely on the top prediction.
2. **Mapping Stochasticity:** vgan relies on `vg giraffe` for mapping. Because `giraffe` lacks a fixed random seed, results may vary slightly between runs on the same sample in edge cases.
3. **Resource Downloads:** If subcommands fail due to missing files, use the internal make targets (if building from source) to fetch data:
   - `make hcfilesmade`
   - `make eukafilesmade`
   - `make soibeanfilesmade`



## Subcommands

| Command | Description |
|---------|-------------|
| vgan euka | euka performs abundance estimation of eukaryotic taxa from an environmental DNA sample. |
| vgan gam2prof | Convert gam file to profile file. |
| vgan haplocart | Haplocart predicts the mitochondrial haplogroup for reads originating from an uncontaminated modern human sample. |
| vgan soibean | First, to create a taxon of interest for the --dbprefix option please use:       /usr/local/bin/../share/vgan/soibean_dir/make_graph_files.sh [taxon name] The taxon name must be from our database. To get an overview of the available taxa use:       /usr/local/bin/../share/vgan/soibean_dir/make_graph_files.sh taxa |
| vgan_duprm | Remove duplicates from GAM file. |

## Reference documentation
- [HaploCart Manual](./references/github_com_grenaud_vgan_wiki_HaploCart.md)
- [Installation Guide](./references/github_com_grenaud_vgan_wiki_Installation.md)
- [euka Overview](./references/github_com_grenaud_vgan_wiki_euka.md)
- [soibean Overview](./references/github_com_grenaud_vgan_wiki_soibean.md)