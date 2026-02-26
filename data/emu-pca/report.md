# emu-pca CWL Generation Report

## emu-pca_emu

### Tool Description
Performs PCA on genotype data using an iterative method.

### Metadata
- **Docker Image**: quay.io/biocontainers/emu-pca:1.5.0--py310h20b60a1_0
- **Homepage**: https://github.com/Rosemeis/emu
- **Package**: https://anaconda.org/channels/bioconda/packages/emu-pca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/emu-pca/overview
- **Total Downloads**: 12.2K
- **Last updated**: 2025-12-13
- **GitHub**: https://github.com/Rosemeis/emu
- **Stars**: N/A
### Original Help Text
```text
usage: emu [-h] [--version] [-b FILE-PREFIX] [-e INT] [-t INT] [-f FLOAT] [-s]
           [-o OUTPUT] [-m] [--iter INT] [--tole FLOAT] [--power INT]
           [--batch INT] [--seed INT] [--eig-out INT] [--loadings] [--raw]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -b FILE-PREFIX, --bfile FILE-PREFIX
                        Prefix for PLINK files (.bed, .bim, .fam)
  -e INT, --eig INT     Number of eigenvectors to use in iterative estimation
  -t INT, --threads INT
                        Number of threads
  -f FLOAT, --maf FLOAT
                        Threshold for minor allele frequencies
  -s, --selection       Perform PC-based selection scan (Galinsky et al. 2016)
  -o OUTPUT, --out OUTPUT
                        Prefix output name
  -m, --mem             Memory-efficient variant
  --iter INT            Maximum iterations in estimation of individual allele
                        frequencies (100)
  --tole FLOAT          Tolerance in update for individual allele frequencies
                        (1e-5)
  --power INT           Number of power iterations in randomized SVD (11)
  --batch INT           Number of SNPs to use in batches of memory variant
                        (8192)
  --seed INT            Set random seed
  --eig-out INT         Number of eigenvectors to output in final SVD
  --loadings            Save SNP loadings
  --raw                 Raw output without '*.fam' info
```

