---
name: lorax
description: Lorax is a specialized toolkit for long-read genomic analysis, designed to handle the complexities of tumor heterogeneity and aneuploidy where standard de novo assembly often fails.
homepage: https://github.com/tobiasrausch/lorax
---

# lorax

## Overview
Lorax is a specialized toolkit for long-read genomic analysis, designed to handle the complexities of tumor heterogeneity and aneuploidy where standard de novo assembly often fails. It provides a targeted approach to identify complex genomic structures such as chromothripsis, templated insertions, and telomere fusions. While it is not a general-purpose SV caller (for which `delly` is recommended), it excels at extracting and organizing reads associated with specific complex rearrangements for downstream assembly or visualization.

## Command Line Usage and Patterns

### Templated Insertion Analysis
To identify nodes and edges of templated insertion source sequences:
```bash
lorax tithreads -g reference.fa -o output.bed -m control.bam tumor.bam
```
*   **Visualization**: Convert the resulting BED file to DOT format for Graphviz:
    ```bash
    cut -f 4,9 output.bed | sed -e '1s/^/graph {\n/' | sed -e '$a}' > output.dot
    dot -Tpdf output.dot -o output.pdf
    ```

### Telomere Rearrangements
Identify telomere-associated structural variants. It is highly recommended to use a Telomere-to-Telomere (T2T) assembly as the reference.
```bash
lorax telomere -g t2t.fa -o out_prefix tumor.bam
```
*   **Tip**: Use the provided artifact maps in the `maps/` directory of the source to filter common mis-mapping artifacts found in normal samples.

### Targeted Amplicon Assembly
Extract reads for specific amplicons using a phased VCF to maintain haplotype integrity:
```bash
lorax amplicon -g reference.fa -s sample_name -v phased.bcf -b amplicons.bed tumor.bam
```
*   The output `out.reads` contains a hash list of selected reads.
*   The output `out.bed` provides a diagnostic table of amplicon regions and split-read support.

### Read Extraction
To extract FASTA sequences for reads identified by the `tithreads` or `amplicon` subcommands:
```bash
# Use -a if the read list contains hashes (standard for amplicon/tithreads output)
lorax extract -a -g reference.fa -r reads.lst tumor.bam
```

### Pan-Genome Graph Operations
Lorax supports several utilities for working with Graphical Fragment Assembly (GFA) and Graph Alignment Format (GAF) files.

*   **Convert GAF to BAM**:
    ```bash
    lorax convert -g pangenome.gfa.gz -f input.fastq.gz sample.gaf.gz | samtools sort -o sample.bam -
    ```
*   **Node Coverage**: Calculate coverage across the pan-genome graph:
    ```bash
    lorax ncov -g pangenome.gfa.gz sample.gaf.gz > ncov.tsv
    ```
*   **Graph Visualization**: Convert a GFA subgraph to DOT:
    ```bash
    lorax gfa2dot -s sample_id -r 3 pangenome.gfa.gz > graph.dot
    ```

## Best Practices
*   **Reference Selection**: For telomere analysis, always prefer T2T references (like CHM13) over standard GRCh38 to reduce false positives in repetitive regions.
*   **Tool Synergy**: Use `lorax` in conjunction with `delly`. Use `delly` for initial SV discovery and `lorax` for deep-dive analysis into complex, multi-junction rearrangements.
*   **Memory Management**: When working with large pan-genome graphs, ensure GFA files are indexed or compressed where supported to optimize I/O.

## Reference documentation
- [Lorax GitHub Repository](./references/github_com_tobiasrausch_lorax.md)
- [Bioconda Lorax Overview](./references/anaconda_org_channels_bioconda_packages_lorax_overview.md)