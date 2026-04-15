---
name: genomethreader
description: GenomeThreader performs similarity-based gene prediction by mapping transcriptomic or proteomic sequences onto genomic templates. Use when user asks to predict gene structures, align cDNA or protein sequences to a genome, or generate consensus gene models using splice site models.
homepage: http://genomethreader.org/
metadata:
  docker_image: "quay.io/biocontainers/genomethreader:1.7.1--h87f3376_4"
---

# genomethreader

## Overview
GenomeThreader is a specialized tool for similarity-based gene prediction. Unlike ab initio predictors, it uses external sequence evidence (transcriptomic or proteomic) to map gene structures onto a genomic template. It is designed to overcome the limitations of older tools like GeneSeqer, specifically handling large genomic regions and long introns through an "intron cutout" technique. It produces high-quality splice site predictions using Bayesian Splice Site Models (BSSMs).

## Common CLI Patterns
The primary executable for GenomeThreader is `gth`.

### Basic Spliced Alignment
To align cDNA/EST sequences to a genomic sequence:
```bash
gth -genomic genomic_dna.fasta -cdna transcripts.fasta
```

To align protein sequences to a genomic sequence:
```bash
gth -genomic genomic_dna.fasta -protein proteins.fasta
```

### Advanced Alignment Options
- **Intron Cutout**: Enable this for very long introns to save memory and time.
  ```bash
  gth -genomic genomic.fasta -cdna est.fasta -intermediate
  ```
- **Species-Specific Splice Sites**: Use BSSMs for better boundary detection (e.g., for Arabidopsis).
  ```bash
  gth -genomic genomic.fasta -cdna est.fasta -species arabidopsis
  ```
- **Output Formats**: By default, GenomeThreader provides a custom text output. Use `-xmlout` for machine-readable data.
  ```bash
  gth -genomic genomic.fasta -cdna est.fasta -xmlout -out output.xml
  ```

### Generating Consensus Alignments
GenomeThreader can combine multiple alignments to predict a final gene structure:
```bash
gth -genomic genomic.fasta -cdna est.fasta -protein prot.fasta -f gff3 -o results.gff3
```

## Expert Tips
- **GFF3 Conversion**: If you require GFF3 output for genome browsers, use the `-f gff3` flag or use the `XML2GFF.py` script included in the distribution on an XML output file.
- **Incremental Updates**: If you have new EST data, you can combine new alignments with precomputed ones to save computation time.
- **Memory Management**: For large-scale annotations, ensure your genomic fasta is indexed or use the `-maskout` option to skip repetitive regions if they have been pre-masked.

## Reference documentation
- [GenomeThreader Overview](./references/genomethreader_org_index.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_genomethreader_overview.md)