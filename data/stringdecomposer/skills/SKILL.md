---
name: stringdecomposer
description: StringDecomposer partitions long DNA sequences into constituent monomers based on a provided library to identify the organization of centromeric repeats. Use when user asks to decompose sequences into monomers, identify alpha satellites in long reads, or translate DNA sequences into a monomeric alphabet.
homepage: https://github.com/ablab/stringdecomposer
metadata:
  docker_image: "quay.io/biocontainers/stringdecomposer:1.1.2--py311he264feb_5"
---

# stringdecomposer

## Overview

StringDecomposer is a specialized bioinformatic tool designed to solve the "string decomposition problem" in the context of centromeric sequences. It takes a set of known monomers (typically alpha satellites) and a long, potentially error-prone sequence, then partitions that sequence into its constituent monomers. This process effectively translates the DNA sequence from a nucleotide alphabet into a monomeric alphabet, which is essential for understanding the organization and evolution of centromeres and other tandem repeats.

## Usage Instructions

### Basic Command
The tool requires two positional arguments: the input sequences and the monomer library.

```bash
stringdecomposer sequences.fasta monomers.fasta -o output_decomposition.tsv
```

### Performance Optimization
For large datasets (e.g., whole-genome long reads), utilize multi-threading and adjust batch sizes:
- Use `-t <int>` to specify the number of threads (default is 1).
- Use `-b <int>` to set the batch size for parallelization (default is 5000).

### Filtering and Scoring
- **Identity Threshold**: Use `-i <float>` to filter results. Only monomer alignments with a percent identity greater than or equal to this value will be reported (default is 0).
- **Custom Scoring**: Use `-s "ins,del,mis,match"` to adjust the alignment scoring scheme. The default is `"-1,-1,-1,1"`.

### Advanced Analysis and Reliability
To obtain a more detailed decomposition, use the `--second-best` flag. This is highly recommended for complex centromeric regions where multiple monomers might compete for the same segment.

```bash
stringdecomposer sequences.fasta monomers.fasta --second-best -o detailed_results.tsv
```

When using `--second-best`, the output includes:
- **Reliability Column**: Marked with `+` for reliable alignments and `?` for unreliable ones (often caused by retrotransposon insertions or extremely low-quality segments).
- **Alternative Monomers**: Information on the second-best scoring monomer for each position.
- **Homopolymer Statistics**: Columns prefixed with `homo-` provide statistics after compressing homopolymer runs, which is particularly useful for correcting systematic errors in Oxford Nanopore reads.

## Output Interpretation

The primary output is a TSV file where each line represents a monomer identified within a read:
1. `<read-name>`: The ID of the input sequence.
2. `<best-monomer>`: The name of the identified monomer from the library.
3. `<start-pos>` / `<end-pos>`: The coordinates within the read.
4. `<identity>`: The alignment identity percentage.
5. `<reliability>`: (Requires `--second-best`) Indicates alignment confidence.

## Expert Tips
- **Monomer Libraries**: Ensure your monomer FASTA file contains representative sequences for the specific centromeres or repeats you are investigating.
- **Centromere Assembly**: When working with centromeric assemblies, StringDecomposer can be used to validate the periodicity and structural integrity of the assembled repeats.
- **Data Types**: While optimized for error-prone long reads, the tool is equally effective on high-accuracy PacBio HiFi reads and polished assemblies.

## Reference documentation
- [StringDecomposer GitHub Repository](./references/github_com_ablab_stringdecomposer.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_stringdecomposer_overview.md)