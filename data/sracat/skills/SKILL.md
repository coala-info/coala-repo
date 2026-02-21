---
name: sracat
description: sracat is a high-performance C++ utility designed to extract genomic read data from SRA records using the NCBI sra-toolkit API.
homepage: https://github.com/lanl/sracat
---

# sracat

## Overview

sracat is a high-performance C++ utility designed to extract genomic read data from SRA records using the NCBI sra-toolkit API. Its primary advantage is speed; unlike fasterq-dump, which reorders reads to match their original submission, sracat outputs reads in the order they are physically stored within the SRA file. This makes it an ideal tool for bioinformatics pipelines where read order is irrelevant—such as k-mer analysis, sequence searching, or certain assembly workflows—and where minimizing processing time is critical.

## Command Line Usage

The basic syntax for sracat is:
`sracat [options] <SRA accession or filename 1> [accession 2 ...]`

### Common Patterns

**1. Extracting Sequences (FASTA)**
By default, sracat outputs only sequence data in FASTA format to stdout.
```bash
sracat SRR1234567 > output.fasta
```

**2. Extracting Sequences and Quality Scores (FASTQ)**
Use the `--qual` flag to include quality scores.
```bash
sracat --qual SRR1234567 > output.fastq
```

**3. Saving to Files with Compression**
Use `-o` to specify an output prefix and `-z` to enable zlib-based compression.
```bash
sracat -z -o processed_reads SRR1234567
```

**4. Concatenating Multiple Accessions**
sracat can process multiple inputs in a single command, concatenating the output.
```bash
sracat SRR111111 SRR222222 SRR333333 > combined_reads.fasta
```

## Best Practices and Tips

- **Order Independence**: Only use sracat if your downstream analysis does not rely on the original submission order of the reads. For paired-end data, reads may not appear adjacent to their mates.
- **Remote vs. Local**: sracat automatically detects if an input is a local file (requires `.sra` extension) or a remote accession. If using remote accessions, ensure your environment is configured to allow NCBI server connections.
- **Piping**: Since sracat defaults to stdout, it is highly efficient for piping directly into other tools (e.g., `grep`, `seqkit`, or aligners) to avoid creating large intermediate files.
- **Disk Space**: When writing to disk, always prefer the `-z` flag to reduce the footprint of the resulting FASTA/FASTQ files.

## Reference documentation

- [sracat - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_sracat_overview.md)
- [GitHub - lanl/sracat: Quickly extract sequence (and quality scores) from Sequence Read Archive records](./references/github_com_lanl_sracat.md)