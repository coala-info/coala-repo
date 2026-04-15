---
name: wise2
description: Wise2 is a bioinformatics suite used for high-sensitivity alignment of protein sequences or Hidden Markov Models to genomic DNA. Use when user asks to align proteins to DNA, predict gene structures with introns and splice sites, or perform non-co-linear alignment of promoter regions.
homepage: https://www.ebi.ac.uk/~birney/wise2/
metadata:
  docker_image: "quay.io/biocontainers/wise2:2.4.1--h08bb679_0"
---

# wise2

## Overview
Wise2 is a specialized bioinformatics suite designed for high-sensitivity genomic alignment. While newer tools like Exonerate are faster for general tasks, Wise2 remains the gold standard for aligning protein Hidden Markov Models (HMMs) directly to DNA sequences to predict gene structures, including introns and splice sites. It is a core component of many genome annotation pipelines (such as Ensembl) due to its sophisticated handling of frameshifts and splice site models.

## Core CLI Patterns

### Genewise: Protein to DNA Alignment
The primary use case for Wise2 is aligning a protein sequence or HMM to a genomic DNA sequence to find the best-fitting gene model.

**Basic Protein-to-DNA:**
```bash
genewise [protein_file] [dna_file] -trev -genes -pretty
```
- `-trev`: Search the reverse complement of the DNA.
- `-genes`: Output the gene structure in a human-readable format.
- `-pretty`: Provide a detailed alignment view.

**Protein HMM-to-DNA:**
```bash
genewise [hmm_file] [dna_file] -hmmer -genes
```
- `-hmmer`: Specifies that the input is a HMMer2 compatible HMM file.

### Advanced Modeling
Wise2 allows for fine-tuning the biological assumptions of the alignment:

- **Splice Site Models**: Use `-splice` to enable more flexible splice site models (PWMs) for 5' and 3' sites.
- **Intron Phase**: Use `-alg 623P` for experimental models that tie intron positions to specific protein phases.
- **Output Formats**: 
    - `-gff`: Output in General Feature Format for downstream bioinformatics pipelines.
    - `-ace`: Output in ACeDB format.

### Promoterwise: Non-co-linear Alignment
For sequences that do not follow a strict linear order (common in promoter regions or rearranged genomic segments), use `promoterwise`.

```bash
promoterwise [query_dna] [target_dna]
```

## Expert Tips
- **Performance**: Wise2 is computationally expensive. If you have a very large genomic region, pre-mask repeats or use a faster tool like Exonerate to find the general locus before refining the alignment with `genewise`.
- **HMM Compatibility**: Ensure HMMs are in HMMer2 format; HMMer3 files may require conversion or may not be natively supported depending on the specific build.
- **Frameshifts**: One of Wise2's greatest strengths is its ability to align through frameshifts in the DNA, making it ideal for pseudogene analysis or low-quality sequencing data.



## Subcommands

| Command | Description |
|---------|-------------|
| genewise | genewise <protein-file> <dna-file> in fasta format |
| promoterwise | Seed restriction |

## Reference documentation
- [Wise2 Package Overview](./references/www_ebi_ac_uk__birney_wise2.md)
- [Bioconda Wise2 Distribution](./references/anaconda_org_channels_bioconda_packages_wise2_overview.md)