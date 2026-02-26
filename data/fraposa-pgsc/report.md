# fraposa-pgsc CWL Generation Report

## fraposa-pgsc_fraposa

### Tool Description
Performs Principal Component Analysis (PCA) prediction using reference and study samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/fraposa-pgsc:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/fraposa_pgsc
- **Package**: https://anaconda.org/channels/bioconda/packages/fraposa-pgsc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fraposa-pgsc/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PGScatalog/fraposa_pgsc
- **Stars**: N/A
### Original Help Text
```text
usage: fraposa [-h] [--stu_filepref STU_FILEPREF]
               [--stu_filt_iid STU_FILT_IID] [--method METHOD]
               [--dim_ref DIM_REF] [--dim_stu DIM_STU]
               [--dim_online DIM_ONLINE] [--dim_rand DIM_RAND]
               [--dim_spikes DIM_SPIKES] [--dim_spikes_max DIM_SPIKES_MAX]
               [--out OUT]
               ref_filepref

positional arguments:
  ref_filepref          Prefix of the binary PLINK file for the reference
                        samples.

options:
  -h, --help            show this help message and exit
  --stu_filepref STU_FILEPREF
                        Prefix of the binary PLINK file for the study samples.
  --stu_filt_iid STU_FILT_IID
                        File with list of FIDs and IIDs to extract from the
                        study file (bim format)
  --method METHOD       The method for PCA prediction. oadp: most accurate.
                        adp: accurate but slow. sp: fast but inaccurate.
                        Default is odap.
  --dim_ref DIM_REF     Number of PCs you need.
  --dim_stu DIM_STU     Number of PCs predicted for the study samples before
                        doing the Procrustes transformation. Only needed for
                        the oadp and adp methods. Default is 2*dim_ref.
  --dim_online DIM_ONLINE
                        Number of PCs to calculate in online SVD. Only needed
                        for the oadp method. Default is 2*dim_stu
  --dim_rand DIM_RAND   Number of reference PCs to calculate when using
                        randomized online SVD
  --dim_spikes DIM_SPIKES
                        Number of PCs to adjust for shrinkage. Only needed for
                        the ap method. If this argument is not set,
                        dim_spikes_max will be used.
  --dim_spikes_max DIM_SPIKES_MAX
                        The maximal number of PCs to adjust for shrinkage.
                        Only needed for the ap method. This argument will be
                        ignored if dim_spikes is set. Default is 4*dim_ref.
  --out OUT             Prefix of output file(s). Default is stu_filepref
```


## fraposa-pgsc_fraposa_pred

### Tool Description
Predicts the genetic risk score for a study population based on a reference population.

### Metadata
- **Docker Image**: quay.io/biocontainers/fraposa-pgsc:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/fraposa_pgsc
- **Package**: https://anaconda.org/channels/bioconda/packages/fraposa-pgsc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fraposa_pred [-h] [--nneighbors NNEIGHBORS] [--weights WEIGHTS]
                    ref_filepref stu_filepref

positional arguments:
  ref_filepref          Prefix of binary PLINK file for the reference data.
  stu_filepref          Prefix of binary PLINK file for the study data.

options:
  -h, --help            show this help message and exit
  --nneighbors NNEIGHBORS
                        The number of neighbors for each study sample. Default
                        is 20.
  --weights WEIGHTS     The method for calculating the weights in the nearest
                        neighbor method. uniform: each neighbor receives the
                        same weight; distance: the weight of each neighbor is
                        inversly proportional to its distance from the study
                        sample. Default is uniform.
```


## fraposa-pgsc_fraposa_plot

### Tool Description
Plots the results of FRA-POSA.

### Metadata
- **Docker Image**: quay.io/biocontainers/fraposa-pgsc:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/PGScatalog/fraposa_pgsc
- **Package**: https://anaconda.org/channels/bioconda/packages/fraposa-pgsc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fraposa_plot [-h] ref_filepref stu_filepref

positional arguments:
  ref_filepref  Prefix of binary PLINK file for the reference data.
  stu_filepref  Prefix of binary PLINK file for the study data.

options:
  -h, --help    show this help message and exit
```

