---
name: seq-seq-pan
description: seq-seq-pan is a bioinformatics workflow for sequential whole-genome alignment and the construction of pan-genome data structures. Use when user asks to perform whole-genome alignment, split pangenome alignments, extract specific genomic subregions, or map coordinates and annotations across genomes.
homepage: https://gitlab.com/chrjan/seq-seq-pan
---

# seq-seq-pan

## Overview

seq-seq-pan is a bioinformatics workflow designed for the sequential alignment of genomic sequences to construct a pan-genome data structure. It facilitates whole-genome alignment (WGA) by adding sequences one-by-one, internally utilizing tools like progressiveMauve. The tool is particularly effective for comparative genomics tasks, such as creating a consensus sequence from multiple related genomes, mapping annotations across different coordinate spaces, and extracting specific loci from complex alignments.

## Core Command Patterns

### Whole Genome Alignment (WGA)
The primary entry point for building the pangenome.
```bash
seq-seq-pan wga -f <input_fasta_list> -o <output_directory>
```
*   **Note**: This process generates a critical `xxx_genomedescription.txt` file required for most downstream subcommands.

### Splitting the Pangenome
Used to divide the pangenome alignment, typically by chromosome or contig.
```bash
seq-seq-pan split -x <alignment.xmfa> -g <genome_description.txt> -o <output_dir>
```
*   **Genome Description Format**: A tab-separated file containing: `Genome_ID`, `Sequence_Name`, and `Length`.
*   **Expert Tip**: The `Genome_ID` is an integer representing the order in which the genome was added during the WGA step (1, 2, 3...).

### Extracting Subregions
Extract specific genomic intervals from the alignment (including the consensus).
```bash
seq-seq-pan extract -x <alignment.xmfa> -g <genome_description.txt> -p <output_path> -n <output_name> -e <sequence_id>:<start>-<end>
```
*   **Example**: `-e Herato1001:4600000-4750000`

### Coordinate Mapping
Map coordinates or annotations from a specific genome to the consensus coordinate space.
```bash
# Map specific coordinates
seq-seq-pan map -c <consensus.fasta> -p <output_path> -n <output_name> -i <consensus.fasta.idx>

# Map all coordinates of the consensus to selected genomes
seq-seq-pan mapall -c <consensus.fasta> -g <genome_list> -o <output_dir>
```

## Best Practices and Troubleshooting

*   **Input Validation**: Always verify that input FASTA files are not empty before starting the `wga` process. `progressiveMauve` (used internally) may hang indefinitely when encountering empty files.
*   **Sequence Naming**: Internally, the tool may rename sequences to integers (1, 2, 3) in the XMFA file. Always refer to the `genomedescription.txt` to map these IDs back to your original chromosome or contig names.
*   **Consensus Generation**: Use `seq-seq-pan-consensus` to generate a fasta sequence representing the combined pangenome. Note that the consensus is a combination of all sequences; if sequences do not overlap at the borders, the consensus may not be split into Locally Collinear Blocks (LCBs) unless the `split` function is applied.
*   **Visualization**: Alignments produced in XMFA format can be visualized using standard comparative genomics viewers like Mauve.



## Subcommands

| Command | Description |
|---------|-------------|
| seqseqpan.py | A tool for pan-genome analysis and sequence manipulation. |
| seqseqpan.py | A tool for pan-genome analysis and sequence alignment manipulation. |
| seqseqpan.py | A tool for pan-genome analysis and sequence processing. |
| seqseqpan.py | A tool for pan-genome analysis. Note: 'only' is not a valid subcommand; valid subcommands include blockcountsplit, extract, join, maf, map, mapall, merge, realign, reconstruct, remove, resolve, separate, split, and xmfa. |
| seqseqpan.py | A tool for pangenome analysis and sequence manipulation. |
| seqseqpan.py blockcountsplit | Split XMFA of 2 genomes into 3 XMFA files: blocks with both genomes and genome-specific blocks for each genome. |
| seqseqpan.py extract | Extract sequence for whole genome or genomic interval. |
| seqseqpan.py join | Join LCBs from 2 XMFA files, assigning genome_ids as in first XMFA file (-x). |
| seqseqpan.py maf | Write MAF file from XMFA file. |
| seqseqpan.py map | Map positions/coordinates from consensus to sequences, between sequences, ... |
| seqseqpan.py mapall | Map all positions/coordinates from consensus to sequences |
| seqseqpan.py merge | Add small LCBs to end or beginning of surrounding LCBs. Can only be used with two aligned sequences. |
| seqseqpan.py realign | Realign sequences of LCBs around consecutive gaps. Can only be used with two aligned sequences. |
| seqseqpan.py reconstruct | Build alignment of all genomes from .XMFA file with new genome aligned to consensus sequence. |
| seqseqpan.py remove | Remove a genome from all LCBs in alignment. |
| seqseqpan.py resolve | Resolve LCBs stretching over delimiter sequences. |
| seqseqpan.py separate | Separate small multi-sequence LCBs to form genome specific entries. |
| seqseqpan.py split | Split LCBs according to chromosome annotation. |
| seqseqpan.py xmfa | Write XMFA file from XMFA file (for reordering or checking validity). |

## Reference documentation
- [Main Project Page](./references/gitlab_com_chrjan_seq-seq-pan.md)
- [README and Usage](./references/gitlab_com_chrjan_seq-seq-pan_-_blob_master_README.md)
- [Release Notes and Feature Updates](./references/gitlab_com_chrjan_seq-seq-pan_-_releases.md)