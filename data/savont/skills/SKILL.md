---
name: savont
description: Savont processes high-accuracy long-read amplicon sequences to generate exact amplicon sequence variants and estimate taxonomic abundances. Use when user asks to generate ASVs from long-read data, download reference databases, or perform taxonomic classification using the EM algorithm.
homepage: https://github.com/bluenote-1577/savont
metadata:
  docker_image: "quay.io/biocontainers/savont:0.3.2--h3ab6199_0"
---

# savont

## Overview

Savont is a specialized bioinformatics tool designed to bridge the gap between raw long-read amplicon sequences and high-resolution taxonomic abundances. Unlike mapping-only approaches, Savont follows a "Reads -> ASV -> Classification" workflow. It is specifically optimized for reads with >98% accuracy. Its primary strengths lie in its ability to recover exact multi-copy 16S sequences (ASVs) with significantly higher sensitivity than traditional tools like UNOISE3 or DADA2, often requiring as little as 30x depth for reliable detection.

## Core Workflow

### 1. ASV Generation
The `asv` command clusters reads, generates consensus sequences, and filters chimeras.

*   **Standard 16S Full-Length:**
    `savont asv input.fastq.gz -o output_dir -t 20`
*   **Full rRNA Operon:**
    `savont asv operon_reads.fastq.gz -o output_dir -t 20 --rrna-operon`
*   **Single-Stranded Protocols:**
    `savont asv reads.fq --single-strand -o output_dir`
*   **Custom Amplicons:**
    Specify length constraints for non-standard targets:
    `savont asv amplicons.fq.gz --min-read-length 1600 --max-read-length 2100 -o output_dir`

### 2. Database Management
Savont requires specific reference databases for classification. Use the `download` command to retrieve them.

*   **EMU Database:** Best for focused species-level classification.
    `savont download --location ./databases --emu-db`
*   **SILVA Database:** Best for broad coverage of understudied species.
    `savont download --location ./databases --silva-db`

### 3. Taxonomic Classification
Classify the generated ASVs using the Expectation-Maximization (EM) algorithm to handle ambiguous alignments.

*   **Using EMU:**
    `savont classify -i savont-out -o class-out --emu-db databases/emu_default -t 20`
*   **Refining Thresholds:**
    Adjust identity requirements to reduce false positives:
    `savont classify -i savont-out --emu-db databases/emu_default --species-threshold 99.9 --genus-threshold 90.0`

## Expert Tips and Best Practices

*   **Input Quality:** Savont is optimized for high-accuracy reads. Do not use it for ONT R9.4, HAC, or FAST basecalled data, as the error rates will likely lead to poor ASV recovery.
*   **Sensitivity vs. Precision:** Savont is 100-1000x more sensitive than traditional methods at low coverage. However, always inspect the `asv_mappings.tsv` file. ASVs with very low depth (<20 reads) should be treated with caution as they may represent rare taxa or potential artifacts.
*   **Interpreting Abundances:** The `species_abundance.tsv` output uses an EM algorithm to estimate relative abundance. If you see unexpected species (e.g., *Shigella* in a sample where *E. coli* is expected), check the `alignment_identity` in `asv_mappings.tsv` to see if the classification is based on a borderline match.
*   **Resource Allocation:** For large datasets (~1.5M reads), Savont is highly efficient. Using 40 threads is recommended for optimal performance during the clustering and polishing phases.



## Subcommands

| Command | Description |
|---------|-------------|
| savont asv | Cluster long reads of >~ 98% accuracy into ASVs (Amplicon Sequence Variants) |
| savont download | Download reference databases for savont (EMU or SILVA) |
| savont_classify | Classify ASVs against a reference database and generate taxonomy abundance table at species/genus level |

## Reference documentation
- [Savont Main Documentation](./references/github_com_bluenote-1577_savont.md)
- [Savont Preliminary Benchmarks](./references/github_com_bluenote-1577_savont_wiki_Savont-Preliminary-Results.md)