---
name: transposonpsi
description: TransposonPSI is a specialized homology search tool that leverages PSI-BLAST profiles to detect mobile genetic elements, particularly highly degenerate ones, at the protein level. Use when user asks to identify transposon regions in genomic sequences, check predicted proteins for transposon-derived domains, find hidden or ancient transposon remnants, or mask genomes before gene prediction.
homepage: http://transposonpsi.sourceforge.net/
metadata:
  docker_image: "quay.io/biocontainers/transposonpsi:1.0.0--hdfd78af_3"
---

# transposonpsi

## Overview
TransposonPSI is a specialized homology search tool that leverages PSI-BLAST profiles to detect mobile genetic elements. Unlike standard nucleotide-based searches (like RepeatMasker), TransposonPSI excels at identifying highly degenerate elements by searching at the protein level. It is particularly effective for genome annotation workflows where identifying "hidden" or ancient transposon remnants is required to improve masking or evolutionary analysis.

## Command Line Usage

### Searching Genomic Sequences (Nucleotide)
To identify transposon regions within a genome or large scaffold file, use the `nuc` mode. This performs a PSI-TBLASTN search.

```bash
transposonPSI.pl genome.fasta nuc
```

**Key Output Files:**
- `*.TPSI.allHits.chains.gff3`: All identified chains in GFF3 format.
- `*.TPSI.allHits.chains.bestPerLocus.gff3`: Filtered GFF3 containing only the highest-scoring match for each genomic location (recommended for annotation).
- `*.TPSI.allHits`: Raw HSP (High-scoring Segment Pair) data in btab format.

### Searching Protein Sets
To check if a set of predicted proteins contains transposon-derived domains (e.g., reverse transcriptase, integrase, transposase), use the `prot` mode.

```bash
transposonPSI.pl proteins.fasta prot
```

**Key Output Files:**
- `*.TPSI.topHits`: The single best match for each query protein.
- `*.TPSI.allHits`: All significant matches per protein.

## Best Practices and Tips

- **Complementary Masking**: Use TransposonPSI alongside RepeatMasker. While RepeatMasker is excellent for recent, high-identity repeats, TransposonPSI often finds older, more divergent elements that RepeatMasker misses.
- **GFF3 Integration**: The `.bestPerLocus.gff3` file is designed for immediate loading into genome browsers (JBrowse, IGV) or for use with tools like `bedtools` to mask genomes before gene prediction.
- **Protein Library**: The distribution includes a standalone library at `transposon_ORF_lib/transposon_db.pep`. If the profile search is too restrictive, you can perform a standard BLASTP or TBLASTN against this specific FASTA file to find novel or highly divergent elements.
- **Interpreting Targets**: Matches are labeled by family (e.g., `TY1_Copia`, `Gypsy`, `LINE`). Pay attention to the E-value in the GFF3 attributes to distinguish between high-confidence full-length elements and short, degenerate fragments.

## Reference documentation
- [TransposonPSI SourceForge Documentation](./references/transposonpsi_sourceforge_net_index.md)