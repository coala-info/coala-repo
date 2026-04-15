---
name: gapmm2
description: gapmm2 is a wrapper for minimap2 that improves the detection of short terminal exons in spliced alignments using sensitive local alignment. Use when user asks to align transcripts to a reference genome, recover missing terminal exons, or generate refined PAF and GFF3 files.
homepage: https://github.com/nextgenusfs/gapmm2
metadata:
  docker_image: "quay.io/biocontainers/gapmm2:25.8.12--pyhdfd78af_0"
---

# gapmm2

## Overview

gapmm2 is a specialized wrapper for minimap2 designed to solve the problem of "missing" terminal exons in spliced alignments. While minimap2 is the industry standard for long-read and transcript mapping, its heuristic approach can sometimes overlook very short exons at the start or end of a sequence. gapmm2 identifies these gaps and utilizes the edlib library to perform a more sensitive local alignment, effectively "filling in" the missing pieces of the gene model. It outputs results in either PAF (Pairwise Mapping Format) or GFF3.

## Installation

Install gapmm2 via Bioconda or pip:

```bash
# Using Conda
conda install -c bioconda gapmm2

# Using Pip
pip install gapmm2
```

## Command Line Usage

The basic syntax requires a reference genome and a query file (transcripts):

```bash
gapmm2 reference.fasta query.fasta -o output.paf
```

### Common Options and Patterns

- **Output Format**: By default, gapmm2 produces PAF files. To generate a GFF3 file for genome annotation workflows, use the `-f` flag:
  ```bash
  gapmm2 reference.fa query.fa -f gff3 -o output.gff3
  ```
- **Thread Management**: Increase performance on multi-core systems (default is 3):
  ```bash
  gapmm2 reference.fa query.fa -t 12
  ```
- **Intron Length**: The `-i` parameter (default: 500) controls the search space for terminal exons. If you expect very long introns near the ends of your transcripts, increase this value:
  ```bash
  gapmm2 reference.fa query.fa -i 1000
  ```
- **Mapping Quality**: Filter out low-confidence alignments by setting a minimum MAPQ score (default: 1):
  ```bash
  gapmm2 reference.fa query.fa -m 10
  ```

## Python API

For integration into bioinformatics pipelines, gapmm2 can be used directly within Python.

### Running the Aligner
The `aligner` function handles the full workflow and returns a dictionary of alignment statistics.

```python
from gapmm2.align import aligner

stats = aligner(
    'genome.fa', 
    'transcripts.fa', 
    out_fmt="gff3", 
    output="results.gff3"
)
print(f"Refined {stats['refine-left']} left-side terminal exons.")
```

### Parsing CIGAR Strings
Use `cs2coords` to convert minimap2 `--cs` strings into genomic coordinates.

```python
from gapmm2.align import cs2coords

# Returns (exons, introns, q_start, q_end, strand_bool)
coords = cs2coords(408903, 0, 543, '-', ':129~ct57ac:166~ct64ac:235~ct54ac:13')
```

## Expert Tips

- **Minimap2 Dependency**: If you experience segmentation faults with the `mappy` Python bindings, ensure the `minimap2` binary is installed in your PATH. Recent versions of gapmm2 will automatically fallback to the standalone binary to improve stability.
- **Validation**: If you are unsure if gapmm2 is necessary for your dataset, run a small subset through standard `minimap2 -x splice --cs` and check if the terminal coordinates in the PAF file match your expected transcript lengths. If they are consistently shorter, gapmm2 is required.

## Reference documentation
- [gapmm2 GitHub Repository](./references/github_com_nextgenusfs_gapmm2.md)
- [Bioconda gapmm2 Overview](./references/anaconda_org_channels_bioconda_packages_gapmm2_overview.md)