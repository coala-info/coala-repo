---
name: pyrodigal-gv
description: pyrodigal-gv is a gene-calling tool optimized for identifying genes in viruses, phages, and giant viruses using specialized metagenomic models. Use when user asks to predict genes in viral sequences, identify open reading frames in giant viruses, or handle alternative genetic codes in viral metagenomes.
homepage: https://github.com/althonos/pyrodigal-gv
---


# pyrodigal-gv

## Overview
`pyrodigal-gv` is a specialized extension of the Pyrodigal library designed to improve gene-calling accuracy within the virosphere. While standard prokaryotic gene finders often struggle with the unique genomic features of viruses, this tool incorporates specific metagenomic models for Nucleocytoviricota (giant viruses) and various phage lineages. It is particularly essential for identifying genes in sequences that utilize alternative genetic codes, such as genetic code 15, which are frequently encountered in environmental viral datasets.

## Command Line Usage
The `pyrodigal-gv` command-line interface is a drop-in replacement for Prodigal but is pre-configured with viral-specific defaults.

### Basic Gene Prediction
Run gene calling on a FASTA input. Note that `pyrodigal-gv` runs in **meta mode by default**, unlike standard Prodigal.
```bash
pyrodigal-gv -i input.fasta -a proteins.faa -d genes.fna
```

### Output Options
- `-i`: Input FASTA file (required).
- `-a`: Write protein translations to the specified file.
- `-d`: Write nucleotide sequences of predicted genes to the specified file.
- `-o`: Write coordinates and scores to the specified file (default is stdout).

### Changing Procedure Mode
If you are working with a high-quality finished isolate and wish to use single-genome mode (though this bypasses the specialized viral metagenomic models):
```bash
pyrodigal-gv -p single -i isolate.fasta
```

## Python API Integration
For programmatic workflows, use the `ViralGeneFinder` class instead of the standard Pyrodigal `GeneFinder`.

### Standard Viral Discovery
```python
import pyrodigal_gv

# Initialize the finder in meta mode
orf_finder = pyrodigal_gv.ViralGeneFinder(meta=True)

# Find genes in a DNA sequence (passed as bytes)
# 'sequence' should be a bytes object
for i, pred in enumerate(orf_finder.find_genes(sequence)):
    print(f">gene_{i+1}")
    print(pred.translate())
```

### Restricting to Viral Models
To ensure the heuristic only considers viral-specific models (ignoring standard bacterial/archaeal models), use the `viral_only` parameter:
```python
orf_finder = pyrodigal_gv.ViralGeneFinder(meta=True, viral_only=True)
```

## Expert Tips & Best Practices
- **Alternative Genetic Codes**: This tool is specifically designed to handle Genetic Code 15 (Topaz, Agate, and various gut phages). If your viral sequences show poor gene density with standard tools, `pyrodigal-gv` is the recommended alternative.
- **Giant Virus (NCLDV) Support**: Use this tool when analyzing Mimiviridae, Phycodnaviridae, or other giant viruses. It includes models specifically trained on *Acanthamoeba polyphaga mimivirus* and *Paramecium bursaria Chlorella virus*.
- **Metagenomic Binning**: When processing viral bins from metagenomes, keep the default `meta=True` setting. The tool will automatically select the best-fitting viral model (including VirSorter2 NCLDV models) for each sequence.
- **Masking**: You can configure the minimum mask length in the Python API `ViralGeneFinder` to handle regions of Ns in scaffolded viral genomes.

## Reference documentation
- [pyrodigal-gv GitHub Repository](./references/github_com_althonos_pyrodigal-gv.md)
- [Bioconda pyrodigal-gv Overview](./references/anaconda_org_channels_bioconda_packages_pyrodigal-gv_overview.md)