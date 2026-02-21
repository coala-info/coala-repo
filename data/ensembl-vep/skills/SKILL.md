---
name: ensembl-vep
description: The Ensembl Variant Effect Predictor (VEP) is a high-performance suite for genomic variant annotation.
homepage: https://www.ensembl.org/info/docs/tools/vep/index.html
---

# ensembl-vep

## Overview
The Ensembl Variant Effect Predictor (VEP) is a high-performance suite for genomic variant annotation. It maps coordinates to biological features and predicts the functional impact of changes (e.g., missense, frameshift, splice site disruption). This skill provides the procedural knowledge to execute VEP via the command line, optimize performance using caches, and extract specific biological insights from large-scale sequencing datasets.

## Common CLI Patterns

### Basic Annotation
Run a standard annotation on a VCF file using the local cache:
```bash
vep -i input.vcf -o output.txt --cache --offline --species homo_sapiens --assembly GRCh38
```

### Comprehensive Annotation
Use the `--everything` flag to include SIFT, PolyPhen, frequency data, and standard identifiers:
```bash
vep -i input.vcf --o output.vcf --vcf --cache --everything
```

### Filtering and Picking
To reduce redundancy in results (e.g., one consequence per variant), use the `--pick` flag:
```bash
vep -i input.vcf --cache --pick --o filtered_output.txt
```

### Performance Optimization
For large datasets, utilize multi-threading and the offline mode to bypass database connection overhead:
```bash
vep -i input.vcf --cache --offline --fork 4 --buffer_size 5000
```

## Expert Tips and Best Practices

- **Use Offline Mode**: Always prefer `--cache --offline` for production pipelines. It is significantly faster than querying the Ensembl database over the network.
- **Match Assemblies**: Ensure the `--assembly` flag (e.g., GRCh37 or GRCh38) matches the reference genome used for variant calling.
- **VCF Output**: Use the `--vcf` flag if you intend to use the output in downstream bioinformatics tools (like BCFtools or GATK), as the default VEP format is a custom tab-delimited format.
- **Plugin Usage**: For advanced scores like CADD, REVEL, or AlphaMissense, ensure the specific plugin and its required data files are installed and referenced via `--plugin`.
- **Custom Annotations**: Use the `--custom` flag to integrate your own BED, GFF, or BigWig files without rebuilding the cache.
- **Memory Management**: If running out of memory on large VCFs, decrease the `--buffer_size` (default is 5000).

## Reference documentation
- [Ensembl VEP Overview](./references/useast_ensembl_org_info_docs_tools_vep_index.html.md)
- [Bioconda ensembl-vep Package](./references/anaconda_org_channels_bioconda_packages_ensembl-vep_overview.md)