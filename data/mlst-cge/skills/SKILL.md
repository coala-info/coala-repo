---
name: mlst-cge
description: The `mlst` tool (from the Center for Genomic Epidemiology) identifies the allelic profile of bacterial samples by comparing genomic data against specific MLST schemes.
homepage: https://bitbucket.org/genomicepidemiology/mlst
---

# mlst-cge

## Overview
The `mlst` tool (from the Center for Genomic Epidemiology) identifies the allelic profile of bacterial samples by comparing genomic data against specific MLST schemes. This skill provides the necessary command-line patterns to execute the tool, manage the required databases, and interpret the resulting sequence type assignments.

## Database Setup
Before running the analysis, the MLST database must be downloaded and configured.
```bash
# Download the database to a specific directory
git clone https://bitbucket.org/genomicepidemiology/mlst_db.git
cd mlst_db
python3 install_update_pack.py
```

## Common CLI Patterns

### Analyzing Assembled Genomes (Fasta)
Use this pattern when you have a completed assembly (e.g., from SPAdes or SKESA).
```bash
python3 mlst.py -i input_assembly.fa -o output_directory -p mlst_db -s species_name
```

### Analyzing Raw Reads (FastQ)
Use this pattern to map raw reads directly to the MLST alleles.
```bash
python3 mlst.py -i read1.fq.gz read2.fq.gz -o output_directory -p mlst_db -s species_name
```

### Key Arguments
- `-i`: Input file(s). Can be one Fasta file or two FastQ files (paired-end).
- `-o`: Output directory where results and temporary files are stored.
- `-p`: Path to the MLST database directory.
- `-s`: The species/organism schema to use (e.g., `ecoli`, `saureus`).
- `-t`: (Optional) Path to temporary directory.
- `-q`: (Optional) Disable automatic lookup of the database.

## Best Practices
- **Species Selection**: Ensure the `-s` argument matches the exact naming convention used in the MLST database. You can list available schemes by looking at the subdirectories within the `mlst_db` folder.
- **Input Quality**: For raw read input, ensure adapters have been trimmed and low-quality bases removed to improve mapping accuracy to the alleles.
- **Output Interpretation**: The primary result is found in `results_tab.txt` or `results.json`. If a "New ST" or "Unknown" is reported, check if all seven housekeeping genes were successfully identified with 100% identity.

## Reference documentation
- [Bitbucket Source and Documentation](./references/bitbucket_org_genomicepidemiology_mlst.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mlst-cge_overview.md)