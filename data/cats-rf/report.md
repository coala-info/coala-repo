# cats-rf CWL Generation Report

## cats-rf_CATS_rf

### Tool Description
reference-free transcriptome assembly assessment

### Metadata
- **Docker Image**: quay.io/biocontainers/cats-rf:1.0.4--hdfd78af_0
- **Homepage**: https://github.com/bodulic/CATS-rf
- **Package**: https://anaconda.org/channels/bioconda/packages/cats-rf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cats-rf/overview
- **Total Downloads**: 691
- **Last updated**: 2025-09-27
- **GitHub**: https://github.com/bodulic/CATS-rf
- **Stars**: N/A
### Original Help Text
```text
25/02/2026 19:34:04:ERROR: Unknown flag supplied: --
CATS-rf version 1.0.4 - reference-free transcriptome assembly assessment
USAGE /usr/local/bin/CATS_rf [OPTIONS] TRANSCRIPTOME READS1 [READS2]
Library type options:
-C: Paired- vs. single-end library configuration: pe = paired-end, se = single-end, default: pe
-S: Library strandness, fr = forward-reverse, rf = reverse-forward, u = unstranded, a = automatic detection, default: u
-Q: Phred quality encoding of FASTQ files, 33 = phred33, 64 = phred64, default: 33
Read mapping, transcript quantification, and read assignment options:
-R: Random seed for read mapping, transcript quantification, and read assignment, default: 12345
-N: Maximum number of distinct mappings per read, default: 10
-m: Estimated mean of fragment length needed for transcript quantification (single-end mode only)
-s: Estimated standard deviation of fragment length needed for transcript quantification (single-end mode only)
Coverage analysis options:
-i: Per-base coverage distribution breakpoints (specified with x,y,z...), default: 0,5,10,20,40,60,80,100
-p: Per-transcript proportion of covered bases distribution breakpoints (specified with x,y,z...), default: 0,0.2,0.4,0.6,0.8,0.85,0.9,0.95,1
-r: Mean transcript coverage distribution breakpoints (specified with x,y,z...), default: 0,5,10,20,40,60,80,100
-l: Proportion of transcript length for positional relative coverage distribution analysis, default: 0.01
-n: Proportion of transcript length for transcript end definition when calculating mean transcript end coverage, default: 0.02
-k: Rolling window size for local coverage calculation (in bp) when defining low-coverage regions (LCR), default: 10
-z: Local coverage threshold for LCR characterization, default: 3
-u: Per-transcript proportion of LCR bases distribution breakpoints (specified with x,y,z...), default: 0,0.2,0.4,0.6,0.8,0.85,0.9,0.95,1
-w: Base coverage weight, default: 1.5
-e: LCR extension penalty, default: 0.5
Accuracy analysis options:
-I: Per-base accuracy distribution breakpoints (specified with x,y,z...), default: 0,0.2,0.4,0.6,0.8,0.85,0.9,0.95,0.99,1
-A: Minimum accuracy for a base to be considered accurate, default: 0.95
-P: Per-transcript proportion of accurate bases distribution breakpoints (specified with x,y,z...), default: 0,0.2,0.4,0.6,0.8,0.85,0.9,0.95,0.99,1
-L: Proportion of transcript length for positional accuracy distribution analysis, default: 0.01
-K: Rolling window size for local accuracy calculation (in bp) when defining low-accuracy regions (LAR), default: 10
-Z: Local accuracy threshold for LAR characterization, default: 0.98
-U: Per-transcript proportion of LAR bases distribution breakpoints (specified with x,y,z...), default: 0,0.2,0.4,0.6,0.8,0.85,0.9,0.95,0.99,1
-E: LAR extension penalty, default: 0.1
Paired-end read analysis options:
-d: Maximum distance from transcript ends for reads with unmapped pair to be considered evidence of transcript end incompleteness or fragmentation (in bp), default: 40
-x: Multiplicative factor for lower distance outlier threshold calculation, default: 8
-X: Multiplicative factor for higher distance outlier threshold calculation, default: 10
-c: Correction factor for distance outlier threshold calculation, default: 5
-y: Per-transcript proportion of improperly paired reads within a transcript distribution breakpoints (specified with x,y,z...), default: 0,0.2,0.4,0.6,0.8,0.85,0.9,0.95,1
-f: Minimum number of bridging events for transcripts to be considered fragmented, default: 3
-F: Per-transcript proportion of reads with pair mapped to another transcript distribution breakpoints (specified with x,y,z...), default: 0,0.2,0.4,0.6,0.8,0.85,0.9,0.95,1
-a: Alpha compression factor for sigmoid transformation applied to bridge index during integrity score component calculation, default: 7
-b: Beta compression factor for sigmoid transformation applied to bridge index during integrity score component calculation, default: 0.5
General options:
-t: Number of CPU threads, default: 10
-G: Percentage of available RAM used by GNU sort, default: 50
-M: Memory block size for GNU Parallel, default: 512M
-T: Number of splits performed on positional and read pair mapping tables, default: 3
-D: CATS-rf output directory name, default: TRANSCRIPTOME_CATS_rf_dir
-o: CATS-rf output file prefix, default: TRANSCRIPTOME
-O: Overwrite the CATS-rf output directory, default: off
-h: Show usage information
```


## cats-rf_CATS_rf_compare

### Tool Description
transcriptome assembly comparison script

### Metadata
- **Docker Image**: quay.io/biocontainers/cats-rf:1.0.4--hdfd78af_0
- **Homepage**: https://github.com/bodulic/CATS-rf
- **Package**: https://anaconda.org/channels/bioconda/packages/cats-rf/overview
- **Validation**: PASS

### Original Help Text
```text
25/02/2026 19:34:32:ERROR: Unknown flag supplied: --
CATS-rf version 1.0.4 - transcriptome assembly comparison script
USAGE /usr/local/bin/CATS_rf_compare [OPTIONS] CATS_RF_DIR1 ...
Graphical options:
-x: Figure extension, default: png
-d: Figure DPI, default: 600
-r: Raincloud plot colors (quoted hexadecimal codes or R color names, specified with x,y,z...), default: adjusted Set1 palette from RColorBrewer package
-l: Lineplot colors (quoted hexadecimal codes or R color names, specified with x,y,z...), default: adjusted Set1 palette from RColorBrewer package
-H: Histogram colors (quoted hexadecimal codes or R color names, specified with x,y,z...), default: adjusted Set1 palette from RColorBrewer package
-b: Barplot colors (quoted hexadecimal codes or R color names, specified with x,y,z...), default: adjusted YlOrRd palette from RColorBrewer package
-q: Maximum right-tail distribution quantile for histograms, default: 0.98
General options:
-t: Number of CPU threads, default: 10
-D: Comparison output directory name, default: CATS_rf_comparison
-O: Overwrite the comparison output directory, default: off
-h: Show usage information
```


## Metadata
- **Skill**: generated
