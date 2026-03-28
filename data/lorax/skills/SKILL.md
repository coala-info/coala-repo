---
name: lorax
description: Lorax is a specialized toolbox for identifying and extracting read evidence for complex structural rearrangements and pan-genome graph operations in long-read sequencing data. Use when user asks to identify templated insertion threads, analyze telomere-associated rearrangements, select reads for targeted amplicon assembly, or manipulate GFA and GAF files.
homepage: https://github.com/tobiasrausch/lorax
---

# lorax

## Overview

Lorax is a specialized toolbox designed for the targeted analysis of long-read sequencing data. While it is not a general-purpose structural variant (SV) caller, it excels at identifying and extracting the underlying read evidence for complex rearrangements that are often missed by standard pipelines. It provides specific workflows for identifying templated insertion threads, analyzing telomere-associated SVs, and selecting reads for targeted amplicon assembly. Additionally, Lorax supports pan-genome workflows, allowing users to manipulate GFA files, convert graph alignments to BAM format, and calculate node coverage.

## Common CLI Patterns

### Templated Insertion Analysis
Identify source sequences and adjacencies for templated insertions.
```bash
# Identify threads using a control and tumor BAM
lorax tithreads -g reference.fa -o output.bed -m control.bam tumor.bam

# Visualize the resulting graph
cut -f 4,9 output.bed | sed -e '1s/^/graph {\n/' | sed -e '$a}' > graph.dot
dot -Tpdf graph.dot -o insertions.pdf
```

### Telomere Rearrangements
Cluster reads into telomere junctions for local assembly.
```bash
# Analyze telomere-associated SVs (T2T reference recommended)
lorax telomere -g chm13.fa -o telomere_out tumor.bam
```
*Tip: Use the reference maps provided in the `maps/` directory of the source to filter common mis-mapping artifacts.*

### Targeted Amplicon Assembly
Extract reads belonging to specific amplicons using phased variants.
```bash
# Select reads based on amplicon regions and phased VCF
lorax amplicon -g reference.fa -s sample_id -v phased.bcf -b regions.bed tumor.bam

# Extract the actual FASTA sequences for the selected reads
# Note: Use -a if the read list contains hashes (standard output from 'amplicon')
tail -n +2 output.reads | cut -f 1 | sort | uniq > reads.lst
lorax extract -a -g reference.fa -r reads.lst tumor.bam
```

### Pan-Genome Graph Operations
Work with GFA (Graphical Fragment Assembly) and GAF (Graph Alignment Format) files.
```bash
# Convert GAF alignments to BAM
lorax convert -g pangenome.gfa.gz -f reads.fastq.gz alignments.gaf.gz | samtools sort -o graph_aligned.bam -

# Calculate node coverage
lorax ncov -g pangenome.gfa.gz alignments.gaf.gz > coverage.tsv

# Visualize a subgraph
lorax gfa2dot -s sample_id -r 3 pangenome.gfa.gz > subgraph.dot
dot -Tpng subgraph.dot > subgraph.png
```

## Expert Tips and Best Practices

*   **Reference Selection**: For the `telomere` subcommand, always prefer a Telomere-to-Telomere (T2T) assembly like CHM13 over GRCh38 to minimize false positives caused by incomplete telomeric sequences in older references.
*   **Read Extraction**: The `extract` subcommand is highly efficient for pulling specific read evidence out of massive BAM files once Lorax has identified the relevant read IDs or hashes.
*   **Graph Visualization**: Lorax subcommands often output BED files where specific columns represent graph edges. Use the `dot` utility from the Graphviz package to transform these into visual representations of complex rearrangements.
*   **SV Calling Distinction**: Do not use Lorax for primary SV calling (e.g., finding simple deletions or inversions). Use a dedicated caller like Delly for discovery, then use Lorax to resolve the complex structure of the identified variants.



## Subcommands

| Command | Description |
|---------|-------------|
| lorax amplicon | Amplicon analysis tool |
| lorax extract | Extracts reads from a BAM file based on a list of reads and a reference genome. |
| lorax repeat | Finds tandem repeats in a reference genome. |
| lorax telomere | Identify telomeric repeats in BAM or FASTA files. |
| lorax tithreads | Tells you the ploidy of a tumor sample based on its BAM file. |
| lorax_pct | Calculate and output statistics about the alignment of a sample to a reference genome or pan-genome graph. |

## Reference documentation
- [Lorax GitHub README](./references/github_com_tobiasrausch_lorax_blob_main_README.md)
- [Lorax Repository Overview](./references/github_com_tobiasrausch_lorax.md)
- [Lorax Dockerfile (Environment/Dependencies)](./references/github_com_tobiasrausch_lorax_blob_main_Dockerfile.md)