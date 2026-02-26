---
name: mirdeep2
description: miRDeep2 identifies and quantifies known and novel microRNA genes from high-throughput small RNA sequencing data by analyzing genomic alignments and RNA secondary structures. Use when user asks to identify novel miRNAs, quantify miRNA expression, map small RNA reads to a reference genome, or process deep sequencing data for miRNA discovery.
homepage: https://www.mdc-berlin.de/8551903/en/research/research_teams/systems_biology_of_gene_regulatory_elements/projects/miRDeep
---


# mirdeep2

## Overview
The miRDeep2 pipeline is a specialized suite of tools designed to identify microRNA genes from high-throughput sequencing data. It functions by aligning small RNA reads to a reference genome and evaluating the secondary structure and energetic stability of the surrounding genomic regions. By modeling the Dicer processing signature, it can distinguish genuine miRNAs from other small RNAs with high sensitivity and specificity.

## Core Workflow and CLI Patterns

### 1. Preprocessing Reads
Before discovery, reads must be formatted and collapsed. Use `mapper.pl` to process raw fastq files.
- **Collapse reads**: `mapper.pl reads.fastq -e -h -m -s reads_collapsed.fa`
- **Map to genome**: `mapper.pl reads_collapsed.fa -p genome_index -t reads_vs_genome.arf`
- *Tip*: Ensure your read IDs are unique and contain the abundance information (e.g., `>seq_1_x42`) as miRDeep2 relies on this for scoring.

### 2. miRNA Discovery and Quantification
The primary analysis is executed via the `miRDeep2.pl` script.
- **Basic Command**:
  `miRDeep2.pl reads.fa genome.fa reads_vs_genome.arf mature_ref.fa other_mature.fa precursors.fa`
- **Parameters**:
  - `mature_ref.fa`: Known miRNAs for the species being analyzed.
  - `other_mature.fa`: Known miRNAs from related species (improves discovery).
  - `precursors.fa`: Known precursors for the species.

### 3. Quantifying Known miRNAs
If you only need to quantify expression of existing annotations without novel discovery, use `quantifier.pl`.
- `quantifier.pl -p precursors.fa -m mature.fa -r reads.fa -t species_code`

## Expert Tips and Best Practices
- **Species Codes**: Always use the 3-letter miRBase species code (e.g., `hsa` for human, `mmu` for mouse) to ensure proper cross-referencing.
- **ARF Format**: The `.arf` format is specific to miRDeep2. If mapping with Bowtie manually, you must convert the output using the provided conversion scripts in the miRDeep2 bin directory.
- **Scoring Thresholds**: The miRDeep2 score represents the log-odds ratio of a biological miRNA vs. a background model. A score of 0 is often used as a cutoff, but for high-stringency novel discovery, consider scores >4.
- **Structure Validation**: Always check the `result.html` output. Genuine miRNAs should show a clear "star" sequence and a consistent 2nt 3' overhang in the hairpin processing diagram.

## Reference documentation
- [mirdeep2 Overview](./references/anaconda_org_channels_bioconda_packages_mirdeep2_overview.md)