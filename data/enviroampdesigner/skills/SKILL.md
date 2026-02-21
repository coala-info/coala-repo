---
name: enviroampdesigner
description: EnviroAmpDesigner is a specialized bioinformatics tool tailored for Oxford Nanopore (ONT) amplicon sequencing.
homepage: https://github.com/AntonS-bio/EnviroAmpDesigner
---

# enviroampdesigner

## Overview
EnviroAmpDesigner is a specialized bioinformatics tool tailored for Oxford Nanopore (ONT) amplicon sequencing. It automates the process of finding SNPs that uniquely identify specific genotypes and then designs primers optimized for environmental samples. By comparing target sequences against a "negative" set of non-target assemblies, it ensures high specificity even in complex microbial backgrounds.

## Core Workflows

### 1. SNP Identification Only
To identify and report the number of SNPs that differentiate genotypes without designing primers:
```bash
python run.py -m SNP -c config.json
```

### 2. Full Amplicon Design
To identify SNPs and attempt to design amplicons for those SNPs:
```bash
python run.py -m Amplicon -c config.json
```

## Configuration (config.json)
The tool relies on a JSON configuration file. Key fields include:

- **reference_fasta**: The reference sequence used for VCF mapping.
- **vcf_dir**: Directory containing VCF files for the target organism.
- **meta_data_file**: A delimited file mapping sample names to genotypes.
- **genotype_column**: The header name in the metadata file containing genotype values.
- **hierarchy_file**: A JSON file defining relationships between genotypes.
- **negative_genomes**: Directory containing assemblies of organisms the primers should NOT target.
- **flank_len_to_check**: Length (e.g., 500) upstream/downstream of SNPs to check for homologues.

## Expert Tips and Best Practices

### Iterative Design Process
Multiplex panel design is rarely a single-step process. Follow this workflow for optimal results:
1. **Initial Run**: Run the tool with all target genotypes and their descendants.
2. **Selection**: Filter the output for primers with similar melting temperatures (Tm) and lengths.
3. **Lab Validation**: Test the selected primers in the lab.
4. **Refinement**: For failed targets, rerun the tool while relaxing parameters:
   - Decrease `snp_specificity` or `snp_sensitivity` (values 0-100).
   - Increase `max_matching_negative_genomes`.
   - Adjust `flank_len_to_check`.

### Handling Complex Genotypes
If specific genotypes (e.g., "3.2.1") are yielding poor results because the tool is trying to capture multiple genotypes at once, use the `gts_with_few_snps` field:
```json
"gts_with_few_snps": ["3.2.1", "4.3.1"]
```
This forces the tool to use all available SNPs for those specific genotypes rather than a subset.

### Specificity Optimization
The tool's primary strength is placing the 3' end of at least one primer at a site where the target differs from non-target organisms. This significantly reduces "background" amplification in environmental samples. Ensure your `negative_genomes` directory is comprehensive (e.g., including other Enterobacterales when targeting Salmonella).

## Reference documentation
- [EnviroAmpDesigner GitHub README](./references/github_com_AntonS-bio_EnviroAmpDesigner.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_enviroampdesigner_overview.md)