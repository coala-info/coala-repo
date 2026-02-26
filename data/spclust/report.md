# spclust CWL Generation Report

## spclust

### Tool Description
SpClust performs nucleotides sequences clustering using GMM.

### Metadata
- **Docker Image**: quay.io/biocontainers/spclust:28.5.19--h425c490_1
- **Homepage**: https://github.com/johnymatar/SpCLUST/
- **Package**: https://anaconda.org/channels/bioconda/packages/spclust/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/spclust/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/johnymatar/SpCLUST
- **Stars**: N/A
### Original Help Text
```text
SpClust performs nucleotides sequences clustering using GMM.

usage: mpispclust -in [input fasta file] -out [output clustering file] -alignMode [alignment mode] -mdist [scoring matrix]
   or: mpiexec -n [number of slave processes] spclust -in [input fasta file] -out [output clustering file] -alignMode [alignment mode] -mdist [scoring matrix]

Available scoring matrices are EDNAFULL, BLOSUM62, and PAM250. Defaults to EDNAFULL if not specified.
Available alignment modes are: fast, moderate, maxPrecision. fast and moderate limit the number of iterations for the alignment to 2 and 4 respectively (using MUSCLE). Defaults to maxPrecision if not specified.

Note: parameters are case sensitive, e.g. using -alignmode instead of -alignMode will cause this parameter to be disregarded, and using blosum62 instead of BLOSUM62 will be mentioned as an error.
```

