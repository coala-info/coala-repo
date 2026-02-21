# pcaone CWL Generation Report

## pcaone

### Tool Description
FAIL to generate CWL: pcaone not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/pcaone:0.6.0--ha628be3_0
- **Homepage**: https://github.com/Zilong-Li/PCAone
- **Package**: https://anaconda.org/channels/bioconda/packages/pcaone/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pcaone/overview
- **Total Downloads**: 29.8K
- **Last updated**: 2025-09-22
- **GitHub**: https://github.com/Zilong-Li/PCAone
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: pcaone not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: pcaone not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## pcaone_PCAone

### Tool Description
PCA All In One: A tool for Principal Component Analysis on large-scale datasets, supporting various SVD methods and genomic data formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/pcaone:0.6.0--ha628be3_0
- **Homepage**: https://github.com/Zilong-Li/PCAone
- **Package**: https://anaconda.org/channels/bioconda/packages/pcaone/overview
- **Validation**: PASS
### Original Help Text
```text
PCA All In One (v0.6.0)        https://github.com/Zilong-Li/PCAone
(C) 2021-2024 Zilong Li        GNU General Public License v3

Usage: 1) use PLINK files as input and apply default window-based RSVD method
       $ PCAone -b plink 

       2) use CSV file as input and apply the Implicitly Restarted Arnoldi Method
       $ PCAone -c csv.zst -d 0 

       3) compute ancestry adjusted LD matrix and R2
       $ PCAone -b plink -k 2 -D -o adj 
       $ PCAone -B adj.residuals -f adj.mbim -R --ld-bp 1000


General options:
  -h, --help                     print all options including hidden advanced options
  -m, --memory arg (=0)          RAM usage in GB unit for out-of-core mode. default is in-core mode
  -n, --threads arg (=12)        the number of threads to be used
  -v, --verbose arg (=1)         verbosity level for logs. Options are
                                 0: silent, no messages on screen;
                                 1: concise messages to screen;
                                 2: more verbose information;
                                 3: enable debug information.

PCA algorithms:
  -d, --svd arg (=2)             SVD method to be applied. default 2 is recommended for big data. Options are
                                 0: the Implicitly Restarted Arnoldi Method (IRAM);
                                 1: the Yu's single-pass Randomized SVD with power iterations;
                                 2: the accurate window-based Randomized SVD method (PCAone);
                                 3: the full Singular Value Decomposition.
  -k, --pc arg (=10)             top k principal components (PCs) to be calculated
  -C, --scale arg (=0)           do scaling for input file. Options are
                                 0: do nothing and proceed to SVD;
                                 1: do only standardization;
                                 2: do count per median log transformation (CPMED);
                                 3: do log1p transformation;
                                 4: do relative counts.
  -p, --maxp arg (=20)           maximum number of power iterations for RSVD algorithm.
  -S, --no-shuffle               do not shuffle columns of data for --svd 2 (if not locally correlated).
  -w, --batches arg (=64)        the number of mini-batches used by --svd 2.
  --seed arg (=101)              seeds for reproducing results.
  --emu                          use EMU algorithm for genotype input with missingness.
  --pcangsd                      use PCAngsd algorithm for genotype likelihood input.
  --M arg (=0)                   the number of features (eg. SNPs) if already known.
  --N arg (=0)                   the number of samples if already known.
  --scale-factor arg (=1)        feature counts for each sample are normalized and multiplied by this value
  --buffer arg (=2)              memory buffer in GB unit for permuting the data.
  --imaxiter arg (=1000)         maximum number of IRAM iterations.
  --itol arg (=1e-06)            stopping tolerance for IRAM algorithm.
  --ncv arg (=20)                the number of Lanzcos basis vectors for IRAM.
  --oversamples arg (=10)        the number of oversampling columns for RSVD.
  --rand arg (=1)                the random matrix type. 0: uniform; 1: guassian.
  --maxiter arg (=100)           maximum number of EM iterations.
  --tol-rsvd arg (=0.0001)       tolerance for RSVD algorithm.
  --tol-em arg (=1e-05)          tolerance for EMU/PCAngsd algorithm.
  --tol-maf arg (=1e-06)         tolerance for MAF estimation by EM.

Input options:
  -b, --bfile arg                prefix of PLINK .bed/.bim/.fam files.
  --haploid                      the plink format represents haploid data.
  -B, --binary arg               path of binary file.
  -c, --csv arg                  path of comma seperated CSV file compressed by zstd.
  -g, --bgen arg                 path of BGEN file compressed by gzip/zstd.
  -G, --beagle arg               path of BEAGLE file compressed by gzip.
  -f, --match-bim arg            the .mbim file to be matched, where the 7th column is allele frequency.
  --USV arg                      prefix of PCAone .eigvecs/.eigvals/.loadings/.mbim.

Output options:
  -o, --out arg (=pcaone)        prefix of output files. default [pcaone].
  -V, --printv                   output the right eigenvectors with suffix .loadings.
  -D, --ld                       output a binary matrix for downstream LD related analysis.
  -R, --print-r2                 print LD R2 to *.ld.gz file for pairwise SNPs within a window controlled by --ld-bp.

Misc options:
  --maf arg (=0)                 exclude variants with MAF lower than this value
  --project arg (=0)             project the new samples onto the existing PCs. Options are
                                 0: disabled;
                                 1: by multiplying the loadings with mean imputation for missing genotypes;
                                 2: by solving the least squares system Vx=g. skip sites with missingness;
                                 3: by Augmentation, Decomposition and Procrusters transformation.
  --inbreed arg (=0)             compute the inbreeding coefficient accounting for population structure. Options are
                                 0: disabled;
                                 1: compute per-site inbreeding coefficient and HWE test.
  --ld-r2 arg (=0)               R2 cutoff for LD-based pruning (usually 0.2).
  --ld-bp arg (=0)               physical distance threshold in bases for LD window (usually 1000000).
  --ld-stats arg (=0)            statistics to compute LD R2 for pairwise SNPs. Options are
                                 0: the ancestry adjusted, i.e. correlation between residuals;
                                 1: the standard, i.e. correlation between two alleles.
  --clump arg                    assoc-like file with target variants and pvalues for clumping.
  --clump-names arg (=CHR,BP,P)  column names in assoc-like file for locating chr, pos and pvalue.
  --clump-p1 arg (=0.0001)       significance threshold for index SNPs.
  --clump-p2 arg (=0.01)         secondary significance threshold for clumped SNPs.
  --clump-r2 arg (=0.5)          r2 cutoff for LD-based clumping.
  --clump-bp arg (=250000)       physical distance threshold in bases for clumping.
```

