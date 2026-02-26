---
name: pin_hic
description: pin_hic is a scaffolding tool that uses Hi-C data to orient and order contigs into larger scaffolds. Use when user asks to scaffold a draft assembly, improve genome assemblies using Hi-C reads, or generate scaffolding paths in SAT format.
homepage: https://github.com/dfguan/pin_hic/
---


# pin_hic

## Overview

pin_hic is a scaffolding tool that leverages Hi-C data to orient and order contigs into larger scaffolds. It utilizes a dual selection and local optimal strategy to bridge contigs, producing output in the SAT format—an extension of the GFA format designed to record the scaffolding process. This tool is particularly useful for improving draft assemblies by utilizing the spatial proximity information inherent in Hi-C reads.

## Installation and Dependencies

Install pin_hic via Bioconda or from source. Ensure `bwa` and `samtools` are available in your environment for preprocessing.

```bash
# Conda installation
conda install bioconda::pin_hic

# Source installation
git clone https://github.com/dfguan/pin_hic.git
cd pin_hic/src && make
```

## Preprocessing Hi-C Reads

Before scaffolding, align paired-end Hi-C reads to your draft assembly. Use `bwa mem` with specific flags recommended for Hi-C data.

1. Index the draft assembly:
   `bwa index draft_assembly.fa`

2. Align reads and convert to BAM:
   ```bash
   bwa mem -SP -B10 -t12 draft_assembly.fa read_R1.fq.gz read_R2.fq.gz | samtools view -b - > alignment.bam
   ```
   *Note: The `-SP` and `-B10` flags are critical for proper Hi-C read mapping in the pin_hic workflow.*

## Scaffolding Workflows

### Automated Iterative Scaffolding
Use the `pin_hic_it` wrapper to run multiple rounds of scaffolding automatically.

```bash
samtools faidx draft_assembly.fa
./bin/pin_hic_it -i 3 -x draft_assembly.fa.fai -r draft_assembly.fa -O output_dir *.bam
```
*   `-i`: Number of iterations (default: 3).
*   `-x`: FAI index of the assembly.
*   `-r`: Reference assembly FASTA.
*   `-O`: Output directory.

### Manual Step-by-Step Scaffolding
For finer control, execute the pipeline stages manually:

1. **Calculate Contact Matrix**:
   `./bin/pin_hic link -s initial.sat *.bam > link.matrix`
   *(Use `-c assembly.fai` instead of `-s` if starting from a raw assembly)*

2. **Build Scaffolding Graph**:
   `./bin/pin_hic build -w100 -k3 -s initial.sat link.matrix > scaffolds.sat`

3. **Detect Mis-joins**:
   `./bin/pin_hic break scaffolds.sat *.bam > scaffolds_broken.sat`

4. **Extract Sequences**:
   `./bin/pin_hic gets -c draft_assembly.fa scaffolds_broken.sat > final_scaffolds.fa`

## SAT Output Format

The SAT format extends GFA 1.0 to record scaffolding paths. Key record types include:
*   **S (Sequence)**: Contig name and length.
*   **L (Link)**: Connection between contig ends with weights.
*   **P (Path)**: Ordered list of contigs forming a scaffold.
*   **A (Scaffold Set)**: Collection of paths.
*   **C (Current)**: The active scaffold set name.

## Best Practices

*   **Mapping Quality**: Ensure high-quality alignments; the tool typically expects a minimum mapping quality (default often 10) to trust Hi-C links.
*   **Iteration Count**: Three iterations are generally sufficient for most assemblies to converge.
*   **Resource Management**: When running `pin_hic link`, ensure sufficient memory is available for the contact matrix, especially for highly fragmented assemblies.
*   **Input Order**: When providing multiple BAM files, ensure they are all mapped to the same version of the assembly used in the current iteration.

## Reference documentation
- [pin_hic GitHub Repository and Usage Guide](./references/github_com_dfguan_pin_hic.md)
- [Bioconda pin_hic Package Overview](./references/anaconda_org_channels_bioconda_packages_pin_hic_overview.md)