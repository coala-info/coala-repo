---
name: recycler
description: Recycler is a computational tool designed to identify circular genomic elements by analyzing the topology of an assembly graph alongside read coverage and paired-end alignment information.
homepage: https://github.com/Shamir-Lab/Recycler
---

# recycler

## Overview
Recycler is a computational tool designed to identify circular genomic elements by analyzing the topology of an assembly graph alongside read coverage and paired-end alignment information. It is particularly effective at "recycling" short or low-coverage contigs into complete circular paths that might otherwise be overlooked in standard linear assemblies. Use this skill to navigate the multi-step preprocessing required for Recycler and to execute the core extraction algorithm.

## Preprocessing Workflow
Recycler requires a specific BAM input containing the best alignment hits for read pairs against the assembly nodes.

1.  **Generate Node FASTA**: Convert the assembly graph (FASTG) into a FASTA file.
    ```bash
    make_fasta_from_fastg.py -g assembly_graph.fastg -o assembly_graph.nodes.fasta
    ```
2.  **Align Reads**: Index the nodes and align your original paired-end reads.
    ```bash
    bwa index assembly_graph.nodes.fasta
    bwa mem assembly_graph.nodes.fasta R1.fastq.gz R2.fastq.gz | samtools view -buS - > reads_pe.bam
    ```
3.  **Filter and Sort**: Recycler performs best with primary alignments.
    ```bash
    # Filter for primary alignments (remove 0x0800)
    samtools view -bF 0x0800 reads_pe.bam > reads_pe_primary.bam
    samtools sort reads_pe_primary.bam -o reads_pe_primary.sort.bam
    samtools index reads_pe_primary.sort.bam
    ```

## Core Usage Patterns

### For Metagenomes or Plasmidomes
The default mode is optimized for complex samples where multiple circular elements may exist at varying coverages.
```bash
recycle.py -g assembly_graph.fastg -k 55 -b reads_pe_primary.sort.bam
```

### For Isolate Assemblies
If the data comes from a single isolated strain, enable the isolate flag to improve accuracy.
```bash
recycle.py -g assembly_graph.fastg -k 55 -b reads_pe_primary.sort.bam -i True
```

## Parameter Tuning
*   **-k (Max K-mer)**: This must match the maximum k-mer length used during the assembly process (e.g., if SPAdes ran with `-k 21,33,55`, use `55`).
*   **-l (Minimum Length)**: By default, sequences shorter than 1000bp are ignored. Decrease this for very small plasmids or increase it to filter noise.
*   **-m (Max CV)**: The Coefficient of Variation threshold (default 0.5). Higher values are less restrictive, allowing for more variation in coverage along a circular path.

## Output Interpretation
*   **<prefix>.cycs.fasta**: Contains the final predicted circular sequences.
*   **<prefix>.cycs.paths_w_cov.txt**: Detailed path information. The "node numbers" listed here can be used to highlight and visualize the circular paths in tools like **Bandage**.

## Reference documentation
- [Recycler GitHub Repository](./references/github_com_Shamir-Lab_Recycler.md)
- [Bioconda Recycler Overview](./references/anaconda_org_channels_bioconda_packages_recycler_overview.md)