---
name: vcf_parser
description: The `vcf_parser` skill enables efficient handling of genomic variant data.
homepage: https://github.com/moonso/vcf_parser
---

# vcf_parser

## Overview
The `vcf_parser` skill enables efficient handling of genomic variant data. It provides a lightweight, dictionary-based interface for navigating complex VCF structures. Use this skill when you need to decompose multiallelic sites into individual records, access genotype-specific attributes (like zygosity or depth), or generate new VCF files with custom metadata and info fields.

## Installation
Install via bioconda or pip:
```bash
conda install bioconda::vcf_parser
# OR
pip install vcf_parser
```

## Command Line Usage
The primary CLI function is splitting multiallelic lines into separate variant lines:
```bash
vcf_parser input.vcf --split > output.vcf
```

## Python API Best Practices

### Initializing the Parser
Always specify `split_variants=True` if you need to handle multiallelic sites as individual entries.
```python
from vcf_parser import VCFParser

my_parser = VCFParser(infile='data.vcf', split_variants=True, check_info=True)
for variant in my_parser:
    # variant is a dictionary
    print(variant['CHROM'], variant['POS'], variant['REF'], variant['ALT'])
```

### Accessing Genotypes
Genotypes are stored in a dictionary of objects. Useful attributes include:
- `.gt`: The genotype string (e.g., '0/1')
- `.heterozygote`: Boolean
- `.homo_alt`: Boolean
- `.has_variant`: Boolean (called and not homo_ref)
- `.ref_depth` / `.alt_depth`: Integer depths

```python
for variant in my_parser:
    proband_gt = variant['genotypes']['proband']
    if proband_gt.has_variant:
        print(f"Variant found with quality: {proband_gt.genotype_quality}")
```

### Handling VEP Annotations
If the VCF contains VEP info, `vcf_parser` automatically parses the CSQ field into `variant['vep_info']`, keyed by the alternative allele.
```python
# Accessing VEP info for a specific allele
vep_data = variant['vep_info'].get(variant['ALT'], {})
gene_symbol = vep_data.get('SYMBOL')
consequence = vep_data.get('Consequence')
```

### Building VCFs from Scratch
To create a new VCF, initialize with a fileformat and add metadata before records.
```python
my_vcf = VCFParser(fileformat='VCFv4.2')

# Add Metadata
my_vcf.metadata.add_info(info_id='MQ', number='1', entry_type='Float', description="Mapping Quality")
my_vcf.metadata.add_filter(filter_id="PASS", description="All filters passed")

# Print Header
for line in my_vcf.metadata.print_header():
    print(line)
```

## Expert Tips
- **Memory Efficiency**: The parser iterates through the file; for very large VCFs, process variants within the loop rather than converting the parser to a list.
- **Dictionary Access**: Standard VCF fields (CHROM, POS, ID, REF, ALT, QUAL, FILTER) are accessible directly as keys in the variant dictionary.
- **INFO Field**: Use `variant['info_dict']` to get a dictionary where keys are info IDs and values are lists of values (split by commas).

## Reference documentation
- [VCF Parser GitHub Repository](./references/github_com_moonso_vcf_parser.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_vcf_parser_overview.md)