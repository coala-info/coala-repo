---
name: virulencefinder
description: VirulenceFinder is a specialized bioinformatics tool designed to detect virulence-associated genes within bacterial sequence data.
homepage: https://bitbucket.org/genomicepidemiology/virulencefinder
---

# virulencefinder

## Overview
VirulenceFinder is a specialized bioinformatics tool designed to detect virulence-associated genes within bacterial sequence data. It works by comparing input sequences against a curated database of known virulence factors. This skill provides the necessary command-line patterns to execute searches, manage databases, and interpret the resulting genomic profiles for bacterial pathogenesis research.

## Command Line Usage

### Basic Execution
To run a search against a bacterial genome (FASTA format):
```bash
virulencefinder.py -i input_file.fa -o output_directory -p database_path -s species_name
```

### Key Arguments
- `-i`: Input file (FASTA or FASTQ).
- `-o`: Output directory for results.
- `-p`: Path to the VirulenceFinder database.
- `-s`: Target species (e.g., 'ecoli', 'listeria', 'staph').
- `-t`: Minimum threshold for identity (default is often 90%).
- `-l`: Minimum coverage (default is often 60%).
- `-x`: Extended output (includes alignment details).

### Database Management
Before running the tool, ensure the database is cloned and formatted:
```bash
git clone https://bitbucket.org/genomicepidemiology/virulencefinder_db.git
cd virulencefinder_db
python3 install.py
```

## Best Practices
- **Species Selection**: Always specify the correct species with `-s`. Using the wrong species database will result in missed hits or irrelevant data.
- **Input Quality**: While the tool handles partial sequences (contigs), higher assembly quality (N50) generally leads to more reliable virulence gene detection.
- **Threshold Tuning**: For highly divergent strains, consider lowering the identity threshold (`-t`) to 80%, but be aware this may increase false positives.
- **Output Interpretation**: Focus on the `results_tab.txt` for a summary of found genes, their identity percentages, and their positions within your contigs.

## Reference documentation
- [VirulenceFinder Overview](./references/anaconda_org_channels_bioconda_packages_virulencefinder_overview.md)
- [VirulenceFinder Repository](./references/bitbucket_org_genomicepidemiology_virulencefinder.md)