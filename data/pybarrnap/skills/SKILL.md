---
name: pybarrnap
description: "pybarrnap identifies the location of ribosomal RNA genes in genomic FASTA files using HMM profiles. Use when user asks to predict rRNA genes, find 16S or 23S sequences, or annotate ribosomal RNA in bacterial, archaeal, or eukaryotic genomes."
homepage: https://github.com/moshi4/pybarrnap/
---


# pybarrnap

## Overview

pybarrnap is a Python implementation of the Bacterial Ribosomal RNA Predictor (barrnap). It identifies the location of ribosomal RNA genes in genomic FASTA files using HMM profiles. Unlike the original Perl version, pybarrnap's default mode is self-contained, relying on the `pyhmmer` library rather than external binaries like `nhmmer` or `bedtools`. It is a critical tool for microbial genome annotation, providing both a CLI for shell-based pipelines and a Python API for programmatic integration.

## CLI Usage Patterns

### Basic Prediction
Run a standard search against a bacterial genome (default kingdom) and redirect the GFF output to a file:
```bash
pybarrnap genome.fna > genome_rrna.gff
```

### Kingdom-Specific Searches
Specify the target kingdom to use the appropriate HMM profiles. Available options are `bac` (bacteria), `arc` (archaea), and `euk` (eukaryotes).
```bash
pybarrnap -k arc archaea_genome.fna > archaea_rrna.gff
```

### Extracting rRNA Sequences
To save the actual nucleotide sequences of the predicted rRNA hits into a separate FASTA file while generating the GFF:
```bash
pybarrnap genome.fna --outseq rrna_hits.fna > annotations.gff
```

### High-Sensitivity (Accurate) Mode
Use the `--accurate` flag to employ `cmscan` (from the Infernal package) instead of `nhmmer`. This uses RNA secondary structure profiles for higher accuracy, though it is significantly slower.
```bash
# Note: Requires 'infernal' to be installed
pybarrnap --accurate -k all genome.fna > high_res_annotations.gff
```

### Pipeline Integration
pybarrnap supports stdin, allowing it to be used in command-line pipes:
```bash
cat assembly.fna | pybarrnap -k bac -q | grep "16S"
```

## Expert Tips and Best Practices

- **Kingdom 'all'**: The `-k all` option is only valid when using the `--accurate` mode. In default mode, you must specify a single kingdom.
- **Partial Hits**: Use `-l` (length cutoff, default 0.8) to adjust the threshold for labeling an rRNA as "partial." If you are working with highly fragmented assemblies, you may need to lower this value.
- **Reject Threshold**: Use `-r` (reject threshold, default 0.25) to ignore hits that are too short to be considered even partial rRNAs.
- **Performance**: For large metagenomic files or multiple genomes, utilize the `-t` parameter to specify the number of CPU threads.
- **GFF Formatting**: Use the `--incseq` flag if you need the output GFF file to include the original FASTA sequences at the end (standard GFF3 format).

## Python API Usage

For integration into Python scripts, use the `Barrnap` class:

```python
from pybarrnap import Barrnap

# Initialize the predictor
barrnap = Barrnap(
    "genome.fna", 
    kingdom="bac", 
    threads=4, 
    evalue=1e-06
)

# Run prediction
result = barrnap.run()

# Export results
result.write_gff("output.gff")
result.write_fasta("rrna.fna")

# Access features programmatically
for record in result.seq_records:
    for feature in record.features:
        print(f"Found {feature.id} at {feature.location}")
```

## Reference documentation
- [pybarrnap GitHub README](./references/github_com_moshi4_pybarrnap.md)
- [pybarrnap Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pybarrnap_overview.md)