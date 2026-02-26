---
name: bacphlip
description: BACPHLIP predicts whether a bacteriophage genome follows a temperate or virulent lifestyle using a Random Forest classifier. Use when user asks to determine phage lifestyle, predict if a phage is lytic or lysogenic, or identify temperate-specific protein domains in a phage genome.
homepage: https://github.com/adamhockenberry/bacphlip
---


# bacphlip

## Overview
BACPHLIP (Bacteriophage Lifestyle Prediction) is a specialized tool that uses a Random Forest classifier to determine if a phage genome is temperate (lysogenic) or virulent (lytic). It operates by performing a six-frame translation of the input DNA, searching for specific "temperate-specific" protein domains using HMMER3, and then calculating the probability of each lifestyle. It is designed for complete phage genomes and assumes the input is indeed a phage, as it does not perform independent viral identification.

## Installation and Dependencies
BACPHLIP requires the HMMER3 software suite to be installed and available in your system path.
- **Conda**: `conda install bioconda::bacphlip`
- **Pip**: `pip install bacphlip`

## Command Line Usage
The primary interface for BACPHLIP is the command line. It processes FASTA files and generates several intermediate files along with the final prediction.

### Basic Prediction
To run a prediction on a single complete phage genome:
```bash
bacphlip -i path/to/genome.fasta
```
This produces four files:
- `.bacphlip`: The final model predictions (tab-separated probabilities).
- `.6frame`: Six-frame translation of the genome.
- `.hmmsearch`: Raw HMMER search results.
- `.hmmsearch.tsv`: Parsed HMMER results.

### Handling Multiple Genomes
If you have a single FASTA file containing multiple complete genomes, use the `--multi_fasta` flag:
```bash
bacphlip -i path/to/multi_genome.fasta --multi_fasta
```
This creates a directory named after the input file to store intermediate results and outputs a single consolidated table of predictions.

### Overwriting Results
By default, BACPHLIP will throw an error if output files already exist. Use the force flag to overwrite:
```bash
bacphlip -i path/to/genome.fasta -f
```

### Specifying HMMER Path
If `hmmsearch` is not in your system path, provide the local path:
```bash
bacphlip -i path/to/genome.fasta --local_hmmsearch /path/to/hmmsearch
```

## Python Library Usage
BACPHLIP can be integrated directly into Python workflows for batch processing or custom pipelines.

### Single and Multi-FASTA Processing
```python
import bacphlip

# Process a single genome
bacphlip.run_pipeline('genome.fasta')

# Process a multi-record FASTA file
bacphlip.run_pipeline_multi('multi.fasta')
```

### Batch Processing with Glob
```python
import bacphlip
import glob

for fasta in glob.glob('phage_dir/*.fasta'):
    bacphlip.run_pipeline(fasta)
```

## Expert Tips and Caveats
- **Genome Completeness**: BACPHLIP relies on the presence or absence of specific domains. Incomplete or fragmented genomes may lead to false "Virulent" calls because the temperate-specific domains were missing from the fragment.
- **Input Validation**: The tool assumes the input is a phage. Providing bacterial chromosomes will likely result in a "Temperate" call due to the high probability of finding relevant domains in a large bacterial genome.
- **Taxonomic Bias**: The model was trained primarily on *Caudovirales* infecting *Actinobacteria*, *Gammaproteobacteria*, and *Bacilli*. Use caution when interpreting results for phages outside these groups.
- **Default State**: The classifier's starting assumption is that a phage is virulent. It requires positive evidence of temperate-specific domains to update the prediction to temperate.

## Reference documentation
- [BACPHLIP GitHub Repository](./references/github_com_adamhockenberry_bacphlip.md)
- [Bioconda BACPHLIP Overview](./references/anaconda_org_channels_bioconda_packages_bacphlip_overview.md)