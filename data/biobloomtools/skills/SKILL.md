---
name: biobloomtools
description: BioBloomTools is a bioinformatics suite that uses Bloom filters for rapid sequence categorization and reference genome classification. Use when user asks to build Bloom filters from reference files, categorize reads against specific genomes, or screen samples for matches to multiple targets.
homepage: https://github.com/bcgsc/biobloom
metadata:
  docker_image: "quay.io/biocontainers/biobloomtools:2.3.5--h077b44d_6"
---

# biobloomtools

## Overview
BioBloomTools (BBT) is a high-performance bioinformatics suite designed for rapid sequence categorization. By using Bloom filters—a probabilistic data structure—it can determine if a sequence belongs to a specific reference genome with high accuracy and minimal memory usage. This skill provides the procedural knowledge to build filters using `biobloommaker` and classify reads using `biobloomcategorizer`.

## Generating Bloom Filters
Use `biobloommaker` to convert reference FastA files into binary Bloom filter (.bf) files.

- **Basic Creation**:
  `biobloommaker -p <prefix> <reference.fasta>`
- **Adjusting False Positive Rate (FPR)**:
  The default FPR is 0.075. Lowering this increases memory usage but improves precision.
  `biobloommaker -f 0.02 -p <prefix> <reference.fasta>`
- **K-mer Size**:
  The default k-mer size is 25. Adjust based on the complexity of the reference.
  `biobloommaker -k 31 -p <prefix> <reference.fasta>`

**Note**: Every `.bf` file is accompanied by a `.txt` info file. Both must remain in the same directory for the categorizer to function.

## Categorizing Sequences
Use `biobloomcategorizer` to screen your samples against one or more filters.

- **Single-End Screening**:
  `biobloomcategorizer --fa -p <output_prefix> -f "filter1.bf filter2.bf" input.fastq`
- **Paired-End Mode**:
  Use `-e` to require both reads in a pair to match the same filter.
  `biobloomcategorizer -e -p <output_prefix> -f "filter.bf" R1.fq R2.fq`
- **Inclusive Paired-End**:
  Use `-i` with `-e` to categorize a pair if at least one read matches.
  `biobloomcategorizer -e -i -p <output_prefix> -f "filter.bf" R1.fq R2.fq`

## Output Interpretation
- **summary.tsv**: Provides a high-level count of reads assigned to each filter, "no match," or "multi-match" (if using multiple filters).
- **readStatus.tsv**: A per-read breakdown of classification results.
- **Categorized Files**: FastA/FastQ files containing the actual sequences sorted by their respective filters.

## Expert Tips
- **Version Compatibility**: Bloom filters are sensitive to version changes. A filter created with version 2.0.x may not work with 2.1.x. Always ensure the maker and categorizer versions match.
- **Piping Compressed Input**: For `.gz` or `.bz2` files, use process substitution to avoid manual decompression:
  `biobloomcategorizer -f "ref.bf" <(zcat input.fastq.gz)`
- **Multi-Target Classification**: When classifying against >100 targets, consult the "Multi-index Bloom filters" section of the manual for optimized performance.



## Subcommands

| Command | Description |
|---------|-------------|
| biobloomcategorizer | Categorize Sequences. The input format may be FASTA, FASTQ, and compressed gz. |
| biobloommaker | Creates a bf and txt file from a list of fasta files. The input sequences are cut into a k-mers with a sliding window and their hash signatures are inserted into a bloom filter. |

## Reference documentation
- [BioBloomTools Manual](./references/github_com_bcgsc_biobloom.md)
- [BioBloomTools Overview](./references/www_bcgsc_ca_resources_software_biobloomtools.md)