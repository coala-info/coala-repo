---
name: phyloaln
description: PhyloAln is a specialized tool for the "omic era" that streamlines the creation of multiple sequence alignments (MSA) for phylogenetic studies.
homepage: https://github.com/huangyh45/PhyloAln
---

# phyloaln

## Overview

PhyloAln is a specialized tool for the "omic era" that streamlines the creation of multiple sequence alignments (MSA) for phylogenetic studies. Instead of following the traditional pipeline of assembly, gene prediction, and orthology assignment, PhyloAln maps sequences directly to existing reference alignments. This approach is highly efficient for large-scale genomic data and includes built-in mechanisms to detect and remove foreign or cross-contamination, ensuring higher quality alignments for downstream evolutionary analysis.

## Installation

The recommended way to install PhyloAln is via Bioconda:

```bash
conda install bioconda::phyloaln
```

## Common CLI Patterns

### Basic Alignment (Single Species)
To align sequences from a single source against a single reference alignment:

```bash
PhyloAln -a reference_alignment.fas -s SpeciesName -i input_sequences.fastq -o output_dir/
```

### Batch Processing (Multiple Species)
Use a configuration file to process multiple species or data sources simultaneously. The configuration file should be tab-separated:

```bash
# Example config.txt content:
# species1    /path/to/reads_1.fq,/path/to/reads_2.fq
# species2    /path/to/assembly.fasta

PhyloAln -c config.txt -o output_dir/
```

### Using Multiple Reference Alignments
If you have a directory containing several reference alignments (e.g., different genes or loci):

```bash
PhyloAln -d /path/to/reference_dir/ -c config.txt -o output_dir/
```

## Auxiliary Scripts and Workflows

PhyloAln includes several utility scripts in its `scripts/` directory to assist with the phylogenetic pipeline:

- **Concatenation**: Use `connect.pl` to merge individual gene alignments into a supermatrix.
- **Trimming**: Use `trim_matrix.py` to remove sites or sequences with excessive unknown data.
- **Translation**: Use `transseq.pl` and `revertransseq.pl` for handling protein-coding DNA sequences.
- **Tree Manipulation**: Use `root_tree.py` and `prune_tree.py` for post-phylogeny processing.

## Expert Tips and Best Practices

- **Contamination Filtering**: One of PhyloAln's strengths is removing foreign sequences. If you suspect high contamination, ensure your reference alignments are well-curated, as the tool uses them as the "truth" for mapping.
- **Memory Management**: For very large datasets or high-coverage reads, the memory requirement can be significant. If the process fails due to memory, consider subsampling your reads or increasing the available RAM.
- **Paired-End Reads**: When using paired-end data, provide both files separated by a comma in the input flag or configuration file.
- **Reference Selection**: The accuracy of the output is highly dependent on the quality of the reference alignment. Ensure the reference contains a representative set of taxa for the group you are studying.
- **Site Consistency**: Note that PhyloAln maintains the site positions of the reference alignment in the output, which is critical for maintaining the established coordinate system of your markers.

## Reference documentation
- [PhyloAln GitHub Repository](./references/github_com_huangyh45_PhyloAln.md)
- [PhyloAln Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phyloaln_overview.md)