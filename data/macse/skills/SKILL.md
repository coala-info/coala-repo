---
name: macse
description: "MACSE aligns coding nucleotide sequences by using their amino acid translations to account for frameshifts and premature stop codons. Use when user asks to align protein-coding genes, handle frameshifts in nucleotide sequences, enrich an existing alignment with new sequences, or translate nucleotide sequences into codon-aware amino acid sequences."
homepage: https://bioweb.supagro.inra.fr/macse/
---


# macse

## Overview
MACSE is a specialized bioinformatics tool designed to align coding nucleotide sequences by using their amino acid translations as a guide. Unlike standard aligners, it explicitly handles biological "noise" such as frameshifts (represented by '!') and premature stop codons. This makes it the primary choice for evolutionary analyses of protein-coding genes where maintaining the underlying codon structure is essential for downstream tasks like dN/dS ratio estimation or selection footprint detection.

## Core Usage Patterns

### Basic Alignment
To align a set of nucleotide sequences into a codon-aware alignment:
```bash
java -jar macse.jar -prog alignSequences -seq sequences.fasta
```

### Handling Less Reliable Sequences
If your dataset contains a mix of high-quality sequences and "less reliable" ones (e.g., pseudogenes or raw NGS reads), use the `-seq_lr` flag. MACSE applies lower penalties for introducing frameshifts or stop codons in these sequences.
```bash
java -jar macse.jar -prog alignSequences -seq reliable.fasta -seq_lr pseudogenes.fasta
```

### Common Subprograms
- `alignSequences`: The primary tool for creating new MSAs.
- `enrichAlignment`: Adds new sequences to an existing alignment without recomputing the whole MSA.
- `refineAlignment`: Iteratively improves an existing alignment.
- `exportAlignment`: Converts the internal MACSE format to standard FASTA (NT or AA) while handling the '!' frameshift characters.
- `translateNT2AA`: Provides a codon-aware translation of nucleotide sequences into amino acids.

## Expert Tips & Best Practices

### Memory Management
For large datasets or long sequences, the Java Virtual Machine (JVM) often requires more memory than the default allocation. Use the `-Xmx` flag:
```bash
java -Xmx2g -jar macse.jar -prog alignSequences -seq input.fasta
```

### Genetic Codes
Always specify the correct genetic code if working with non-standard organisms (e.g., mitochondria). Use the `-gc_def` option (default is 1 for Standard Code).
```bash
java -jar macse.jar -prog alignSequences -seq input.fasta -gc_def 5
```

### Visualization
The '!' character used by MACSE to denote frameshifts is compatible with the **SeaView** alignment editor. Use SeaView to visualize the alignment and verify that the codon coloration aligns correctly with the inferred frameshifts.

### Pipeline Integration
For high-throughput tasks, consider using the pre-built `OMM_MACSE` or `AlFiX` pipelines which combine MACSE with filtering tools like HmmCleaner to remove misaligned fragments automatically.



## Subcommands

| Command | Description |
|---------|-------------|
| macse | MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons. |
| macse | Aligns two previously computed nucleotide alignments (also called profiles) without questioning them |
| macse | MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons. |
| macse | allows to export a MACSE alignment and to compute some statistics, it can... |
| macse | Indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability).... |
| macse | MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons. |
| macse | improves the input nucleotide alignment |
| macse | uses a amino acid alignment to align nucleotide sequences.... |
| macse | Uses a filtered amino acid alignment to filter a nucleotide alignment. |
| macse | splits one alignment, to extract a subset of sequences and/or sites. |
| macse | MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons. |
| macse | MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons. |
| macse | identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments. |
| macse | removes the 3' and 5' parts of the input sequence that are non homologous to an alignment.... |

## Reference documentation
- [MACSE Documentation](./references/www_agap-ge2pop_org_macse_macse-documentation.md)
- [MACSE Quickstart](./references/www_agap-ge2pop_org_macse_macse-quickstart.md)
- [Pipeline Documentation](./references/www_agap-ge2pop_org_macse_pipeline-documentation.md)