---
name: bbmap
description: BBMap is a global, splice-aware aligner used to map DNA and RNA-seq reads from various sequencing platforms to a reference genome. Use when user asks to align reads to a reference, perform adapter trimming, filter contaminants, normalize sequence coverage, or convert between bioinformatics file formats.
homepage: https://sourceforge.net/projects/bbmap
metadata:
  docker_image: "quay.io/biocontainers/bbmap:39.79--h9b5c0a0_0"
---

# bbmap

## Overview

BBTools is a comprehensive suite of fast, multithreaded bioinformatics utilities written in Java. The core tool, BBMap, is a global, splice-aware aligner capable of handling DNA and RNA-seq data from all major sequencing platforms (Illumina, PacBio, Nanopore, etc.). Beyond alignment, the suite provides specialized tools for nearly every stage of the pre-assembly and post-sequencing pipeline, including error correction, deduplication, and library complexity analysis.

## Core CLI Patterns

### General Syntax
Most BBTools follow a consistent parameter syntax:
```bash
tool.sh in=<input> out=<output> [options]
```
- **Memory Management**: Use the `-Xmx` flag to specify memory (e.g., `bbmap.sh -Xmx20g ...`). By default, tools attempt to autodetect available RAM.
- **Paired Reads**: Handle paired files using `in1=` and `in2=` or the `#` wildcard:
  ```bash
  reformat.sh in=reads_#.fq out=processed_#.fq
  ```
- **Piping**: Use `stdin` and `stdout` with extensions to guide the tool:
  ```bash
  cat reads.fq.gz | bbduk.sh in=stdin.fq.gz out=stdout.fq ...
  ```

## Tool-Specific Best Practices

### BBMap (Alignment)
- **Indexing**: BBMap builds an index in a `/ref/` folder. Use `nodisk` to keep the index in memory for one-off runs.
- **RNA-Seq**: For organisms with long introns (like humans), increase the search range: `maxindel=200k`.
- **Sensitivity**: Use the `fast` flag for speed or `slow` for maximum sensitivity with highly mutated genomes.

### BBDuk (Trimming & Filtering)
- **Adapter Trimming**: Use `ktrim=r k=23 mink=11 hdist=1` for standard Illumina adapter removal.
- **Contaminant Removal**: Filter PhiX or other spike-ins by providing a reference: `ref=phix.fa outu=clean.fq`.
- **Quality Trimming**: Use `qtrim=rl trimq=10` to trim both ends to a minimum Phred score of 10.

### BBMerge (Read Merging)
- **Accuracy**: For optimal results, provide the adapter sequences: `adapter1=<seq> adapter2=<seq>`.
- **Non-overlapping Reads**: Use `bbmerge-auto.sh` with `extend2=20` to attempt merging reads that do not physically overlap by using kmer-based extension.

### BBNorm (Normalization)
- **Assembly Prep**: Normalize high-coverage datasets to a target depth (e.g., `target=100`) to speed up assembly and reduce graph complexity.
- **Error Correction**: Enable `ecc=t` during normalization to fix low-frequency kmer errors.

### Reformat (Utility)
- **Format Conversion**: Convert between any supported format (Fastq, Fasta, SAM, BAM) simply by changing the output extension.
- **Subsampling**: Use `samplebasestarget=1000000` or `samplerate=0.1` to reduce dataset size.
- **Fixing Pairs**: If paired files become disordered, use `repair.sh` to re-synchronize them based on read headers.

## Expert Tips
- **Compression**: BBTools natively supports `.gz` files. If `pigz` is installed, it will automatically use it for high-speed parallel compression.
- **Validation**: Use `vint` (verify interleaved) or `vpair` (verify pairs) in `reformat.sh` to check if your paired-end files are properly synchronized.
- **Kmer Length**: For most filtering tasks, `k=31` is the maximum supported length and provides the highest specificity.



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