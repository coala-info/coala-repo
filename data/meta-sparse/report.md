# meta-sparse CWL Generation Report

## meta-sparse_sparse

### Tool Description
Strain Prediction and Analysis with Representative SEquences

### Metadata
- **Docker Image**: quay.io/biocontainers/meta-sparse:0.1.12--py27h24bf2e0_0
- **Homepage**: https://github.com/zheminzhou/SPARSE/
- **Package**: https://anaconda.org/channels/bioconda/packages/meta-sparse/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/meta-sparse/overview
- **Total Downloads**: 17.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/zheminzhou/SPARSE
- **Stars**: N/A
### Original Help Text
```text
Program: SPARSE (Strain Prediction and Analysis with Representative SEquences)

Usage:   SPARSE.py <command> [options]

Commands:
  init          Create empty folder structures for a new SPARSE database
  index         Load in a list of assemblies (in RefSeq format) and index them into a SPARSE database
  query         Query metadata info in a SPARSE database
  update        Update metadata info in a SPARSE database
  mapDB         Create bowtie2 or MALT sub-databases for metagenomic reads
  predict       Align reads onto MapDB and do taxonomic predictions, and save all outputs in a specified workspaces
  mash          Compare an assembly with all genomes in a SPARSE database using MASH
  extract       Extract species-specific reads from a SPARSE read-mapping result
  report        Reformat and merge multiple SPARSE workspaces into a flat table. It also predicts human pathogens. 

Use SPARSE.py <command> -h to get help for each command.
```

