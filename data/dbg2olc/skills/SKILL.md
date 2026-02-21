---
name: dbg2olc
description: DBG2OLC (De Bruijn Graph to Overlap-Layout-Consensus) is a hybrid assembly framework designed to overcome the high error rates of third-generation sequencing (3GS) technologies.
homepage: https://github.com/yechengxi/DBG2OLC
---

# dbg2olc

## Overview
DBG2OLC (De Bruijn Graph to Overlap-Layout-Consensus) is a hybrid assembly framework designed to overcome the high error rates of third-generation sequencing (3GS) technologies. It works by first assembling short, accurate reads into contigs and then using these contigs to "anchor" and organize long, erroneous reads. This approach significantly reduces the computational resources required for large genome assembly compared to pure long-read OLC methods.

## Core Workflow and CLI Patterns

The standard pipeline consists of three primary stages: NGS contig assembly, hybrid overlap/layout, and consensus calling.

### 1. NGS Contig Assembly (SparseAssembler)
Before running DBG2OLC, you must generate raw contigs from short reads. It is critical to use raw de Bruijn graph (DBG) contigs without heuristics like gap closing or scaffolding, as these can introduce errors that propagate through the hybrid assembly.

```bash
# Basic SparseAssembler command
SparseAssembler LD 0 k 51 g 15 NodeCovTh 1 EdgeCovTh 0 GS <genome_size> f <short_reads.fastq>
```

*   **LD 0**: Start a new assembly (use `LD 1` to load existing k-mer data for fine-tuning).
*   **k**: K-mer size (e.g., 51).
*   **g**: Skip size (e.g., 15).
*   **NodeCovTh/EdgeCovTh**: Coverage thresholds for cleaning the graph. For ~50x coverage, use `NodeCovTh 1` and `EdgeCovTh 0`.

### 2. Hybrid Overlap and Layout (DBG2OLC)
This is the core step where long reads are aligned to the NGS contigs (typically `Contigs.txt` from SparseAssembler).

```bash
# Basic DBG2OLC command
DBG2OLC k 17 AdaptiveTh 0.0001 KmerCovTh 2 MinOverlap 20 RemoveChimera 1 Contigs Contigs.txt f <long_reads.fasta>
```

*   **k**: K-mer size for matching (17 is generally recommended).
*   **AdaptiveTh**: The adaptive k-mer matching threshold. A contig is used as an anchor only if matched k-mers > `AdaptiveTh * Contig_Length`.
*   **KmerCovTh**: Fixed k-mer matching threshold.
*   **MinOverlap**: Minimum overlap score between long reads.
*   **RemoveChimera**: Set to 1 to filter chimeric reads (recommended if coverage > 10x).

### 3. Consensus Calling (Sparc)
After DBG2OLC produces the `backbone_raw.fasta` and `DBG2OLC_Consensus_info.txt`, use a consensus tool like Sparc to generate the final polished sequence.

```bash
# Sparc requires the backbone and the original reads/contigs
Sparc b backbone_raw.fasta c Contigs.txt f long_reads.fasta i DBG2OLC_Consensus_info.txt k 1 -g 1 -o final_assembly
```

## Parameter Tuning for 3GS Coverage

Assembly quality is highly sensitive to the relationship between NGS contig length and 3GS coverage.

| Coverage | KmerCovTh | MinOverlap | AdaptiveTh |
| :--- | :--- | :--- | :--- |
| **10x - 20x** | 2 - 5 | 10 - 30 | 0.001 - 0.01 |
| **50x - 100x** | 2 - 10 | 50 - 150 | 0.01 - 0.02 |

**High Coverage (>100x) Adjustments:**
*   Set `ChimeraTh 2` and `ContigTh 2` to apply more stringent filtering during multiple alignment.

## Best Practices
*   **Read Selection**: If the dataset is extremely large, use the `SelectLongestReads` utility to subset the longest reads for the assembly to save time without sacrificing N50.
*   **Avoid Scaffolding**: Never use "finished" or "scaffolded" NGS contigs as input. DBG2OLC relies on the simplicity of raw DBG contigs to accurately anchor long reads.
*   **Validation**: Check the `backbone_raw.fasta` N50 before proceeding to the consensus step. If the N50 is low, iterate on the `MinOverlap` and `AdaptiveTh` parameters in Step 2.

## Reference documentation
- [DBG2OLC GitHub Repository](./references/github_com_yechengxi_DBG2OLC.md)
- [Bioconda dbg2olc Package Overview](./references/anaconda_org_channels_bioconda_packages_dbg2olc_overview.md)