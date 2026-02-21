---
name: phylocsfpp
description: PhyloCSF++ is a high-performance implementation of the PhyloCSF method, designed to distinguish protein-coding from non-coding regions by analyzing evolutionary signatures in multiple sequence alignments (MSA).
homepage: https://github.com/cpockrandt/PhyloCSFpp
---

# phylocsfpp

## Overview

PhyloCSF++ is a high-performance implementation of the PhyloCSF method, designed to distinguish protein-coding from non-coding regions by analyzing evolutionary signatures in multiple sequence alignments (MSA). It is particularly useful for validating gene annotations, identifying novel open reading frames (ORFs), and generating visualization tracks for genome browsers. The tool supports several pre-computed phylogenetic models (e.g., mammals, birds, insects) and provides workflows for both genome-wide analysis and targeted feature annotation.

## Core CLI Workflows

### 1. Building Genome Browser Tracks
Use this to generate WIG files representing coding potential across a genome.

```bash
# Basic track generation
phylocsf++ build-tracks 58mammals input_alignments.maf

# Recommended: Smoothened tracks (Posterior Probabilities)
# Requires genome length and a list of known coding exons for HMM training
phylocsf++ build-tracks \
    --output-phylo 1 \
    --genome-length 3272116950 \
    --coding-exons known_cds.txt \
    58mammals input.maf
```

### 2. Scoring Specific Alignments
Use this to evaluate the coding potential of a specific MSA file.

```bash
# Score using Maximum Likelihood Estimation (default)
phylocsf++ score-msa 58mammals alignment.maf

# Use fixed_mean for easier interpretation (scores in interval [-15, +15])
phylocsf++ score-msa --strategy fixed_mean 58mammals alignment.maf
```

### 3. Annotating GFF/GTF Files
There are two primary ways to add PhyloCSF scores to existing gene annotations.

**Option A: Using precomputed BigWig tracks**
```bash
# Requires all 6 frame tracks (+1, +2, +3, -1, -2, -3) in the same directory
phylocsf++ annotate-with-tracks /path/to/PhyloCSF+1.bw genes.gff
```

**Option B: Using MMseqs2 (On-the-fly alignment)**
```bash
# Aligns CDS features against a list of genomes before scoring
phylocsf++ annotate-with-mmseqs genomes_list.txt 58mammals genes.gff
```

## Expert Tips and Best Practices

*   **Alignment Requirements**: Input MAF files **must be uncompressed**. PhyloCSF++ uses memory mapping for performance, which is incompatible with `.gz` files or process substitution (e.g., `<(gunzip file.maf.gz)`).
*   **Reference Sequence**: The tool always expects the first sequence in an alignment block to be the reference sequence.
*   **Model Selection**: Use `phylocsf++ build-tracks --model-info <model_name>` to see which species are included in a pre-defined model. If your alignment contains only a subset of species, use `--species` to limit the model and significantly speed up computation.
*   **Species Mapping**: If your MAF uses different species identifiers than the model (e.g., `hg38` vs `Human`), provide a tab-separated mapping file using `--mapping mapping.tsv`.
*   **Strand and Frame**: Unlike the original PhyloCSF, the `score-msa` command in PhyloCSF++ only scores the forward strand starting from the first base. To score other frames or the reverse strand, you must manually manipulate the alignment (e.g., remove leading bases or compute the reverse complement).
*   **Preparing Coding Exons**: To generate the `--coding-exons` file required for smoothening, use this `awk` pattern on your GFF:
    ```bash
    awk -F'\t' 'BEGIN { OFS="\t" } ($3 == "CDS") { print $1, $7, $8, $4, $5 }' genes.gff > CodingExons.txt
    ```

## Reference documentation
- [PhyloCSFpp GitHub Repository](./references/github_com_cpockrandt_PhyloCSFpp.md)
- [PhyloCSFpp Wiki and FAQ](./references/github_com_cpockrandt_PhyloCSFpp_wiki.md)