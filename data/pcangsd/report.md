# pcangsd CWL Generation Report

## pcangsd

### Tool Description
PCAngsd is a tool for analyzing low-depth next-generation sequencing data using principal component analysis (PCA) and related methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/pcangsd:1.36.4--py311h8ddd9a4_0
- **Homepage**: https://github.com/Rosemeis/pcangsd
- **Package**: https://anaconda.org/channels/bioconda/packages/pcangsd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pcangsd/overview
- **Total Downloads**: 897
- **Last updated**: 2025-07-16
- **GitHub**: https://github.com/Rosemeis/pcangsd
- **Stars**: N/A
### Original Help Text
```text
usage: pcangsd [-h] [--version] [-b FILE] [-p FILE-PREFIX] [-e INT] [-t INT]
               [-o OUTPUT] [--filter FILE] [--filter-sites FILE]
               [--geno-error FLOAT] [--maf FLOAT] [--maf-iter INT]
               [--maf-tole FLOAT] [--hwe FILE] [--hwe-tole FLOAT] [--iter INT]
               [--tole FLOAT] [--selection] [--snp-weights] [--pcadapt]
               [--selection-eig INT] [--inbreed-sites] [--inbreed-samples]
               [--inbreed-iter INT] [--inbreed-tole FLOAT] [--post]
               [--post-inbreed] [--geno FLOAT] [--geno-inbreed FLOAT]
               [--admix] [--admix-K INT] [--admix-iter INT]
               [--admix-tole FLOAT] [--admix-batch INT] [--admix-alpha FLOAT]
               [--admix-seed INT] [--admix-auto FLOAT] [--admix-depth INT]
               [--tree] [--tree-samples FILE] [--maf-save] [--pi-save]
               [--dosage-save] [--sites-save]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -b FILE, --beagle FILE
                        Filepath to genotype likelihoods in gzipped Beagle
                        format from ANGSD
  -p FILE-PREFIX, --plink FILE-PREFIX
                        Prefix PLINK files (.bed, .bim, .fam)
  -e INT, --eig INT     Manual selection of number of eigenvectors in
                        modelling
  -t INT, --threads INT
                        Number of threads (1)
  -o OUTPUT, --out OUTPUT
                        Prefix for output files
  --filter FILE         Input file of vector for filtering samples
  --filter-sites FILE   Input file of vector for filtering sites
  --geno-error FLOAT    Incorporate errors into genotypes (0.0)
  --maf FLOAT           Minimum minor allele frequency threshold (0.05)
  --maf-iter INT        Maximum iterations for minor allele frequencies
                        estimation - EM (500)
  --maf-tole FLOAT      Tolerance for minor allele frequencies estimation
                        update - EM (1e-6)
  --hwe FILE            Input file of LRTs from HWE test for site filtering
  --hwe-tole FLOAT      Tolerance for HWE filtering of sites (1e-6)
  --iter INT            Maximum iterations for estimation of individual allele
                        frequencies (100)
  --tole FLOAT          Tolerance for update in estimation of individual
                        allele frequencies (1e-5)
  --selection           Perform PC-based genome-wide selection scan
  --snp-weights         Estimate SNP weights
  --pcadapt             Perform pcadapt selection scan
  --selection-eig INT   Manual selection of number of eigenvectors in
                        selection scans/SNP weights
  --inbreed-sites       Compute the per-site inbreeding coefficients and LRT
  --inbreed-samples     Compute the per-sample inbreeding coefficients
  --inbreed-iter INT    Maximum iterations for inbreeding coefficients
                        estimation - EM (500)
  --inbreed-tole FLOAT  Tolerance for inbreeding coefficients estimation
                        update - EM (1e-5)
  --post                Save genotype posteriors
  --post-inbreed        Save genotype posteriors (inbreeding)
  --geno FLOAT          Call genotypes from posterior probabilities with
                        threshold
  --geno-inbreed FLOAT  Call genotypes (inbreeding) from posterior
                        probabilities with threshold
  --admix               Estimate admixture proportions and ancestral allele
                        frequencies
  --admix-K INT         Number of admixture components
  --admix-iter INT      Maximum number of iterations for admixture estimations
                        - NMF (500)
  --admix-tole FLOAT    Tolerance for admixture estimations - NMF (1e-5)
  --admix-batch INT     Number of mini-batches in stochastic admixture
                        estimations - NMF (10)
  --admix-alpha FLOAT   Alpha value for regularization in admixture
                        estimations - NMF (0.0)
  --admix-seed INT      Random seed used in admixture estimations - NMF (0)
  --admix-auto FLOAT    Enable automatic search for alpha by giving soft upper
                        search bound
  --admix-depth INT     Depth in automatic search of alpha (7)
  --tree                Construct NJ tree from covariance matrix
  --tree-samples FILE   List of sample names to create beautiful tree
  --maf-save            Save population allele frequencies
  --pi-save             Save individual allele frequencies
  --dosage-save         Save genotype dosages
  --sites-save          Save boolean vector of used sites
```


## Metadata
- **Skill**: generated
