# mquad CWL Generation Report

## mquad

### Tool Description
mquad

### Metadata
- **Docker Image**: quay.io/biocontainers/mquad:0.1.8b--pyhdfd78af_0
- **Homepage**: https://github.com/aaronkwc/MQuad
- **Package**: https://anaconda.org/channels/bioconda/packages/mquad/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mquad/overview
- **Total Downloads**: 435
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/aaronkwc/MQuad
- **Stars**: N/A
### Original Help Text
```text
Usage: mquad [options]

Options:
  -h, --help            show this help message and exit
  -c CELL_DATA, --cellData=CELL_DATA
                        The cellSNP folder with AD and DP sparse matrices.
  -o OUT_DIR, --outDir=OUT_DIR
                        Dirtectory for output files [default:
                        $cellData/mitoMut]
  --vcfData=VCF_DATA    The cell genotype file in VCF format

  Alternative input formats:
    -m MTX_DATA, --mtxData=MTX_DATA
                        The two mtx files for AD and DP matrices, comma
                        separated
    --BICparams=BIC_PARAMS, --b=BIC_PARAMS
                        Existing unsorted_debug_BIC_params.csv
    --tenx=CUTOFF, --t=CUTOFF
                        User-defined deltaBIC cutoff mainly for low-depth data

  Optional arguments:
    --randSeed=RAND_SEED
                        Seed for random initialization [default: none]
    -p NPROC, --nproc=NPROC
                        Number of subprocesses [default: 1]
    --minDP=MINDP       Minimum DP to include for modelling [default: 10]
    --minCell=MINCELL   Minimum no. of cells in minor component [default: 2]
    --batchFit=BATCH_FIT
                        1 if fit MixBin model using batch mode, 0 else
                        [default: 1]
    --batchSize=BATCH_SIZE
                        Number of variants in one batch, cooperate with
                        --nproc for speeding up [default: 128]
    --beta=BETA_MODE    Use betabinomial model if True [default: 0]
```

