# piscem-infer CWL Generation Report

## piscem-infer_quant

### Tool Description
quantify from the rad file

### Metadata
- **Docker Image**: quay.io/biocontainers/piscem-infer:0.7.0--h090f6cf_0
- **Homepage**: https://github.com/COMBINE-lab/piscem-infer
- **Package**: https://anaconda.org/channels/bioconda/packages/piscem-infer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/piscem-infer/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-07-20
- **GitHub**: https://github.com/COMBINE-lab/piscem-infer
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
quantify from the rad file

Usage: piscem-infer quant [OPTIONS] --input <INPUT> --lib-type <LIB_TYPE> --output <OUTPUT>

Options:
  -i, --input <INPUT>
          input stem (i.e. without the .rad suffix)
  -l, --lib-type <LIB_TYPE>
          the expected library type
  -o, --output <OUTPUT>
          output file prefix (multiple output files may be created, the main will have a `.quant`
          suffix)
  -m, --max-iter <MAX_ITER>
          max iterations to run the EM [default: 1500]
      --convergence-thresh <CONVERGENCE_THRESH>
          convergence threshold for EM [default: 0.001]
      --presence-thresh <PRESENCE_THRESH>
          presence threshold for EM [default: 0.00000001]
      --param-est-frags <PARAM_EST_FRAGS>
          number of (unique) mappings to use to perform initial coarse-grained estimation of the
          fragment length distribution. These fragments will have to be read from the file and
          interrogated twice [default: 500000]
      --factorized-eqc-bins <FACTORIZED_EQC_BINS>
          number of probability bins to use in RangeFactorized equivalence classes. If this value is
          set to 1, then basic equivalence classes are used [default: 64]
      --fld-mean <FLD_MEAN>
          mean of fragment length distribution mean (required, and used, only in the case of
          unpaired fragments)
      --fld-sd <FLD_SD>
          mean of fragment length distribution standard deviation (required, and used, only in the
          case of unpaired fragments)
      --num-bootstraps <NUM_BOOTSTRAPS>
          number of bootstrap replicates to perform [default: 0]
      --num-threads <NUM_THREADS>
          number of threads to use (used during the EM and for bootstrapping) [default: 16]
  -h, --help
          Print help
  -V, --version
          Print version
```


## Metadata
- **Skill**: not generated
