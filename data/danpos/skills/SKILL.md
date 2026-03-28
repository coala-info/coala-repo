---
name: danpos
description: DANPOS is a toolkit for high-resolution analysis of chromatin features including nucleosome positioning, transcription factor binding, and histone modifications. Use when user asks to call nucleosome positions, identify transcription factor peaks, analyze broad chromatin regions, or perform quantile normalization of occupancy data.
homepage: https://sites.google.com/site/danposdoc/
---


# danpos

## Overview

DANPOS (Dynamic Analysis of Nucleosome Position and Occupancy by Sequencing) is a specialized toolkit designed for the high-resolution analysis of chromatin features. While originally developed for nucleosome positioning, it is equally effective for analyzing transcription factor binding and histone modifications. Use this skill to process raw alignment files (BAM, SAM, BED, Bowtie) or occupancy data (WIG) to define binding sites and quantify differences between samples.

## Core Commands and Workflows

The toolkit is organized into several sub-commands based on the resolution of the genomic feature being analyzed:

- **dpos**: Use for nucleosome-level analysis. It calculates changes in location (shifts), fuzziness (positional variance), and occupancy.
- **dpeak**: Use for transcription factors or narrow histone marks. It analyzes changes in peak width, height, and total signal.
- **dregion**: Use for broad chromatin features (e.g., H3K4me3). It identifies changes in enriched regions that may contain multiple peaks.
- **dtriple**: Use as a discovery tool when the binding characteristics of the target protein are unknown; it runs dpos, dpeak, and dregion simultaneously.
- **wiq**: Use for genome-wide quantile normalization of wiggle (.wig) files to ensure signal-to-noise ratios are comparable across replicates or conditions.

## Command Line Patterns

### Path Syntax for Samples and Replicates
DANPOS uses a specific syntax to distinguish between replicates and comparisons:
- **Replicates**: Place all replicate files in a single directory. DANPOS automatically treats files in the same directory as replicates of one data set.
- **Independent Sets**: Separate multiple paths with commas (e.g., `path/A,path/B`).
- **Comparisons**: Separate treatment and control paths with a colon (e.g., `treatment/:control/`).

### Common CLI Examples

**Basic Nucleosome Calling (Single Sample):**
```bash
python danpos.py dpos ./sample_replicates_dir/
```

**Differential Analysis with Background Subtraction:**
```bash
python danpos.py dpos treat/:control/ -b background_input/
```

**Peak Calling for Histone Marks (H3K4me3):**
```bash
python danpos.py dpeak H3K4me3_sample/ -b input_control/
```

**Quantile Normalization of Wiggle Files:**
```bash
python danpos.py wiq --buffer_size 50 chrom_size_file.xls sampleA.wig:sampleB.wig
```

## Parameter Best Practices

- **Input Formats**: Ensure SAM files have headers (use `samtools view -h`). For paired-end data, read names must end in `1` and `2` and be adjacent in the file.
- **Paired-End Data**: Always specify `-m 1` when working with paired-end reads to ensure correct fragment size calculation.
- **Normalization (`-n`)**: 
    - `F`: Normalization by fold change (Default).
    - `S`: Normalization by sampling.
    - `N`: No normalization.
- **Clonal Reads (`-u`)**: If PCR bias is suspected, set `-u` to a p-value (e.g., `1e-10`) or an integer read count to cap clonal signals.
- **Smoothing (`-z`)**: The default smooth width is 20bp. Set to `0` if you are providing pre-processed wiggle files that should not be smoothed again.



## Subcommands

| Command | Description |
|---------|-------------|
| dpeak | The dpeak function in DANPOS is used for calling peaks (nucleosomes) from sequencing data, typically after preprocessing or for specific enrichment analysis. |
| dpos | Analyze dynamics of nucleosome positions, including occupancy, position, and fuzziness changes. |

## Reference documentation
- [Dpos Parameters](./references/sites_google_com_site_danposdoc_b-documentation_1-dpos_parameters.md)
- [Input File Specifications](./references/sites_google_com_site_danposdoc_b-documentation_1-dpos_input-files.md)
- [Dpos Tutorial and Examples](./references/sites_google_com_site_danposdoc_a-tutorial_1-dpos.md)
- [Wiq Normalization Guide](./references/sites_google_com_site_danposdoc_a-tutorial_7-wiq.md)