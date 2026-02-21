---
name: wise2
description: Wise2 is a specialized bioinformatics suite designed for high-accuracy alignment of biological sequences.
homepage: https://www.ebi.ac.uk/~birney/wise2/
---

# wise2

## Overview
Wise2 is a specialized bioinformatics suite designed for high-accuracy alignment of biological sequences. Its primary strength lies in its ability to handle "noisy" genomic DNA by accounting for introns and frameshifts during protein-to-DNA alignment. Use this tool when you need to map known protein sequences or HMM profiles onto genomic contigs to identify gene structures with precise splice-site modeling.

## Core CLI Patterns

### Protein-to-DNA Alignment (genewise)
The most common use case is aligning a protein sequence to a genomic DNA sequence to find the best-fit gene model.

```bash
genewise [options] <protein_file> <dna_file>
```

**Key Options:**
- `-trev`: Search the reverse complement of the DNA sequence.
- `-genes`: Output the predicted gene structure in a human-readable format.
- `-gff`: Output results in GFF format for downstream genomic analysis.
- `-splice`: Use a specific splice site model (e.g., `-splice flat` or `-splice pwm`).
- `-alg 623P`: (Experimental) Use the phased intron model to tie intron positions to specific protein points.

### Protein HMM-to-DNA Alignment
Wise2 is one of the few tools that natively supports aligning HMMer2-style profiles directly to DNA.

```bash
genewise [options] <hmm_file> <dna_file>
```

### Non-co-linear Alignment (promoterwise)
Use `promoterwise` when comparing sequences where the conserved blocks may have been rearranged or are not in the same linear order (common in promoter or enhancer studies).

```bash
promoterwise <query_dna> <target_dna>
```

## Expert Tips & Best Practices
- **Performance:** Wise2 is computationally intensive. For large-scale genomic searches, consider pre-filtering your DNA sequences using faster tools like `exonerate` or `blast` before using `genewise` for the final, high-quality alignment.
- **Frameshifts:** `genewise` is specifically designed to "read through" sequencing errors that cause frameshifts. If your DNA sequence is high-quality (e.g., finished cDNA), the computational overhead of Wise2 might be unnecessary compared to standard aligners.
- **HMM Compatibility:** Note that Wise2's HMM support is based on HMMer2. If you are using HMMer3 profiles, they may need to be converted or used with caution regarding library compatibility.
- **Splice Sites:** For higher accuracy in eukaryotic genomes, use the PWM (Position Weight Matrix) splice site models rather than the default "flat" models.

## Reference documentation
- [Wise2 Package Overview](./references/www_ebi_ac_uk__birney_wise2.md)
- [Bioconda Wise2 Installation](./references/anaconda_org_channels_bioconda_packages_wise2_overview.md)