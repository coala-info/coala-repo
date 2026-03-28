---
name: clipcontext
description: CLIPcontext maps RNA-binding protein binding sites between genomic and transcriptomic coordinates to extract sequence contexts and analyze motifs. Use when user asks to map genomic peaks to transcripts, convert transcript coordinates to the genome, identify prominent isoforms, filter for intronic or exon border regions, or search for motifs within sequence contexts.
homepage: https://github.com/BackofenLab/CLIPcontext
---


# clipcontext

## Overview

CLIPcontext is a specialized bioinformatics toolset designed to bridge the gap between genomic and transcriptomic representations of RNA-binding protein (RBP) binding sites. While standard CLIP-seq pipelines often identify peaks in genomic coordinates, CLIPcontext allows researchers to extract the actual transcript sequence context, which may differ significantly from the genomic context due to splicing. It provides a suite of utilities to handle coordinate conversions, filter for specific regions like introns or exon borders, and analyze motif frequencies across different sequence contexts.

## Core Operating Modes

The tool is invoked using the base command `clipcontext <mode> [options]`.

### Coordinate Mapping
- **G2T (Genome to Transcript)**: Maps genomic RBP binding regions to the transcriptome. Use this to retrieve sequences with authentic transcript context.
- **T2G (Transcript to Genome)**: Maps transcript-based binding sites back to genomic coordinates, handling both full and split matches (across exon borders).

### Transcript & Region Management
- **LST**: Generates a list of "prominent" transcripts per gene from a GTF file based on GENCODE basic status, Transcript Support Level (TSL), and length.
- **INT**: Filters input sites to return only those overlapping with intronic regions.
- **EXB**: Extracts binding regions located near exon borders for targeted downstream analysis.
- **EIR**: Creates BED files containing exon and intron regions for a specific list of transcript IDs.

### Sequence Analysis
- **MTF**: Searches for motifs or regular expressions within extracted sequences. It can compare motif frequencies between genomic and transcript contexts or search the entire transcriptome and map hits back to the genome.

## CLI Usage Patterns

### Mapping Genomic Peaks to Transcriptome (G2T)
To map genomic sites to transcripts and extract sequences, use the following pattern:
```bash
clipcontext g2t --in sites.bed --out output_dir --tr transcript_list.txt --gtf annotations.gtf --gen genome.2bit
```
*   `--in`: 6-column BED file of genomic regions.
*   `--tr`: List of target transcript IDs (often generated via `LST` mode).
*   `--gen`: Genome sequence in `.2bit` format.

### Identifying Prominent Isoforms (LST)
To create a filtered transcriptome reference for mapping:
```bash
clipcontext lst --gtf annotations.gtf --out prominent_transcripts.txt
```

### Motif Analysis (MTF)
To search for a motif in the output of a G2T/T2G run:
```bash
clipcontext mtf --in g2t_output_folder/ --out motif_results/ --motif "NNGNN"
```

## Expert Tips & Best Practices

- **Input Format**: Ensure your BED files are in strict 6-column format. CLIPcontext relies on the strand information to perform accurate mapping.
- **GTF Compatibility**: The tool is optimized for Ensembl GTF files. If using RefSeq or other sources, verify that the attribute tags (like `transcript_id` and `tsl`) match Ensembl conventions.
- **Sequence Extraction**: You must have `twoBitToFa` and `twoBitInfo` utilities in your system PATH to extract sequences from `.2bit` files.
- **Context Comparison**: When running G2T, compare the resulting genomic vs. transcript FASTA files. Differences in these sequences often highlight binding sites that overlap splice junctions, where the "true" RBP recognition site is only formed after splicing.
- **Memory Management**: For large-scale CLIP-seq datasets, use the `LST` mode first to restrict the search space to one representative transcript per gene, significantly reducing computation time and output noise.



## Subcommands

| Command | Description |
|---------|-------------|
| clipcontext eir | Extracts exon and intron regions from genomic annotations based on transcript sequences. |
| clipcontext exb | CLIP peak regions near exon borders output BED file |
| clipcontext g2t | Map genomic regions to transcripts and extract context sequences. |
| clipcontext mtf | Search for motifs in genomic or transcript sequences. |
| clipcontext_int | CLIP peak regions overlapping with introns output BED file |
| clipcontext_lst | Accept only transcripts with length >= --min-len (default: False) |
| clipcontext_t2g | Processes transcript regions BED file with genomic annotations and sequences to extract context sequences and generate reports. |

## Reference documentation
- [CLIPcontext README](./references/github_com_BackofenLab_CLIPcontext_blob_master_README.md)
- [CLIPcontext Setup and Metadata](./references/github_com_BackofenLab_CLIPcontext_blob_master_setup.py.md)