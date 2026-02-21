---
name: salsa2
description: SALSA (Simple Assembly Line Scaffolder for Assemblies) is a specialized tool for upgrading fragmented long-read assemblies to chromosome-scale scaffolds using Hi-C proximity ligation data.
homepage: https://github.com/marbl/SALSA
---

# salsa2

## Overview
SALSA (Simple Assembly Line Scaffolder for Assemblies) is a specialized tool for upgrading fragmented long-read assemblies to chromosome-scale scaffolds using Hi-C proximity ligation data. It processes contig sequences alongside Hi-C alignments to determine the relative orientation and order of sequences. Unlike some other scaffolders, SALSA can utilize the underlying assembly graph to resolve ambiguities and can iteratively refine the assembly to minimize errors.

## Pre-processing Requirements
Before running the SALSA pipeline, input files must be formatted specifically:

1.  **Contig Lengths**: Generate a `.fai` file from your assembly FASTA.
    ```bash
    samtools faidx contigs.fasta
    ```
2.  **Hi-C Alignments**: Map reads using BWA or Bowtie2. The resulting BAM must be converted to a BED file and **sorted by read name** (not coordinates).
    ```bash
    bamToBed -i alignment.bam > alignment.bed
    sort -k 4 alignment.bed > alignment_sorted.bed
    ```

## Common CLI Patterns

### Basic Scaffolding
The most common usage requires the assembly, the lengths file, the sorted BED, and the restriction enzyme sequence.
```bash
python run_pipeline.py -a contigs.fasta -l contigs.fasta.fai -b alignment_sorted.bed -e GATC -o output_dir
```

### Scaffolding with Misassembly Correction
To allow SALSA to break contigs where Hi-C data suggests a misassembly, use the `-m` flag.
```bash
python run_pipeline.py -a contigs.fasta -l contigs.fasta.fai -b alignment_sorted.bed -e GATC -m yes -o output_dir
```

### Integrating Assembly Graphs
If your assembler produced a GFA file, providing it helps SALSA navigate repetitive regions and improves scaffolding logic.
```bash
python run_pipeline.py -a contigs.fasta -l contigs.fasta.fai -b alignment_sorted.bed -e GATC -g assembly_graph.gfa -o output_dir
```

### Using DNAse or Omni-C Data
For enzyme-free protocols like Omni-C, use the `DNASE` keyword for the enzyme parameter.
```bash
python run_pipeline.py -a contigs.fasta -l contigs.fasta.fai -b alignment_sorted.bed -e DNASE -o output_dir
```

## Expert Tips and Best Practices
*   **Enzyme Sequences**: The `-e` flag requires the actual recognition sequence (e.g., `GATC` for MboI). If multiple enzymes were used, provide them as a comma-separated list without spaces: `-e GATC,AAGCTT`.
*   **Contig Headers**: Ensure your FASTA headers do not contain colons (`:`), as this can interfere with SALSA's internal parsing.
*   **Iteration Control**: By default, SALSA runs 3 iterations. For highly complex or fragmented genomes, you may want to increase this using `-i`, though returns usually diminish after 5-10 iterations.
*   **Filtering**: If your BED file contains alignments to contigs not present in your FASTA file, use `-f yes` to filter the BED file automatically during the run.
*   **Visualization**: SALSA can output files compatible with Juicebox for manual curation. Check the output directory for `.hic` conversion scripts or files if the `-p yes` option was used to preserve intermediate steps.

## Reference documentation
- [Salsa2 Overview](./references/anaconda_org_channels_bioconda_packages_salsa2_overview.md)
- [SALSA GitHub Documentation](./references/github_com_marbl_SALSA.md)