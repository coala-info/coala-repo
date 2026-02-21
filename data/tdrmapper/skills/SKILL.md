---
name: tdrmapper
description: tDRmapper is a specialized bioinformatics pipeline designed to address the unique alignment challenges posed by tRNA-derived RNAs, which often contain modifications or fragments that confound general-purpose aligners.
homepage: https://github.com/sararselitsky/tDRmapper
---

# tdrmapper

## Overview
tDRmapper is a specialized bioinformatics pipeline designed to address the unique alignment challenges posed by tRNA-derived RNAs, which often contain modifications or fragments that confound general-purpose aligners. It employs a tiered mapping strategy—starting with exact matches and progressing through specific mismatch and deletion thresholds—to provide accurate quantification and naming of tDR species. It is optimized for trimmed, single-end Illumina small RNA-seq data.

## Core Workflow
The primary entry point is the `TdrMappingScripts.pl` wrapper script, which orchestrates quality filtering, multi-stage mapping, and R-based visualization.

### Standard Execution
To run the full pipeline on human data:
```bash
perl Scripts/TdrMappingScripts.pl hg19_mature_and_pre.fa trimmed_reads.fastq
```

### Tiered Mapping Logic
The tool executes the following sequence. Understanding this helps in interpreting the `*.mapped` output:
1. **Quality Filter**: Filters positions based on Phred 33.
2. **Exact Match**: Initial mapping of high-quality reads.
3. **1 Mismatch**: Mapping remaining unmapped reads with one substitution.
4. **1 Deletion**: Mapping remaining reads with a single gap.
5. **2 Mismatches**: Mapping remaining reads with two substitutions.
6. **2 Deletions**: Mapping remaining reads with two gaps.
7. **3bp Deletion**: Final mapping tier for 3-base consecutive gaps.

## Key Outputs
*   **`*.speciesInfo.txt`**: The primary quantification result. Contains parent tRNA names, assigned tDR species, and quantification metrics.
*   **`*.mapped`**: Detailed alignment file. Columns include read count, length, sequence, error type (mismatch/deletion), and the specific genomic position of the alteration.
*   **`*.top50_tdr.pdf`**: Visual representation of the most highly expressed tDRs from mature tRNAs.
*   **`*.covg.txt`**: Raw coverage data used for generating plots, useful for custom downstream analysis in R.

## Expert Tips and Best Practices
*   **Input Preparation**: Reads **must** be adapter-trimmed before running tDRmapper. The tool is specifically designed for single-end 50bp reads.
*   **Intermediate File Retention**: By default, the script runs `rm $file.hq_cs.*not*` to clean up intermediate mapping files. If you need to troubleshoot why specific reads are not mapping, comment out the cleanup line in `Scripts/TdrMappingScripts.pl`.
*   **Custom Species**: While human (hg19), mouse (mm10), and rat (rn5) references are provided, you can support other species by following the logic in `makeMm10Fasta`. Ensure your source tRNA sequences are from a reliable version of GtRNAdb.
*   **Quantification Interpretation**: The "quantification" column in `speciesInfo.txt` represents the percentage of tRNA-derived reads mapping to that specific tRNA, adjusted by the proportion of maximum coverage.

## Reference documentation
- [tDRmapper README](./references/github_com_sararselitsky_tDRmapper.md)