---
name: pretextmap
description: PretextMap transforms aligned sequence data into compressed genome contact maps for rapid visualization. Use when user asks to convert BAM, CRAM, or pairs files into the pretext format, generate Hi-C contact maps, or filter sequences to improve map resolution.
homepage: https://github.com/wtsi-hpag/PretextMap
metadata:
  docker_image: "quay.io/biocontainers/pretextmap:0.2.3--h9948957_0"
---

# pretextmap

## Overview

PretextMap (Paired REad TEXTure Mapper) is a high-performance utility designed to transform aligned sequence data into genome contact maps. Unlike many Hi-C processing tools that require massive intermediate files, PretextMap is designed to consume data directly from stdin via unix pipes. It outputs a specialized, compressed texture format (.pretext) that is significantly smaller than raw alignment files (typically 30-50MB per map) and is optimized for rapid browsing in the PretextView visualization tool.

## Usage Patterns

### Basic Conversion
PretextMap reads exclusively from stdin. You must pipe your alignment data into the tool and specify an output file using the `-o` flag.

**From BAM/CRAM (via samtools):**
```bash
samtools view -h input.bam | PretextMap -o output.pretext
```
*Note: The `-h` flag is mandatory for SAM/BAM input to ensure the header (contig information) is processed.*

**From Pairs files:**
```bash
zcat input.pairs.gz | PretextMap -o output.pretext
```

**Directly from Aligner:**
```bash
bwa mem [options] ref.fa reads_1.fq reads_2.fq | PretextMap -o output.pretext
```

### Filtering and Quality Control
Use built-in filters to improve map quality and resolution during the conversion process.

*   **Mapping Quality:** Use `--mapq` to set a minimum threshold (default is 10).
    ```bash
    samtools view -h input.bam | PretextMap -o output.pretext --mapq 20
    ```
*   **Sequence Filtering:** Use `--filterInclude` or `--filterExclude` with comma-separated lists to focus on specific contigs. Filtering to fewer sequences increases the effective resolution of the resulting map.
    ```bash
    PretextMap -i input.sam -o output.pretext --filterInclude "chr1,chr2,chr3"
    ```

### Sorting and Resolution
*   **Contig Sorting:** By default, contigs are sorted by length in descending order. You can modify this using `--sortby` (length, name, nosort) and `--sortorder` (ascend, descend).
*   **High Resolution:** For use with PretextView version 0.2.5 or later, enable the high-resolution output flag.
    ```bash
    PretextMap -o output.pretext --highRes
    ```

## Expert Tips and Best Practices

1.  **Resource Management:** PretextMap typically requires approximately 3GB of RAM and 2 CPU cores. Ensure these are available to prevent pipe bottlenecks.
2.  **Resolution vs. Sequence Count:** PretextMap maps sequences into a fixed number of bins. If your assembly has thousands of small scaffolds, the resolution for the main chromosomes will be low. Use `--filterInclude` to target only the primary chromosomes for a much sharper contact map.
3.  **Pipe Efficiency:** When processing large BAM files, use `samtools view -@ [threads]` to speed up the decompression before piping to PretextMap.
4.  **Header Validation:** If PretextMap fails immediately, verify that your input stream includes the `@SQ` lines (for SAM) or `#chromsize:` lines (for pairs).

## Reference documentation
- [PretextMap GitHub Repository](./references/github_com_sanger-tol_PretextMap.md)
- [Bioconda PretextMap Overview](./references/anaconda_org_channels_bioconda_packages_pretextmap_overview.md)