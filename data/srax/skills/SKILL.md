---
name: srax
description: sraX is a comprehensive tool for one-step resistome profiling of assembled sequence data.
homepage: https://github.com/lgpdevtools/sraX
---

# srax

## Overview

sraX is a comprehensive tool for one-step resistome profiling of assembled sequence data. It automates the identification of AMR determinants by creating local reference databases from public repositories (such as CARD, ARGminer, and BACMET) and aligning query genomes against them. The tool is particularly useful for researchers who need to move quickly from FASTA assemblies to interactive, visual results that describe the repertoire of antibiotic resistance genes (ARGs) and identify putative new variants through SNP analysis.

## Command Line Usage

### Basic Execution
The minimal requirement for sraX is a directory containing your assembled FASTA files.
```bash
sraX -i /path/to/input_genome_directory
```

### Extensive Analysis
To perform a more thorough search using multiple databases and stricter filtering:
```bash
sraX -i /path/to/input_dir -o /path/to/output_dir -db ext -s blastx -id 95 -c 90 -t 12
```

### Docker Usage
When using Docker, ensure you mount your local directories to the container's internal paths.
```bash
docker run --rm -v $(pwd)/genomes:/IN -v $(pwd)/results:/OUT lgpdevtools/srax -i IN -o OUT
```

## Parameter Reference

| Parameter | Description | Default |
| :--- | :--- | :--- |
| `-i` | **Mandatory**: Input directory containing individual FASTA assemblies. | N/A |
| `-o` | Output directory name. | Auto-generated |
| `-db` | Search level: `basic` (CARD only) or `ext` (CARD, ARGminer, BACMET). | basic |
| `-s` | Alignment algorithm: `dblastx` (DIAMOND) or `blastx` (NCBI). | dblastx |
| `-a` | MSA algorithm: `muscle`, `clustalo`, or `mafft`. | muscle |
| `-id` | Minimum identity percentage cutoff. | 85 |
| `-c` | Minimum alignment coverage percentage. | 60 |
| `-e` | E-value cutoff to filter false positives. | 1e-05 |
| `-t` | Number of threads for parallel processing. | 6 |
| `-u` | Path to a private/user-defined AMR database. | N/A |

## Expert Tips and Best Practices

- **Database Selection**: Use `-db ext` for comprehensive resistome profiling. The `basic` setting only utilizes the CARD database, while `ext` includes ARGminer and BACMET (biocides and metal resistance).
- **Performance**: For large datasets, stick with the default `-s dblastx`. DIAMOND is significantly faster than NCBI BLASTX for protein-to-DNA alignments.
- **Input Formatting**: Ensure the input directory contains individual files for each genome. sraX processes these in parallel (up to 100 files simultaneously).
- **SNP Analysis**: sraX automatically detects SNPs and provides graphical representations of mutated loci. Use a higher identity cutoff (`-id 95` or higher) if you are specifically looking for high-confidence variants.
- **Output Navigation**: The primary output is an HTML file. Open this in a web browser to access embedded plots and navigable tables of the identified resistome.
- **Verification**: Always verify your installation and dependencies by running `sraX -v` or using the provided `install_srax.sh` script in the source repository.

## Reference documentation
- [sraX GitHub Repository](./references/github_com_lgpdevtools_sraX.md)
- [sraX Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_srax_overview.md)