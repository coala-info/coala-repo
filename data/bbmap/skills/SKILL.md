---
name: bbmap
description: BBMap is a versatile bioinformatics suite used for fast, splice-aware sequence alignment and comprehensive genomic data processing. Use when user asks to align reads to a reference, trim adapters, filter contaminants, merge overlapping reads, normalize coverage, or reformat sequencing files.
homepage: https://sourceforge.net/projects/bbmap
---


# bbmap

## Overview
BBMap is a versatile suite of bioinformatics tools (BBTools) centered around a fast, splice-aware global aligner. It is designed to handle massive datasets with high sensitivity for indels and mutations. Beyond alignment, the suite provides essential utilities for the entire sequencing pipeline: decontamination, error correction, read merging, and data normalization. It is particularly effective for Illumina, PacBio, and Nanopore data, offering deterministic performance and efficient memory management.

## Core CLI Patterns

### 1. Alignment (bbmap.sh)
Use for mapping DNA or RNA reads to a reference genome.
*   **Indexing and Mapping:** `bbmap.sh ref=genome.fa in=reads.fq out=mapped.sam`
*   **RNA-seq (Splice-aware):** Set `maxindel=200k` for organisms with long introns (e.g., humans).
*   **Memory Management:** Use `nodisk` to prevent writing the index to disk if you only need it for a single run.
*   **Sensitivity:** Use the `fast` flag for speed or `slow` for maximum sensitivity with highly mutated genomes.

### 2. Quality Control and Trimming (bbduk.sh)
"Duk" stands for Decontamination Using Kmers. Use this for adapter trimming and filtering.
*   **Adapter Trimming:** `bbduk.sh in=reads.fq out=clean.fq ref=adapters.fa ktrim=r k=23 mink=11 hdist=1 tpe tbo`
    *   `tpe`: Trims pairs to the same length.
    *   `tbo`: Trims adapters based on overlap.
*   **Contaminant Filtering:** `bbduk.sh in=reads.fq out=unmatched.fq outm=matched.fq ref=phix.fa k=31 hdist=1`
*   **Quality Trimming:** `bbduk.sh in=reads.fq out=trimmed.fq qtrim=rl trimq=10`

### 3. Read Merging (bbmerge.sh)
Use to merge overlapping paired-end reads into single reads.
*   **Standard Merging:** `bbmerge.sh in1=r1.fq in2=r2.fq out=merged.fq outu=unmerged.fq`
*   **Error Correction via Overlap:** `bbmerge.sh in=reads.fq out=corrected.fq ecco mix` (Corrects bases in the overlap region without merging).

### 4. Normalization (bbnorm.sh)
Use to reduce coverage in high-depth areas to speed up assembly.
*   **Targeted Normalization:** `bbnorm.sh in=reads.fq out=norm.fq target=100 min=5` (Aims for 100x coverage, discards reads with <5x depth).

### 5. Format Conversion and Utility (reformat.sh)
The "Swiss Army Knife" for file manipulation.
*   **Conversion:** `reformat.sh in=reads.fq out=reads.fa`
*   **Subsampling:** `reformat.sh in=reads.fq out=sampled.fq samplecount=1000000`
*   **Interleaving:** `reformat.sh in1=r1.fq in2=r2.fq out=interleaved.fq`
*   **Verification:** `reformat.sh in=reads.fq vint` (Verifies paired-read synchronization).

## Expert Tips and Best Practices

### Memory and Performance
*   **Java Heap Space:** BBTools are Java-based. Use the `-Xmx` flag to manually set memory (e.g., `bbmap.sh -Xmx20g ...`). By default, scripts attempt to autodetect available memory.
*   **Threading:** Tools use all available cores by default. Use `t=N` to restrict thread usage on shared systems.
*   **Piping:** Most tools support piping via `in=stdin.fq` and `out=stdout.fq`. Note that `bbnorm.sh` and `tadpole.sh` cannot accept piped input in certain modes because they require multiple passes.

### File Handling
*   **Automatic Compression:** BBTools automatically detects `.gz` and `.bz2` extensions. If `pigz` is installed, it will be used for parallel compression/decompression.
*   **Wildcards:** Use the `#` symbol for paired files: `in=reads_#.fq` expands to `reads_1.fq` and `reads_2.fq`.
*   **Wildcard Output:** Use the `%` symbol in tools like `bbsplit.sh` to generate files based on reference names: `pattern=out_%.fq`.

### Data Integrity
*   **Repairing Pairs:** If paired files become disordered (e.g., after filtering one file independently), use `repair.sh in1=broken1.fq in2=broken2.fq out1=fixed1.fq out2=fixed2.fq outs=singletons.fq`.
*   **Deduplication:** Use `clumpify.sh` to group similar reads. This significantly improves Gzip compression ratios and can remove optical/PCR duplicates with the `dedupe` flag.



## Subcommands

| Command | Description |
|---------|-------------|
| bbduk.sh | Compares reads to the kmers in a reference dataset, optionally allowing an edit distance. Splits the reads into two outputs - those that match the reference, and those that don't. Can also trim (remove) the matching parts of the reads rather than binning the reads. |
| bbmap.sh | Fast and accurate splice-aware read aligner. |
| bbmap_khist.sh | Kmer normalization and histogram generation tool (jgi.KmerNormalize) |
| bbmerge.sh | Merges paired reads into single reads by overlap detection. With sufficient coverage, can merge nonoverlapping reads by kmer extension. |
| bbnorm.sh | Normalizes read depth based on kmer counts. Can also error-correct, bin reads by kmer depth, and generate a kmer depth histogram. |
| dedupe.sh | Accepts one or more files containing sets of sequences (reads or scaffolds). Removes duplicate sequences, which may be specified to be exact matches, subsequences, or sequences within some percent identity. Can also find overlapping sequences and group them into clusters. |
| reformat.sh | Reformats reads to change ASCII quality encoding, interleaving, file format, or compression format. Optionally performs additional functions such as quality trimming, subsetting, and subsampling. |

## Reference documentation
- [BBMap Guide](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide_bbmap-guide.md)
- [BBDuk Guide](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide_bbduk-guide.md)
- [BBMerge Guide](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide_bbmerge-guide.md)
- [BBNorm Guide](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide_bbnorm-guide.md)
- [Reformat Guide](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide_reformat-guide.md)
- [Usage Guide](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide_usage-guide.md)
- [Data Preprocessing](./references/archive_jgi_doe_gov_data-and-tools_software-tools_bbtools_bb-tools-user-guide_data-preprocessing.md)