# genepender CWL Generation Report

## genepender

### Tool Description
Appends a new column containing gene names, whilst filtering out intergenic regions (i.e. where there are no genes), and can also optionally filter out introns.

### Metadata
- **Docker Image**: quay.io/biocontainers/genepender:v2.6--h470a237_1
- **Homepage**: https://github.com/BioTools-Tek/genepender
- **Package**: https://anaconda.org/channels/bioconda/packages/genepender/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genepender/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BioTools-Tek/genepender
- **Stars**: N/A
### Original Help Text
```text
2.6v20170522

Appends a new column containing gene names, whilst filtering out intergenic regions (i.e. where there are no genes), and can also optionally filter out introns.

Usage: genepender <genemap> <[VCFS]> <[OPTIONS]

where a <column file> is any file which has a <chr>[TAB]<index>[TAB]<etc...> layout.
Two files are created: one with a .genes.rejects.vcf suffix, and the other with a .genes.vcf suffix at the source directory

OPTIONS:
--keepall	Also keeps variants that only fall within intron/intergenic regions.
--force		Forces reprocessing even if VCF header present in either in/out file
--output-folder=<name>	Root output folder, source folder otherwise
--prefix-extract=<name>	Preserves directory structure starting from prefix value. Dumped into root of output folder otherwise.
```

