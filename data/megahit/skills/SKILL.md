---
name: megahit
description: MEGAHIT is a memory-efficient de Bruijn graph assembler designed for large-scale metagenomic sequencing data. Use when user asks to assemble contigs from metagenomic libraries, optimize assembly for high-diversity samples, or resume an interrupted assembly workflow.
homepage: https://github.com/voutcn/megahit
metadata:
  docker_image: "quay.io/biocontainers/megahit:1.2.9--haf24da9_8"
---

# megahit

## Overview

MEGAHIT is a specialized assembler designed to handle the high complexity and massive volume of metagenomic sequencing data. It excels in environments where computational resources (specifically RAM) are a constraint, utilizing a succinct de Bruijn graph to minimize memory footprint without sacrificing assembly quality. Use this skill to construct contigs from various library types, optimize assembly for high-diversity samples, or resume interrupted assembly workflows.

## Basic Usage Patterns

### Single Library Assembly
For a standard paired-end library:
```bash
megahit -1 pe_1.fq.gz -2 pe_2.fq.gz -o output_dir
```

For an interleaved paired-end library:
```bash
megahit --12 interleaved.fq.gz -o output_dir
```

### Multiple Libraries
You can combine multiple paired-end and single-end libraries by using comma-separated lists:
```bash
megahit -1 p1_1.fq,p2_1.fq -2 p1_2.fq,p2_2.fq -r se1.fq,se2.fq -o output_dir
```

## Expert Configuration and Best Practices

### Presets for Complex Metagenomes
For high-diversity samples (e.g., soil or environmental water samples), use the `meta-large` preset to adjust k-mer steps and pruning parameters for better sensitivity:
```bash
megahit --presets meta-large -1 R1.fq -2 R2.fq -o output_dir
```

### Memory Management
MEGAHIT automatically detects available RAM, but you can manually cap it (e.g., to 0.9 of total RAM or a specific byte value) to prevent system crashes on shared nodes:
```bash
megahit -m 0.9 -1 R1.fq -2 R2.fq -o output_dir  # Use 90% of available RAM
```

### Low-Coverage Optimization
If sequencing depth is low, the initial graph construction can be memory-intensive. Use `--kmin-1pass` to reduce memory usage during the first k-mer iteration:
```bash
megahit --kmin-1pass -1 R1.fq -2 R2.fq -o output_dir
```

### Workflow Continuity
If a job is interrupted (e.g., due to power failure or wall-time limits), resume it using the `--continue` flag pointing to the existing output directory:
```bash
megahit --continue -o output_dir
```

## Output Interpretation

The primary result is located at `output_dir/final.contigs.fa`. 

Intermediate files of interest:
- `intermediate_contigs/k[k-mer_size].contig.fa`: Contigs generated at specific k-mer iterations.
- `megahit.log`: Detailed runtime information and statistics for each k-mer step.

To convert intermediate contigs to FASTG format for visualization:
```bash
megahit_core contig2fastg [k_size] intermediate_contigs/k[k_size].contig.fa > k[k_size].fastg
```

## Reference documentation
- [MEGAHIT GitHub Repository](./references/github_com_voutcn_megahit.md)
- [MEGAHIT Wiki](./references/github_com_voutcn_megahit_wiki.md)
- [Bioconda MEGAHIT Overview](./references/anaconda_org_channels_bioconda_packages_megahit_overview.md)