---
name: mm2plus
description: `mm2plus` is an optimized version of the `minimap2` aligner, specifically engineered to reduce execution time for genomic workflows.
homepage: https://github.com/at-cg/mm2-plus
---

# mm2plus

## Overview
`mm2plus` is an optimized version of the `minimap2` aligner, specifically engineered to reduce execution time for genomic workflows. It achieves significant speedups—up to 7x for genome-to-genome alignments—by implementing parallel chaining, SIMD-accelerated alignment (AVX2/AVX512), and parallel sorting. Because it maintains full command-line compatibility with `minimap2`, it can be integrated into existing bioinformatics pipelines as a direct replacement to improve throughput without changing parameters.

## Common CLI Patterns

### Long-Read Mapping
Map noisy long reads (ONT or PacBio) to a reference genome.
- **Oxford Nanopore:** `mm2plus -ax map-ont ref.fa reads.fq > aln.sam`
- **PacBio HiFi:** `mm2plus -ax map-hifi ref.fa reads.fq > aln.sam`
- **PacBio CLR:** `mm2plus -ax map-pb ref.fa reads.fq > aln.sam`

### Whole-Genome Alignment
Align two assemblies or large genomic sequences.
- **Intra-species (asm5):** `mm2plus -cx asm5 ref.fa query.fa > aln.paf`
- **Inter-species (~5% divergence):** `mm2plus -cx asm10 ref.fa query.fa > aln.paf`
- **Inter-species (~20% divergence):** `mm2plus -cx asm20 ref.fa query.fa > aln.paf`

### Spliced Alignment (RNA-seq)
- **Long-read cDNA:** `mm2plus -ax splice ref.fa rna_reads.fa > aln.sam`
- **Nanopore Direct RNA:** `mm2plus -ax splice -uf -k14 ref.fa reads.fa > aln.sam`

## Expert Tips and Best Practices

### Maximizing Accuracy
For high-precision read alignment that matches `minimap2` (v2.30) exactly, use the following parameter during the chaining phase:
- `--max-chain-skip=1000000`

### Performance Optimization
- **Threading:** Use `-t` to specify the number of threads. `mm2plus` scales efficiently with high thread counts due to its parallelized sorting and chaining algorithms.
- **SIMD Support:** Ensure the host machine supports AVX2 or AVX512 to take full advantage of the accelerated alignment kernels.
- **Indexing:** For large references used repeatedly, create an index file (`.mmi`) first to save time on subsequent runs:
  `mm2plus -d ref.mmi ref.fa`
  `mm2plus -ax map-ont ref.mmi reads.fq > aln.sam`

### Output Formats
- **PAF (Pairwise Mapping Format):** Use `-c` to generate CIGAR strings in the PAF output. This is the default for `-x asm` presets.
- **SAM:** Use `-a` to generate output in SAM format. This is the default for `-x map-*` presets.

## Reference documentation
- [mm2-plus GitHub Repository](./references/github_com_at-cg_mm2-plus.md)
- [mm2plus Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mm2plus_overview.md)