# plmc CWL Generation Report

## plmc

### Tool Description
Inference of evolutionary couplings from multiple sequence alignments using pseudolikelihood maximization.

### Metadata
- **Docker Image**: quay.io/biocontainers/plmc:20221105--hec16e2b_0
- **Homepage**: https://github.com/debbiemarkslab/plmc
- **Package**: https://anaconda.org/channels/bioconda/packages/plmc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plmc/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/debbiemarkslab/plmc
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
plmc

Usage:
      plm [options] alignmentfile
      plm -c couplingsfile alignmentfile
      plm -o paramfile -c couplingsfile alignmentfile
      plm [-h | --help]
      
    Required input:
      alignmentfile                    Multiple sequence alignment in FASTA format

    Options, input:
      -w  --weights    weightsfile     Load sequence weights from file (one weight per line)

    Options, output:
      -c  --couplings  couplingsfile   Save coupling scores to file (text)
      -o  --output     paramfile       Save estimated parameters to file (binary)
      --save-weights   weightsfile     Save sequence weights to file (text)

    Options, alignment processing:
      -s  --scale      <value>         Sequence weights: neighborhood weight [s > 0]
      -t  --theta      <value>         Sequence weights: neighborhood divergence [0 < t < 1]

    Options, Maximum a posteriori estimation (L-BFGS, default):
      -lh --lambdah    <value>         Set L2 lambda for fields (h_i)
      -le --lambdae    <value>         Set L2 lambda for couplings (e_ij)
      -lg --lambdag    <value>         Set group L1 lambda for couplings (e_ij)

    Options, general:
          --fast                       Fast weights and stochastic gradient descent
      -a  --alphabet   alphabet        Alternative character set to use for analysis
      -f  --focus      identifier      Select only uppercase, non-gapped sites from a focus sequence
      -g  --gapignore                  Model sequence likelihoods only by coding, non-gapped portions
      -m  --maxiter                    Maximum number of iterations
      -n  --ncores    [<number>|max]   Maximum number of threads to use in OpenMP
      -h  --help                       Usage
```


## Metadata
- **Skill**: generated

## plmc

### Tool Description
Inference of evolutionary couplings from multiple sequence alignments using pseudolikelihood maximization.

### Metadata
- **Docker Image**: quay.io/biocontainers/plmc:20221105--hec16e2b_0
- **Homepage**: https://github.com/debbiemarkslab/plmc
- **Package**: https://anaconda.org/channels/bioconda/packages/plmc/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
plmc

Usage:
      plm [options] alignmentfile
      plm -c couplingsfile alignmentfile
      plm -o paramfile -c couplingsfile alignmentfile
      plm [-h | --help]
      
    Required input:
      alignmentfile                    Multiple sequence alignment in FASTA format

    Options, input:
      -w  --weights    weightsfile     Load sequence weights from file (one weight per line)

    Options, output:
      -c  --couplings  couplingsfile   Save coupling scores to file (text)
      -o  --output     paramfile       Save estimated parameters to file (binary)
      --save-weights   weightsfile     Save sequence weights to file (text)

    Options, alignment processing:
      -s  --scale      <value>         Sequence weights: neighborhood weight [s > 0]
      -t  --theta      <value>         Sequence weights: neighborhood divergence [0 < t < 1]

    Options, Maximum a posteriori estimation (L-BFGS, default):
      -lh --lambdah    <value>         Set L2 lambda for fields (h_i)
      -le --lambdae    <value>         Set L2 lambda for couplings (e_ij)
      -lg --lambdag    <value>         Set group L1 lambda for couplings (e_ij)

    Options, general:
          --fast                       Fast weights and stochastic gradient descent
      -a  --alphabet   alphabet        Alternative character set to use for analysis
      -f  --focus      identifier      Select only uppercase, non-gapped sites from a focus sequence
      -g  --gapignore                  Model sequence likelihoods only by coding, non-gapped portions
      -m  --maxiter                    Maximum number of iterations
      -n  --ncores    [<number>|max]   Maximum number of threads to use in OpenMP
      -h  --help                       Usage
```

