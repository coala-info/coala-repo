# midas CWL Generation Report

## midas_run_midas.py

### Tool Description
Estimate species abundance and intra-species genomic variation from an individual metagenome

### Metadata
- **Docker Image**: quay.io/biocontainers/midas:1.3.2--py35_0
- **Homepage**: https://github.com/snayfach/MIDAS
- **Package**: https://anaconda.org/channels/bioconda/packages/midas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/midas/overview
- **Total Downloads**: 34.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/snayfach/MIDAS
- **Stars**: N/A
### Original Help Text
```text
Description: Estimate species abundance and intra-species genomic variation from an individual metagenome

Usage: run_midas.py <command> [options]

Commands:
	species	 estimate the abundance of 5,952 bacterial species
	genes	 quantify gene copy number variation in abundant species
	snps	 quantify single nucleotide variation in abundant species

Note: use run_midas.py <command> -h to view usage for a specific command
```


## midas_merge_midas.py

### Tool Description
merge MIDAS results across metagenomic samples

### Metadata
- **Docker Image**: quay.io/biocontainers/midas:1.3.2--py35_0
- **Homepage**: https://github.com/snayfach/MIDAS
- **Package**: https://anaconda.org/channels/bioconda/packages/midas/overview
- **Validation**: PASS

### Original Help Text
```text
Description: merge MIDAS results across metagenomic samples

Usage: merge_midas.py <command> [options]

Commands:
	species	 build species abundance matrix
	genes	 build pangenome matrix for each species
	snps	 perform multi-sample SNP calling and build SNP matrix for each species

Note: use merge_midas.py <command> -h to view usage for a specific command
```

