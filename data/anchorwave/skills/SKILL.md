---
name: anchorwave
description: AnchorWave performs sensitive genome-to-genome alignment by identifying conserved anchors and refining them using the wavefront alignment algorithm. Use when user asks to align genomes with high sequence diversity, perform collinear or rearrangement-aware genome alignment, or compare polyploid species.
homepage: https://github.com/baoxingsong/AnchorWave
---


# anchorwave

## Overview
AnchorWave (Anchored Wavefront Alignment) is designed for sensitive genome-to-genome alignment where high sequence diversity or complex structural polymorphisms exist. It operates by identifying conserved anchors—typically full-length coding sequences (CDS) or exons—to establish collinear blocks. These blocks are then refined into shorter intervals for high-sensitivity alignment using the Wavefront Alignment (WFA) algorithm. It is particularly powerful for polyploid species or comparative genomics involving ancient whole-genome duplications where standard alignment tools often fail to maintain collinearity.

## Core Workflow
The standard AnchorWave pipeline requires four primary steps to move from raw genomic data to a final alignment.

### 1. Extract Anchors
Use `gff2seq` to extract the longest full-length CDS or exon for each gene from the reference genome.
```bash
anchorwave gff2seq -i ref.gff3 -r ref.fa -o ref.cds.fa
```
*   **Tip**: Use the `-x` flag if you prefer to use exon records instead of CDS.
*   **Tip**: Ensure the GFF3/GTF matches the reference FASTA chromosome names exactly.

### 2. Lift Over Anchors
Map the extracted anchors to both the reference and query genomes using a splice-aware aligner (minimap2 is recommended).
```bash
# Map to Reference
minimap2 -x splice -t 10 -k 12 -a2 ref.fa ref.cds.fa > ref.sam
# Map to Query
minimap2 -x splice -t 10 -k 12 -a2 query.fa ref.cds.fa > query.sam
```

### 3. Perform Genome Alignment
Choose between `genoAli` (collinear/global) or `proali` (rearrangements/WGD).

**For genomes without major rearrangements (Collinear):**
```bash
anchorwave genoAli -i ref.gff3 -as ref.cds.fa -r ref.fa -a query.sam -ar ref.sam -s query.fa -n output.anchors -o output.maf
```

**For genomes with translocations, fusions, or WGD:**
```bash
anchorwave proali -i ref.gff3 -as ref.cds.fa -r ref.fa -a query.sam -ar ref.sam -s query.fa -n output.anchors -o output.maf
```

## Expert Tips and Best Practices
*   **Algorithm Selection**: Use `genoAli` for closely related species or individuals of the same species where chromosomal synteny is preserved. Use `proali` for inter-species comparisons where translocations or WGD events are expected.
*   **Memory Management**: AnchorWave is memory-intensive. A single thread typically requires ~20GB RAM for diverse genomes. Each additional thread adds approximately 10GB of memory overhead.
*   **Handling Inversions**: If using `genoAli` and inversions are present, use the `-IV` flag to allow the algorithm to identify and align inverted regions.
*   **WGD Parameters**: When using `proali` for polyploid genomes, tune the `-R` (reference duplication) and `-Q` (query duplication) parameters to match the known ploidy levels or duplication history.
*   **Anchor Filtering**: If the alignment is too noisy, increase the `-m` parameter in `gff2seq` to filter out short exons (default is 20bp), which can reduce false-positive anchor matches.
*   **Output Format**: The primary output is in MAF (Multiple Alignment Format). If downstream tools require other formats (like BAM or PAF), use external converters like `bioconvert` or `paftools`.

## Reference documentation
- [AnchorWave Main Documentation](./references/github_com_baoxingsong_AnchorWave.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_anchorwave_overview.md)