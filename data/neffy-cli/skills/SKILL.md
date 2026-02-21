---
name: neffy-cli
description: The `neffy-cli` tool is a high-performance utility designed for bioinformatics researchers to quantify sequence diversity within Multiple Sequence Alignments (MSAs).
homepage: https://maryam-haghani.github.io/NEFFy
---

# neffy-cli

## Overview
The `neffy-cli` tool is a high-performance utility designed for bioinformatics researchers to quantify sequence diversity within Multiple Sequence Alignments (MSAs). It calculates the NEFF metric, which is a critical indicator of the information content and evolutionary constraints within an alignment, often used to improve the accuracy of protein structure prediction models like AlphaFold. Beyond computation, it serves as a robust converter for common MSA formats, handling complex tasks like gap filtering, non-standard residue treatment, and multimer MSA processing.

## NEFF Computation
The primary command for diversity calculation is `neff`.

### Basic Usage
```bash
neff --file=input.fasta --alphabet=0 --threshold=0.8
```

### Key Parameters
- `--file`: Comma-separated list of MSA files. If multiple files are provided, sequences are integrated (duplicates removed) before calculation.
- `--alphabet`: `0` for Protein (default), `1` for RNA, `2` for DNA.
- `--threshold`: Similarity cutoff (0.0 to 1.0) to determine if sequences are "similar." Default is `0.8`.
- `--norm`: Normalization method:
  - `0`: Square root of sequence length (default).
  - `1`: Sequence length.
  - `2`: No normalization.
- `--is_symmetric`: `true` (default) for standard similarity assessment; `false` for asymmetric weighting (useful for RaptorX-style workflows).
- `--gap_cutoff`: Remove positions with gap frequency higher than this value (e.g., `0.7`).
- `--residue_neff=true`: Generates column-wise NEFF values instead of a single global value.

### Expert Tips for NEFF
- **Handling Multimers**: For complex assemblies, use `--multimer_MSA=true` combined with `--stoichiom=A2B1` and `--chain_length=100,150`. This allows the tool to correctly identify paired vs. unpaired sequences in block-diagonal MSAs.
- **Query Gaps**: By default, `neffy-cli` omits gap positions in the query (first) sequence. Use `--omit_query_gaps=false` if you need to retain insertion columns relative to the query.
- **Integration**: You can combine multiple databases (e.g., UniRef, BFD, MGnify) by passing them as a list: `--file=db1.sto,db2.a3m`. Use `--depth` to limit the total number of sequences processed.

## MSA File Conversion
The `converter` command handles format transitions based on file extensions.

### Basic Usage
```bash
converter --in_file=input.a3m --out_file=output.sto --alphabet=0
```

### Supported Formats
- **A2M/A3M**: Common in HH-suite; handles insertions (lowercase) and deletions.
- **STO (Stockholm)**: Supports rich metadata and secondary structure annotations.
- **CLUSTAL/PFAM**: Human-readable interleaved or tab-separated formats.
- **ALN**: Simple aligned format where the first sequence is gap-free.

### Conversion Best Practices
- **Validation**: Always keep `--check_validation=true` (default) to ensure sequences match the specified alphabet (Protein/RNA/DNA) during conversion.
- **Extension-Based**: The tool automatically determines the target format from the `--out_file` extension. Ensure your output filename ends in `.fasta`, `.sto`, `.a3m`, `.a2m`, `.aln`, `.clustal`, or `.pfam`.

## Reference documentation
- [NEFFy Usage Guide](./references/maryam-haghani_github_io_NEFFy_usage_guide.html.md)
- [MSA Formats Reference](./references/maryam-haghani_github_io_NEFFy_msa_formats.html.md)
- [NEFF Metric Theory](./references/maryam-haghani_github_io_NEFFy_neff.html.md)