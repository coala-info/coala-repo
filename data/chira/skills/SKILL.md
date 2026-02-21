---
name: chira
description: ChiRA (Chimeric Read Annotator) is a specialized framework designed to process and analyze chimeric RNA reads generated from interactome mapping experiments.
homepage: https://github.com/pavanvidem/chira/
---

# chira

## Overview

ChiRA (Chimeric Read Annotator) is a specialized framework designed to process and analyze chimeric RNA reads generated from interactome mapping experiments. It handles the complex task of identifying which parts of a single sequencing read originate from different RNA molecules. The workflow moves from raw FASTQ data through deduplication and mapping to the final extraction of statistically supported interactions and chimeric alignments.

## Core Workflow and CLI Patterns

### 1. Read Deduplication
Use `chira_collapse.py` to remove PCR duplicates. This tool is essential for maintaining accurate quantification by tracking unique molecular identifiers (UMIs) or simple read counts.

```bash
chira_collapse.py -i input.fastq -o collapsed.fasta
```
*   **Input**: Quality and adapter-trimmed FASTQ.
*   **Output**: FASTA where headers follow the format `>sequence_id|UMI|read_count`.

### 2. Transcriptome Mapping
Use `chira_map.py` to align collapsed reads to your reference.

```bash
chira_map.py -i collapsed.fasta -r reference_transcriptome.fasta -o alignments.bed
```
*   **Alignment Tools**: Supports `bwa-mem` (default) and `CLAN`.
*   **Split-Reference**: If using a split reference, provide the second FASTA with the appropriate flag.

### 3. Locus Definition and Merging
Use `chira_merge.py` to define read-concentrated loci (CRLs) by merging overlapping alignments.

```bash
chira_merge.py -i alignments.bed -g annotation.gtf -f reference_transcriptome.fasta -o merged.bed
```
*   **Genomic Conversion**: If a GTF is provided, transcriptomic positions are converted to genomic coordinates before merging.
*   **Output**: A BED file where the 4th column contains merged alignments and the 5th column contains read counts.

### 4. Quantification
Use `chira_quantify.py` to calculate the abundance of the defined loci.

```bash
chira_quantify.py -i alignment_segments.bed -m merged.bed -o quantified_loci.tab
```
*   **Metric**: Produces TPM (Transcripts Per Million) values for the chimeric loci.

### 5. Interaction Extraction
Use `chira_extract.py` to identify the best chimeric candidates and detect RNA-RNA interactions.

```bash
chira_extract.py -i quantified_loci.tab -g annotation.gff -f reference.fasta -o interactions.tab
```
*   **Hybridization**: Optionally hybridizes loci where chimeric arms map to confirm interaction potential.
*   **Reference Note**: If alignments were merged at the genomic level in the previous step, ensure you provide a genomic FASTA file here.

## Expert Tips and Best Practices

*   **Input Quality**: Always perform adapter trimming and quality filtering before starting the ChiRA pipeline, as `chira_collapse.py` expects clean FASTQ input.
*   **Scoring Scheme**: Note that in version 1.4.1+, the scoring scheme changed from addition to multiplication, resulting in a final combined score between 0 and 1.
*   **Memory Management**: For large datasets, monitor memory usage during the `chira_collapse.py` and `chira_merge.py` steps, as these handle high volumes of read information.
*   **Spliced Alignments**: In version 1.4.3+, spliced alignments are sorted before iteration to ensure deterministic results, avoiding the arbitrary selection seen in earlier versions.
*   **IntaRNA Integration**: When using `chira_extract.py`, you can pass additional IntaRNA parameters to fine-tune the hybridization prediction between chimeric arms.

## Reference documentation

- [ChiRA GitHub Repository](./references/github_com_pavanvidem_chira.md)
- [ChiRA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_chira_overview.md)