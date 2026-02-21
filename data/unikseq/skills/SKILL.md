---
name: unikseq
description: `unikseq` identifies genomic regions that are present in a reference and an ingroup but absent (or minimally present) in an outgroup.
homepage: https://github.com/bcgsc/unikseq
---

# unikseq

## Overview

`unikseq` identifies genomic regions that are present in a reference and an ingroup but absent (or minimally present) in an outgroup. By utilizing k-mer frequencies rather than sequence alignment, the tool can process unordered contigs, unoriented reads, and inconsistent start coordinates. This makes it a robust choice for comparative genomics and diagnostic assay development where high specificity is required.

## Installation and Setup

Install `unikseq` via Bioconda to ensure all dependencies, including Bloom filter libraries for large-scale data, are correctly configured:

```bash
conda install -c bioconda unikseq
```

## Command Line Usage

The core tool is a Perl script (`unikseq.pl`). It requires three primary input files in FASTA format.

### Basic Command Pattern
```bash
unikseq.pl -r reference.fa -i ingroup.fa -o outgroup.fa [options]
```

### Key Parameters
- `-r`: **Reference FASTA** (Required). The sequence you want to find unique regions within.
- `-i`: **Ingroup FASTA** (Required). Sequences where the reference k-mers should be conserved/tolerated.
- `-o`: **Outgroup FASTA** (Required). Sequences where the reference k-mers should NOT appear.
- `-k`: **k-mer length** (Default: 25). Increase for higher specificity in complex genomes; decrease for higher sensitivity.
- `-l`: **Leniency** (Default: 0). The number of consecutive non-unique k-mers allowed in the outgroup before a region is rejected.
- `-m`: **Max % entries** (Default: 0). The maximum percentage of outgroup entries allowed to contain a reference k-mer.
- `-c`: **Conserved regions** (1=Yes, 0=No). Set to `-c 1` to output conserved FASTA regions between the reference and ingroup.

## Expert Tips and Best Practices

### Ensuring Specificity
The accuracy of "uniqueness" is relative to your outgroup. Always ensure your outgroup file is as complete as possible. If an outgroup is missing a specific sequence, `unikseq` may incorrectly flag a region in your reference as unique when it actually exists in the missing outgroup data.

### Handling Large Datasets
For Gbp-scale genomes or massive sequencing sets, use the Bloom filter utility (`unikseq-Bloom`). This requires pre-building Bloom filters using the `writeBloom.pl` utility provided in the package. This version uses presence/absence logic rather than k-mer counting to save memory.

### Input Flexibility
`unikseq` supports:
- Raw RNA-seq or WGS reads.
- Fragmented or unoriented contigs.
- Compressed FASTA files (.gz).
- Mixed sets of reads and assembled sequences.

### Downstream Applications
- **qPCR Design**: Use the unique regions identified in the TSV output to target specific taxa without manual sequence inspection.
- **eDNA Assays**: Identify taxon-specific regions within mitogenomes for environmental monitoring.
- **Gap Characterization**: Use an incomplete outgroup to identify regions in your reference that characterize missing stretches in the outgroup sequences.

## Reference documentation
- [unikseq GitHub Repository](./references/github_com_bcgsc_unikseq.md)
- [Bioconda unikseq Package Overview](./references/anaconda_org_channels_bioconda_packages_unikseq_overview.md)